import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/dashboard_screen.dart';
import 'screens/customer_list_screen.dart';
import 'screens/work_management_screen.dart';
import 'screens/upcoming_events_screen.dart';
import 'screens/marketing_screen.dart';
import 'screens/performance_screen.dart';
import 'services/database_service.dart';

import 'screens/auth_gate.dart';
import 'screens/sync_screen.dart';
import 'providers/customer_provider.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';
import 'widgets/brand_background.dart';
import 'widgets/brand_sidenav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = await DatabaseService.init();
  
  runApp(
    ProviderScope(
      overrides: [
        databaseServiceProvider.overrideWithValue(databaseService),
      ],
      child: const InsuranceApp(),
    ),
  );
}

class CurvedOverscrollBehavior extends MaterialScrollBehavior {
  @override
  Widget buildOverscrollIndicator(BuildContext context, Widget child, ScrollableDetails details) {
    return GlowingOverscrollIndicator(
      axisDirection: details.direction,
      color: AppColors.skyBlue,
      child: child,
    );
  }
}

class InsuranceApp extends StatelessWidget {
  const InsuranceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Customer Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      scrollBehavior: CurvedOverscrollBehavior(),
      home: const AuthGate(
        child: MainNavigationShell(),
      ),
    );
  }
}

class MainNavigationShell extends ConsumerWidget {
  const MainNavigationShell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;
    final int selectedIndex = ref.watch(navigationTabIndexProvider);

    final List<Widget> screens = [
      const DashboardScreen(),
      const CustomerListScreen(),
      const UpcomingEventsScreen(),
      const PerformanceScreen(),
      const WorkManagementScreen(),
      const MarketingScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.shield_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(width: 12),
            RichText(
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.3,
                ),
                children: [
                  TextSpan(
                    text: 'Insurance ',
                    style: TextStyle(color: AppColors.headingText),
                  ),
                  TextSpan(
                    text: 'CRM',
                    style: TextStyle(color: AppColors.skyBlue),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Cloud Sync',
            icon: const Icon(Icons.sync, color: AppColors.skyBlue),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SyncScreen()));
            },
          ),
          IconButton(
            tooltip: 'Settings',
            icon: const Icon(Icons.settings_outlined, color: AppColors.bodyText),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SyncScreen()));
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: BrandBackground(
        child: Row(
          children: [
            if (isDesktop)
              BrandSidenav(
                selectedIndex: selectedIndex,
                onDestinationSelected: (int index) {
                  ref.read(navigationTabIndexProvider.notifier).state = index;
                },
              ),
            Expanded(
              child: screens[selectedIndex],
            ),
          ],
        ),
      ),
      bottomNavigationBar: !isDesktop
          ? NavigationBar(
              selectedIndex: selectedIndex,
              elevation: 6,
              indicatorColor: AppColors.badgeBlueBg,
              onDestinationSelected: (int index) {
                ref.read(navigationTabIndexProvider.notifier).state = index;
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.grid_view_outlined),
                  selectedIcon: Icon(Icons.grid_view_rounded, color: AppColors.skyBlue),
                  label: 'Dashboard',
                ),
                NavigationDestination(
                  icon: Icon(Icons.people_outline_rounded),
                  selectedIcon: Icon(Icons.people_rounded, color: AppColors.limeGreen),
                  label: 'Customers',
                ),
                NavigationDestination(
                  icon: Icon(Icons.event_outlined),
                  selectedIcon: Icon(Icons.event_rounded, color: AppColors.violetAccent),
                  label: 'Events',
                ),
                NavigationDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics_rounded, color: AppColors.cyanAccent),
                  label: 'Performance',
                ),
                NavigationDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment_rounded, color: AppColors.amberAccent),
                  label: 'Work',
                ),
                NavigationDestination(
                  icon: Icon(Icons.campaign_outlined),
                  selectedIcon: Icon(Icons.campaign_rounded, color: AppColors.roseAccent),
                  label: 'Marketing',
                ),
              ],
            )
          : null,
    );
  }
}

