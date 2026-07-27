import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class SecurityLockScreen extends ConsumerStatefulWidget {
  const SecurityLockScreen({super.key});

  @override
  ConsumerState<SecurityLockScreen> createState() => _SecurityLockScreenState();
}

class _SecurityLockScreenState extends ConsumerState<SecurityLockScreen> {
  final List<int> _digits = [];
  String _firstEntry = ''; // For PIN setup confirmation
  bool _isConfirming = false;
  String _message = 'Enter Security PIN';
  bool _hasError = false;

  void _onKeyPress(int number) {
    if (_digits.length >= 6) return; // Cap at 6 digits
    setState(() {
      _digits.add(number);
      _hasError = false;
    });
    ref.read(authStateProvider.notifier).resetError();
    _checkInput();
  }

  void _onBackspace() {
    if (_digits.isNotEmpty) {
      setState(() {
        _digits.removeLast();
        _hasError = false;
      });
      ref.read(authStateProvider.notifier).resetError();
    }
  }

  void _onClear() {
    setState(() {
      _digits.clear();
      _hasError = false;
    });
    ref.read(authStateProvider.notifier).resetError();
  }

  void _checkInput() async {
    final authState = ref.read(authStateProvider);
    final isSetup = authState.status == AuthStatus.setupRequired;

    // Trigger check when 4 or more digits are entered (let's use 4 digits as standard, or 4-6)
    // For convenience, we will expect a 4-digit PIN.
    if (_digits.length == 4) {
      final pin = _digits.join();
      
      if (isSetup) {
        if (!_isConfirming) {
          // Store first entry and ask for confirmation
          setState(() {
            _firstEntry = pin;
            _isConfirming = true;
            _digits.clear();
            _message = 'Confirm Security PIN';
          });
        } else {
          // Confirm PIN
          if (pin == _firstEntry) {
            await ref.read(authStateProvider.notifier).setPin(pin);
          } else {
            setState(() {
              _isConfirming = false;
              _firstEntry = '';
              _digits.clear();
              _message = 'PINs did not match. Enter New PIN';
              _hasError = true;
            });
          }
        }
      } else {
        // Unlock
        final success = await ref.read(authStateProvider.notifier).unlock(pin);
        if (!success) {
          setState(() {
            _digits.clear();
            _message = 'Incorrect PIN. Try Again.';
            _hasError = true;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final isSetup = authState.status == AuthStatus.setupRequired;

    // If setup and not yet set message
    if (isSetup && _message == 'Enter Security PIN') {
      _message = 'Create Security PIN';
    }

    return Scaffold(
      backgroundColor: const Color(0xFF1E1E2C), // Sleek Dark Premium Background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Icon
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.1),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.blueAccent.withOpacity(0.3), width: 2),
                    ),
                    child: const Icon(
                      Icons.lock_person_rounded,
                      size: 48,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // App Title
                  const Text(
                    'SHINECRAFT CRM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    isSetup ? 'Set up a 4-digit PIN to secure your data offline.' : 'Offline Client Vault',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Message State
                  Text(
                    _message,
                    style: TextStyle(
                      color: _hasError ? Colors.redAccent : Colors.white70,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // PIN Dots Display
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(4, (index) {
                      final filled = index < _digits.length;
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: filled
                              ? (_hasError ? Colors.redAccent : Colors.blueAccent)
                              : Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: _hasError
                                ? Colors.redAccent
                                : (filled ? Colors.blueAccent : Colors.grey[600]!),
                            width: 2,
                          ),
                          boxShadow: filled && !_hasError
                              ? [
                                  BoxShadow(
                                    color: Colors.blueAccent.withOpacity(0.5),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  )
                                ]
                              : null,
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 24),
                  // Keypad
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.35,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      if (index == 9) {
                        // Clear Button
                        return _buildKeypadButton(
                          child: const Text(
                            'C',
                            style: TextStyle(color: Colors.grey, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          onTap: _onClear,
                        );
                      }
                      if (index == 10) {
                        // Zero Key
                        return _buildKeypadButton(
                          child: const Text(
                            '0',
                            style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          onTap: () => _onKeyPress(0),
                        );
                      }
                      if (index == 11) {
                        // Backspace Button
                        return _buildKeypadButton(
                          child: const Icon(Icons.backspace_outlined, color: Colors.grey, size: 22),
                          onTap: _onBackspace,
                        );
                      }
                      // Number Keys 1-9
                      final num = index + 1;
                      return _buildKeypadButton(
                        child: Text(
                          '$num',
                          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        onTap: () => _onKeyPress(num),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  // Footer Branding
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.code_rounded, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 6),
                      Text(
                        'Crafted by Shine Craft Technologies',
                        style: TextStyle(
                          color: Colors.grey[400],
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildKeypadButton({required Widget child, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        splashColor: Colors.blueAccent.withOpacity(0.2),
        highlightColor: Colors.blueAccent.withOpacity(0.1),
        child: Ink(
          decoration: BoxDecoration(
            color: const Color(0xFF2E2E3E), // Darker tiles
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFF3E3E52), width: 1),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
