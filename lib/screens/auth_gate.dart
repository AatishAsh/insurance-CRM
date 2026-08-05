import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import 'security_lock_screen.dart';

class AuthGate extends ConsumerStatefulWidget {
  final Widget child;
  const AuthGate({super.key, required this.child});

  @override
  ConsumerState<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends ConsumerState<AuthGate> with WidgetsBindingObserver {
  DateTime _lastActivityTime = DateTime.now();
  DateTime? _pausedTime;
  Timer? _idleTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _idleTimer = Timer.periodic(const Duration(seconds: 3), (_) => _checkIdleTimeout());
  }

  @override
  void dispose() {
    _idleTimer?.cancel();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  void _onUserActivity() {
    _lastActivityTime = DateTime.now();
  }

  void _checkIdleTimeout() {
    final authState = ref.read(authStateProvider);
    if (authState.status != AuthStatus.unlocked) return;

    final timeoutMinutes = ref.read(autoLockTimeoutProvider);
    if (timeoutMinutes == 0) return; // 0 = Never lock on idle

    final idleDuration = DateTime.now().difference(_lastActivityTime);
    if (idleDuration >= Duration(minutes: timeoutMinutes)) {
      ref.read(authStateProvider.notifier).lock();
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isPicking = ref.read(isPickingFileProvider);
    if (isPicking) return;

    if (state == AppLifecycleState.paused) {
      _pausedTime = DateTime.now();
    } else if (state == AppLifecycleState.resumed && _pausedTime != null) {
      final timeoutMinutes = ref.read(autoLockTimeoutProvider);
      if (timeoutMinutes > 0) {
        final elapsed = DateTime.now().difference(_pausedTime!);
        if (elapsed >= Duration(minutes: timeoutMinutes)) {
          ref.read(authStateProvider.notifier).lock();
        }
      }
      _pausedTime = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);

    switch (authState.status) {
      case AuthStatus.uninitialized:
        return const Scaffold(
          backgroundColor: Color(0xFF1E1E2C),
          body: Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          ),
        );
      case AuthStatus.setupRequired:
      case AuthStatus.locked:
        return const SecurityLockScreen();
      case AuthStatus.unlocked:
        return Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (_) => _onUserActivity(),
          onPointerMove: (_) => _onUserActivity(),
          onPointerHover: (_) => _onUserActivity(),
          onPointerSignal: (_) => _onUserActivity(),
          child: widget.child,
        );
    }
  }
}
