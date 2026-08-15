import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NavItemData {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Color activeColor;
  final Color activeBgColor;
  final Color activeTextColor;
  final String? badgeText;

  const NavItemData({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.activeColor,
    required this.activeBgColor,
    required this.activeTextColor,
    this.badgeText,
  });
}

/// A vibrant, colorful side navigation bar designed with brand colors and accent highlights.
class BrandSidenav extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;
  final bool isExpanded;

  static const List<NavItemData> navItems = [
    NavItemData(
      label: 'Dashboard',
      icon: Icons.grid_view_outlined,
      selectedIcon: Icons.grid_view_rounded,
      activeColor: AppColors.skyBlue,
      activeBgColor: AppColors.badgeBlueBg,
      activeTextColor: AppColors.badgeBlueText,
    ),
    NavItemData(
      label: 'Customers',
      icon: Icons.people_outline_rounded,
      selectedIcon: Icons.people_rounded,
      activeColor: AppColors.limeGreen,
      activeBgColor: AppColors.badgeGreenBg,
      activeTextColor: AppColors.badgeGreenText,
    ),
    NavItemData(
      label: 'Events',
      icon: Icons.event_outlined,
      selectedIcon: Icons.event_rounded,
      activeColor: AppColors.violetAccent,
      activeBgColor: AppColors.badgeVioletBg,
      activeTextColor: AppColors.badgeVioletText,
    ),
    NavItemData(
      label: 'Performance',
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics_rounded,
      activeColor: AppColors.cyanAccent,
      activeBgColor: AppColors.badgeCyanBg,
      activeTextColor: AppColors.badgeCyanText,
    ),
    NavItemData(
      label: 'Work',
      icon: Icons.assignment_outlined,
      selectedIcon: Icons.assignment_rounded,
      activeColor: AppColors.amberAccent,
      activeBgColor: AppColors.badgeAmberBg,
      activeTextColor: AppColors.badgeAmberText,
    ),
    NavItemData(
      label: 'Marketing',
      icon: Icons.campaign_outlined,
      selectedIcon: Icons.campaign_rounded,
      activeColor: AppColors.roseAccent,
      activeBgColor: AppColors.badgeRoseBg,
      activeTextColor: AppColors.badgeRoseText,
    ),
  ];

  const BrandSidenav({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.isExpanded = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isExpanded ? 210 : 80,
      decoration: const BoxDecoration(
        color: AppColors.cardSurface,
        border: Border(right: BorderSide(color: AppColors.cardBorder, width: 1)),
        boxShadow: [AppColors.softShadow],
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),

          // Navigation List Items
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              itemCount: navItems.length,
              itemBuilder: (context, index) {
                final item = navItems[index];
                final isSelected = selectedIndex == index;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: isSelected ? item.activeBgColor : Colors.transparent,
                      borderRadius: BorderRadius.circular(14),
                      border: isSelected
                          ? Border.all(color: item.activeColor.withOpacity(0.3), width: 1.5)
                          : Border.all(color: Colors.transparent, width: 1.5),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => onDestinationSelected(index),
                        borderRadius: BorderRadius.circular(14),
                        splashColor: item.activeColor.withOpacity(0.15),
                        highlightColor: item.activeColor.withOpacity(0.1),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
                          child: isExpanded
                              ? Row(
                                  children: [
                                    // Colored Icon Circle Container
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isSelected ? item.activeColor : item.activeColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        isSelected ? item.selectedIcon : item.icon,
                                        size: 20,
                                        color: isSelected ? Colors.white : item.activeColor,
                                      ),
                                    ),
                                    const SizedBox(width: 14),
                                    // Label Text
                                    Expanded(
                                      child: Text(
                                        item.label,
                                        style: TextStyle(
                                          fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                                          fontSize: 14,
                                          color: isSelected ? item.activeTextColor : AppColors.bodyText,
                                        ),
                                      ),
                                    ),
                                    // Active Indicator Dot
                                    if (isSelected)
                                      Container(
                                        width: 7,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          color: item.activeColor,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                )
                              : Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: isSelected ? item.activeColor : item.activeColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Icon(
                                        isSelected ? item.selectedIcon : item.icon,
                                        size: 20,
                                        color: isSelected ? Colors.white : item.activeColor,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item.label,
                                      style: TextStyle(
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                                        fontSize: 10,
                                        color: isSelected ? item.activeTextColor : AppColors.mutedText,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom Sidenav Footer Pill
          if (isExpanded)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.appBackgroundAlt,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.cardBorder),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.limeGreen,
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Expanded(
                      child: Text(
                        'Offline Vault Ready',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: AppColors.mutedText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
