import 'dart:ffi' show Abi;
import 'dart:io';

import 'package:customer_detail_management/models/company.dart';
import 'package:customer_detail_management/models/customer.dart';
import 'package:customer_detail_management/models/daily_note.dart';
import 'package:customer_detail_management/models/insurance_company.dart';
import 'package:customer_detail_management/models/marketing_lead.dart';
import 'package:customer_detail_management/models/performance_record.dart';
import 'package:customer_detail_management/models/work_task.dart';
import 'package:customer_detail_management/services/database_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_secure_storage_platform_interface/flutter_secure_storage_platform_interface.dart';
import 'package:isar/isar.dart';

import 'fake_secure_storage.dart';

/// All Isar schemas required to open the CRM database.
const List<CollectionSchema<dynamic>> crmSchemas = [
  CustomerSchema,
  CompanySchema,
  InsuranceCompanySchema,
  WorkTaskSchema,
  MarketingLeadSchema,
  PerformanceRecordSchema,
  DailyNoteSchema,
];

/// Loads the bundled Isar native library once (Linux host tests).
Future<void> initIsarCoreForTest() async {
  final override = Platform.environment['FLUTTER_TEST_ISAR_LIB_PATH'];
  final libPath = override ?? './libisar.so';
  await Isar.initializeIsarCore(
    download: false,
    libraries: {Abi.linuxX64: libPath},
  );
}

/// Opens a real, isolated Isar database in a temp directory.
Future<DatabaseContext> openTestDatabase() async {
  final tempDir = Directory.systemTemp.createTempSync('crm_test_');
  final isar = await Isar.open(
    crmSchemas,
    directory: tempDir.path,
  );
  return DatabaseContext(isar, tempDir);
}

/// Installs the in-memory secure storage platform so no keyring is touched.
FakeFlutterSecureStoragePlatform installFakeSecureStorage() {
  final fake = FakeFlutterSecureStoragePlatform();
  FlutterSecureStoragePlatform.instance = fake;
  return fake;
}

/// Mocks the path_provider platform channel so screens that resolve the
/// documents directory (AppStorageService, DatabaseService) don't throw
/// MissingPluginException inside widget tests.
Future<Directory> installPathProviderMock() async {
  final tempDir = Directory.systemTemp.createTempSync('crm_path_provider_');
  TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
      .setMockMethodCallHandler(
    const MethodChannel('plugins.flutter.io/path_provider'),
    (MethodCall call) async {
      if (call.method == 'getApplicationDocumentsDirectory' ||
          call.method == 'getApplicationSupportDirectory' ||
          call.method == 'getTemporaryDirectory' ||
          call.method == 'getDownloadsDirectory' ||
          call.method == 'getExternalStorageDirectory') {
        return tempDir.path;
      }
      throw MissingPluginException('No implementation for ${call.method} on path_provider');
    },
  );
  return tempDir;
}

/// Tiny holder pairing an open Isar with its temp dir for cleanup.
class DatabaseContext {
  final Isar isar;
  final Directory tempDir;

  DatabaseContext(this.isar, this.tempDir);

  DatabaseService get service => DatabaseService(isar);

  Future<void> close() async {
    await isar.close(deleteFromDisk: true);
    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }
}