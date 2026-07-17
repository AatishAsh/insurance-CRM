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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final isPicking = ref.read(isPickingFileProvider);
    if (isPicking) return;

    // When the app goes out of focus (paused or inactive), lock it.
    if (state == AppLifecycleState.paused || state == AppLifecycleState.inactive) {
      ref.read(authStateProvider.notifier).lock();
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
        return widget.child;
    }
  }
}
