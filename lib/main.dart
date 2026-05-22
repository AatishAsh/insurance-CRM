import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/customer_list_screen.dart';
import 'screens/work_management_screen.dart';
import 'screens/upcoming_events_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: InsuranceApp(),
    ),
  );
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
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = MediaQuery.of(context).size.width > 600;

    final List<Widget> screens = [
      const CustomerListScreen(),
      const UpcomingEventsScreen(),
      const Center(child: Text('Tab 3: Review')),
      const WorkManagementScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Insurance CRM'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: () {
              // TODO: Implement Sync Dialog
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // TODO: Implement Settings
            },
          ),
        ],
      ),
      body: Row(
        children: [
          if (isDesktop)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() => _selectedIndex = index);
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
                  icon: Icon(Icons.rate_review_outlined),
                  selectedIcon: Icon(Icons.rate_review),
                  label: Text('Review'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment),
                  label: Text('Work'),
                ),
              ],
            ),
          Expanded(
            child: screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: !isDesktop
          ? NavigationBar(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() => _selectedIndex = index);
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
                  icon: Icon(Icons.rate_review_outlined),
                  selectedIcon: Icon(Icons.rate_review),
                  label: 'Review',
                ),
                NavigationDestination(
                  icon: Icon(Icons.assignment_outlined),
                  selectedIcon: Icon(Icons.assignment),
                  label: 'Work',
                ),
              ],
            )
          : null,
    );
  }
}
