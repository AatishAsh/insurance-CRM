import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/security_service.dart';
import '../services/database_service.dart';

enum AuthStatus {
  uninitialized,
  setupRequired,
  locked,
  unlocked,
}

class AuthState {
  final AuthStatus status;
  final String errorMessage;

  AuthState({required this.status, this.errorMessage = ''});

  AuthState copyWith({AuthStatus? status, String? errorMessage}) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  final SecurityService _securityService;
  final DatabaseService _db;

  AuthNotifier(this._securityService, this._db) : super(AuthState(status: AuthStatus.uninitialized)) {
    checkPinStatus();
  }

  Future<void> checkPinStatus() async {
    final isSet = await _securityService.isPinSet();
    if (isSet) {
      state = AuthState(status: AuthStatus.locked);
    } else {
      state = AuthState(status: AuthStatus.setupRequired);
    }
  }

  Future<void> setPin(String pin) async {
    if (pin.length < 4) {
      state = state.copyWith(errorMessage: 'PIN must be at least 4 digits');
      return;
    }
    await _securityService.setPin(pin);
    // Run carry forward
    await _db.carryForwardIncompleteTasks(DateTime.now());
    state = AuthState(status: AuthStatus.unlocked);
  }

  Future<bool> unlock(String pin) async {
    final success = await _securityService.verifyPin(pin);
    if (success) {
      // Run carry forward
      await _db.carryForwardIncompleteTasks(DateTime.now());
      state = AuthState(status: AuthStatus.unlocked);
      return true;
    } else {
      state = state.copyWith(errorMessage: 'Incorrect PIN');
      return false;
    }
  }

  void lock() {
    // Only lock if we actually have a PIN configured
    _securityService.isPinSet().then((isSet) {
      if (isSet) {
        state = AuthState(status: AuthStatus.locked);
      }
    });
  }

  void resetError() {
    state = state.copyWith(errorMessage: '');
  }
}

final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final securityService = ref.read(securityServiceProvider);
  final db = ref.read(databaseServiceProvider);
  return AuthNotifier(securityService, db);
});

final isPickingFileProvider = StateProvider<bool>((ref) => false);
