import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:url_launcher/url_launcher.dart';
import '../theme/app_colors.dart';

class ShineCraftBrandingFooter extends StatefulWidget {
  final Color textColor;
  final double fontSize;
  final double logoHeight;

  const ShineCraftBrandingFooter({
    super.key,
    this.textColor = AppColors.mutedText,
    this.fontSize = 14,
    this.logoHeight = 64,
  });

  @override
  State<ShineCraftBrandingFooter> createState() => _ShineCraftBrandingFooterState();
}

class _ShineCraftBrandingFooterState extends State<ShineCraftBrandingFooter> {
  bool _isHovered = false;

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
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
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
                color: widget.textColor,
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 4),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedScale(
                scale: _isHovered ? 1.12 : 1.0,
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOutCubic,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: _isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.skyBlue.withOpacity(0.12),
                              blurRadius: 4,
                              spreadRadius: 0,
                            )
                          ]
                        : [],
                  ),
                  child: Image.asset(
                    'assets/images/CompanyLogo.png',
                    height: widget.logoHeight,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => SvgPicture.asset(
                      'assets/images/CompanyLogo.svg',
                      height: widget.logoHeight,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
