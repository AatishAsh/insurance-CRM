import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Wraps page content with a clean off-white background and soft, colorful mesh glow circles.
class BrandBackground extends StatelessWidget {
  final Widget child;
  final bool showGlows;

  const BrandBackground({
    super.key,
    required this.child,
    this.showGlows = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appBackground,
      child: Stack(
        children: [
          if (showGlows) ...[
            // Top Right Soft Lime Green Mesh Glow Circle
            Positioned(
              top: -80,
              right: -60,
              child: Container(
                width: 260,
                height: 260,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.meshGlowGreen,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.75],
                  ),
                ),
              ),
            ),
            // Center Left Soft Sky Blue Mesh Glow Circle
            Positioned(
              top: 220,
              left: -80,
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.meshGlowBlue,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.8],
                  ),
                ),
              ),
            ),
            // Bottom Right Soft Cyan/Violet Mesh Glow Circle
            Positioned(
              bottom: -60,
              right: -40,
              child: Container(
                width: 240,
                height: 240,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.meshGlowCyan,
                      Colors.transparent,
                    ],
                    stops: [0.0, 0.75],
                  ),
                ),
              ),
            ),
          ],
          // Main Body Content
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}
