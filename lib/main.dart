import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/customer_list_screen.dart';
import 'screens/work_management_screen.dart';
import 'screens/upcoming_events_screen.dart';
import 'screens/marketing_screen.dart';
import 'services/database_service.dart';
import 'screens/auth_gate.dart';
import 'screens/sync_screen.dart';
import 'providers/customer_provider.dart';

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
      color: Colors.blueAccent,
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
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
      const CustomerListScreen(),
      const UpcomingEventsScreen(),
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction_rounded, size: 72, color: Colors.blue[300]),
            const SizedBox(height: 16),
            const Text(
              'Performance Dashboard',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.amber[100],
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.amber[600]!),
              ),
              child: Text(
                'Still in Development',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.amber[900]),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Analytics and performance reporting features are coming soon.',
              style: TextStyle(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      const WorkManagementScreen(),
      const MarketingScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance CRM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SyncScreen()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const SyncScreen()));
            },
          ),
        ],
      ),
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                ref.read(navigationTabIndexProvider.notifier).state = index;
              },
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: Text('Customers'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.event_outlined),
                  selectedIcon: Icon(Icons.event),
                  label: Text('Events'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics),
                  label: Text('Performance'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment),
                  label: Text('Work'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.campaign_outlined),
                  selectedIcon: Icon(Icons.campaign),
                  label: Text('Marketing'),
                ),
              ],
            ),
          Expanded(
            child: screens[selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: !isDesktop
          ? NavigationBar(
              selectedIndex: selectedIndex,
              onDestinationSelected: (int index) {
                ref.read(navigationTabIndexProvider.notifier).state = index;
              },
              destinations: const [
                NavigationDestination(
                  icon: Icon(Icons.people_outline),
                  selectedIcon: Icon(Icons.people),
                  label: 'Customers',
                ),
                NavigationDestination(
                  icon: Icon(Icons.event_outlined),
                  selectedIcon: Icon(Icons.event),
                  label: 'Events',
                ),
                NavigationDestination(
                  icon: Icon(Icons.analytics_outlined),
                  selectedIcon: Icon(Icons.analytics),
                  label: 'Performance',
                ),
                NavigationDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment),
                  label: 'Work',
                ),
                NavigationDestination(
                  icon: Icon(Icons.campaign_outlined),
                  selectedIcon: Icon(Icons.campaign),
                  label: 'Marketing',
                ),
              ],
            )
          : null,
    );
  }
}
