import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

/// Centralized service managing software document storage across Windows/Linux Desktop & Android APK
class AppStorageService {
  static Directory? _cachedDocsDir;

  /// Gets or creates the software's local documents directory.
  /// - On Android APK: Uses external storage directory so uploaded documents/photos
  ///   are physically saved and accessible in the Android File Manager.
  /// - On Desktop (Windows/Linux/macOS): Uses the system Documents folder (`Documents/customer_documents`).
  static Future<Directory> getCustomerDocumentsDirectory() async {
    if (_cachedDocsDir != null && await _cachedDocsDir!.exists()) {
      return _cachedDocsDir!;
    }

    Directory baseDir;
    if (!kIsWeb && Platform.isAndroid) {
      // On Android APK, use external storage directory so files are visible in Android File Manager
      final extDir = await getExternalStorageDirectory();
      baseDir = extDir ?? await getApplicationDocumentsDirectory();
    } else {
      // On Windows/Linux/macOS desktop, use application documents directory
      baseDir = await getApplicationDocumentsDirectory();
    }

    final docsDir = Directory('${baseDir.path}/customer_documents');
    if (!await docsDir.exists()) {
      await docsDir.create(recursive: true);
    }
    _cachedDocsDir = docsDir;
    return docsDir;
  }

  /// Copies and saves an uploaded document/photo into the software's local documents folder.
  /// Uses a robust fallback (readAsBytes & writeAsBytes) to ensure binary data is 100% saved
  /// even across different file systems or temporary file permissions.
  static Future<File> saveDocumentLocally(File srcFile, String localFileName) async {
    final docsDir = await getCustomerDocumentsDirectory();
    final targetPath = '${docsDir.path}/$localFileName';

    try {
      return await srcFile.copy(targetPath);
    } catch (_) {
      // Fallback if cross-filesystem copy fails
      final bytes = await srcFile.readAsBytes();
      final targetFile = File(targetPath);
      await targetFile.writeAsBytes(bytes, flush: true);
      return targetFile;
    }
  }
}
