import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class ShineCraftBrandingFooter extends StatelessWidget {
  final Color textColor;
  final double fontSize;
  final double logoHeight;

  const ShineCraftBrandingFooter({
    super.key,
    this.textColor = AppColors.mutedText,
    this.fontSize = 14,
    this.logoHeight = 64,
  });

  Future<void> _launchWebsite() async {
    final uri = Uri.parse('https://www.shinecrafttechnologies.com/');
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _launchWebsite,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Crafted by ',
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            Image.asset(
              'assets/images/CompanyLogo.png',
              height: logoHeight,
              fit: BoxFit.contain,
              errorBuilder: (_, __, ___) => SvgPicture.asset(
                'assets/images/CompanyLogo.svg',
                height: logoHeight,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
