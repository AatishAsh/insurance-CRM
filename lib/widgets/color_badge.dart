import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

enum BadgeStyle {
  blue,
  green,
  mint,
  cyan,
  violet,
  amber,
  rose,
  indigo,
  orange,
}

/// Light, tinted background tags with bright text for vibrant light theme badges.
class ColorBadge extends StatelessWidget {
  final String text;
  final IconData? icon;
  final BadgeStyle style;
  final EdgeInsetsGeometry padding;

  const ColorBadge({
    super.key,
    required this.text,
    this.icon,
    this.style = BadgeStyle.blue,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;

    switch (style) {
      case BadgeStyle.blue:
        bg = AppColors.badgeBlueBg;
        fg = AppColors.badgeBlueText;
        break;
      case BadgeStyle.green:
      case BadgeStyle.mint:
        bg = AppColors.badgeGreenBg;
        fg = AppColors.badgeGreenText;
        break;
      case BadgeStyle.cyan:
        bg = AppColors.badgeCyanBg;
        fg = AppColors.badgeCyanText;
        break;
      case BadgeStyle.violet:
        bg = AppColors.badgeVioletBg;
        fg = AppColors.badgeVioletText;
        break;
      case BadgeStyle.amber:
        bg = AppColors.badgeAmberBg;
        fg = AppColors.badgeAmberText;
        break;
      case BadgeStyle.rose:
        bg = AppColors.badgeRoseBg;
        fg = AppColors.badgeRoseText;
        break;
      case BadgeStyle.indigo:
        bg = AppColors.badgeIndigoBg;
        fg = AppColors.badgeIndigoText;
        break;
      case BadgeStyle.orange:
        bg = AppColors.badgeOrangeBg;
        fg = AppColors.badgeOrangeText;
        break;
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: fg),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              color: fg,
              fontWeight: FontWeight.bold,
              fontSize: 11.5,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
