import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/brand_background.dart';
import '../widgets/shinecraft_branding_footer.dart';

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
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

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

    // Trigger check when 4 or more digits are entered
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
      body: Focus(
        focusNode: _focusNode,
        autofocus: true,
        onKeyEvent: (node, event) {
          if (event is KeyDownEvent) {
            final key = event.logicalKey;
            if (key == LogicalKeyboardKey.digit0 || key == LogicalKeyboardKey.numpad0) {
              _onKeyPress(0);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit1 || key == LogicalKeyboardKey.numpad1) {
              _onKeyPress(1);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit2 || key == LogicalKeyboardKey.numpad2) {
              _onKeyPress(2);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit3 || key == LogicalKeyboardKey.numpad3) {
              _onKeyPress(3);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit4 || key == LogicalKeyboardKey.numpad4) {
              _onKeyPress(4);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit5 || key == LogicalKeyboardKey.numpad5) {
              _onKeyPress(5);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit6 || key == LogicalKeyboardKey.numpad6) {
              _onKeyPress(6);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit7 || key == LogicalKeyboardKey.numpad7) {
              _onKeyPress(7);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit8 || key == LogicalKeyboardKey.numpad8) {
              _onKeyPress(8);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.digit9 || key == LogicalKeyboardKey.numpad9) {
              _onKeyPress(9);
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.backspace || key == LogicalKeyboardKey.delete) {
              _onBackspace();
              return KeyEventResult.handled;
            } else if (key == LogicalKeyboardKey.keyC || key == LogicalKeyboardKey.escape) {
              _onClear();
              return KeyEventResult.handled;
            }
          }
          return KeyEventResult.ignored;
        },
        child: BrandBackground(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
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
                      // Software Logo Image
                      Image.asset(
                        'assets/images/logo.png',
                        height: 44,
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => Container(
                          padding: const EdgeInsets.all(12),
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
                            size: 36,
                            color: AppColors.skyBlue,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // App Title
                      RichText(
                        text: const TextSpan(
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                          children: [
                            TextSpan(text: 'JJ ', style: TextStyle(color: AppColors.headingText)),
                            TextSpan(text: 'CRM', style: TextStyle(color: AppColors.skyBlue)),
                          ],
                        ),
                      ),
                      if (isSetup) ...[
                        const SizedBox(height: 4),
                        const Text(
                          'Set up a 4-digit PIN to secure your data offline.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.mutedText,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      const SizedBox(height: 12),
                      // Message State
                      Text(
                        _message,
                        style: TextStyle(
                          color: _hasError ? AppColors.roseAccent : AppColors.headingText,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // PIN Dots Display
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(4, (index) {
                          final filled = index < _digits.length;
                          return Container(
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            width: 14,
                            height: 14,
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
                      const SizedBox(height: 14),
                      // Keypad
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 1.5,
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
                      const SizedBox(height: 12),
                      // Footer Branding
                      const ShineCraftBrandingFooter(fontSize: 12, logoHeight: 44),
                    ],
                  ),
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
