import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/brand_background.dart';

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
      backgroundColor: AppColors.appBackground,
      body: BrandBackground(
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 400),
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.cardSurface,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: AppColors.cardBorder),
                  boxShadow: [AppColors.cardShadow],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Icon Container with Brand Gradient
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.skyBlue.withOpacity(0.12),
                            AppColors.limeGreen.withOpacity(0.12),
                          ],
                        ),
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.skyBlue.withOpacity(0.3), width: 1.5),
                      ),
                      child: const Icon(
                        Icons.lock_person_rounded,
                        size: 44,
                        color: AppColors.skyBlue,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // App Title
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                        children: [
                          TextSpan(text: 'SHINECRAFT ', style: TextStyle(color: AppColors.headingText)),
                          TextSpan(text: 'CRM', style: TextStyle(color: AppColors.skyBlue)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      isSetup ? 'Set up a 4-digit PIN to secure your data offline.' : 'Offline Client Vault',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.mutedText,
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Message State
                    Text(
                      _message,
                      style: TextStyle(
                        color: _hasError ? AppColors.roseAccent : AppColors.headingText,
                        fontSize: 15,
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
                                ? (_hasError ? AppColors.roseAccent : AppColors.limeGreen)
                                : Colors.transparent,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: _hasError
                                  ? AppColors.roseAccent
                                  : (filled ? AppColors.limeGreen : AppColors.cardBorder),
                              width: 2,
                            ),
                            boxShadow: filled && !_hasError
                                ? [
                                    BoxShadow(
                                      color: AppColors.limeGreen.withOpacity(0.4),
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
                              style: TextStyle(color: AppColors.mutedText, fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            onTap: _onClear,
                          );
                        }
                        if (index == 10) {
                          // Zero Key
                          return _buildKeypadButton(
                            child: const Text(
                              '0',
                              style: TextStyle(color: AppColors.headingText, fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            onTap: () => _onKeyPress(0),
                          );
                        }
                        if (index == 11) {
                          // Backspace Button
                          return _buildKeypadButton(
                            child: const Icon(Icons.backspace_outlined, color: AppColors.mutedText, size: 20),
                            onTap: _onBackspace,
                          );
                        }
                        // Number Keys 1-9
                        final num = index + 1;
                        return _buildKeypadButton(
                          child: Text(
                            '$num',
                            style: const TextStyle(color: AppColors.headingText, fontSize: 22, fontWeight: FontWeight.bold),
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
                        const Icon(Icons.shield_outlined, size: 14, color: AppColors.skyBlue),
                        const SizedBox(width: 6),
                        const Text(
                          'Crafted by Shine Craft Technologies',
                          style: TextStyle(
                            color: AppColors.mutedText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
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
      ),
    );
  }

  Widget _buildKeypadButton({required Widget child, required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        splashColor: AppColors.skyBlue.withOpacity(0.15),
        highlightColor: AppColors.limeGreen.withOpacity(0.1),
        child: Ink(
          decoration: BoxDecoration(
            color: AppColors.appBackgroundAlt,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.cardBorder, width: 1),
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
