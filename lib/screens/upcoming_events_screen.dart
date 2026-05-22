import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UpcomingEventsScreen extends StatelessWidget {
  const UpcomingEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const SliverAppBar(
            floating: true,
            title: Text('Upcoming Events Dashboard'),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList( // FIXED: Changed 'child' to 'sliver'
              delegate: SliverChildListDelegate([
                _buildSectionHeader('Meetings & Appointments', Icons.alarm),
                _buildEventCard(
                  'Meeting with Rajesh Kumar',
                  'Today, 2:30 PM',
                  'Discussing Health Policy Renewal',
                  Colors.blue,
                  Icons.handshake,
                ),
                _buildEventCard(
                  'Follow up with Anita Singh',
                  'Tomorrow, 10:00 AM',
                  'Document collection (PAN Card)',
                  Colors.blue,
                  Icons.description,
                ),
                
                const SizedBox(height: 24),
                _buildSectionHeader('Birthdays', Icons.cake),
                _buildEventCard(
                  'Suresh Raina',
                  'April 28 (In 3 days)',
                  'Age: 45 years',
                  Colors.pink,
                  Icons.person,
                ),
                _buildEventCard(
                  'Meena Gupta',
                  'May 2 (Next week)',
                  'Age: 32 years',
                  Colors.pink,
                  Icons.person,
                ),

                const SizedBox(height: 24),
                _buildSectionHeader('Anniversaries', Icons.favorite),
                _buildEventCard(
                  'Mr. & Mrs. Sharma',
                  'April 26 (Tomorrow)',
                  '12th Wedding Anniversary',
                  Colors.red,
                  Icons.group,
                ),
                
                const SizedBox(height: 100), // Bottom padding
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            title.toUpperCase(),
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.grey[700],
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventCard(String title, String subtitle, String trailing, Color color, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey[200]!),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    trailing,
                    style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: Colors.grey[400]),
          ],
        ),
      ),
    );
  }
}
