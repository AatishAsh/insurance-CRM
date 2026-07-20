import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import '../models/marketing_lead.dart';
import '../services/database_service.dart';
import '../providers/marketing_provider.dart';
import '../providers/auth_provider.dart';
import '../widgets/rename_file_dialog.dart';

// Consistent status options
const List<String> statusOptions = [
  'Confirmed',
  'Dropped',
  'Postponed',
  'Hold',
  'Documents Pending',
];

// Parses visitTime (e.g. "02:30 PM", "10:30AM" or "14:30") to TimeOfDay
TimeOfDay? parseTimeStr(String timeStr) {
  try {
    final cleanStr = timeStr.trim().toUpperCase();
    if (cleanStr.contains('AM') || cleanStr.contains('PM')) {
      final parts = cleanStr.split(' ');
      if (parts.length < 2) {
        // Handle case where space is missing, e.g. "10:30AM"
        final amPmIndex = cleanStr.indexOf('AM') != -1 ? cleanStr.indexOf('AM') : cleanStr.indexOf('PM');
        final timePart = cleanStr.substring(0, amPmIndex).trim();
        final amPmPart = cleanStr.substring(amPmIndex).trim();
        final hm = timePart.split(':');
        int hour = int.parse(hm[0]);
        final minute = int.parse(hm[1]);
        final isPm = amPmPart == 'PM';
        if (isPm && hour < 12) hour += 12;
        if (!isPm && hour == 12) hour = 0;
        return TimeOfDay(hour: hour, minute: minute);
      }
      final hm = parts[0].split(':');
      int hour = int.parse(hm[0]);
      final minute = int.parse(hm[1]);
      final isPm = parts[1] == 'PM';
      if (isPm && hour < 12) hour += 12;
      if (!isPm && hour == 12) hour = 0;
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      final hm = cleanStr.split(':');
      return TimeOfDay(hour: int.parse(hm[0]), minute: int.parse(hm[1]));
    }
  } catch (_) {
    return null;
  }
}

// Normalizes status strings from various sources for consistent UI logic
String getNormalizedStatus(String rawStatus) {
  final lower = rawStatus.trim().toLowerCase();
  if (lower == 'confirmed') return 'Confirmed';
  if (lower == 'dropped') return 'Dropped';
  if (lower == 'postponed') return 'Postponed';
  if (lower == 'hold') return 'Hold';
  if (lower == 'documents pending' || lower == 'documentspending') return 'Documents Pending';
  if (rawStatus.isEmpty) return 'Confirmed';
  return rawStatus.split(' ').map((word) {
    if (word.isEmpty) return '';
    return word[0].toUpperCase() + word.substring(1).toLowerCase();
  }).join(' ');
}

// Returns a consistent color matching a given status
Color getStatusColor(String status) {
  switch (status.trim().toLowerCase()) {
    case 'confirmed':
      return Colors.green;
    case 'dropped':
      return Colors.red;
    case 'postponed':
      return Colors.orange;
    case 'hold':
      return Colors.indigo;
    case 'documents pending':
      return Colors.purple;
    default:
      return Colors.blueGrey;
  }
}

class MarketingScreen extends ConsumerStatefulWidget {
  const MarketingScreen({super.key});

  @override
  ConsumerState<MarketingScreen> createState() => _MarketingScreenState();
}

class _MarketingScreenState extends ConsumerState<MarketingScreen> {
  String? _localDocsDirPath;
  
  // Search, Filtering and Sorting states
  String _searchQuery = '';
  String _selectedStatusFilter = 'All';
  int? _sortColumnIndex;
  bool _sortAscending = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initLocalDirPath();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initLocalDirPath() async {
    final appDir = await getApplicationDocumentsDirectory();
    setState(() {
      _localDocsDirPath = '${appDir.path}/customer_documents';
    });
  }

  // Returns the next upcoming visit (today or in the future)
  MarketingVisit? _getNextFutureVisit(List<MarketingVisit> visits) {
    final today = DateTime.now();
    final todayNormalized = DateTime(today.year, today.month, today.day);
    MarketingVisit? nextVisit;
    DateTime? minDiff;

    for (final visit in visits) {
      if (visit.visitDate == null) continue;
      
      final visitDateNormalized = DateTime(
        visit.visitDate!.year,
        visit.visitDate!.month,
        visit.visitDate!.day,
      );

      if (visitDateNormalized.isAtSameMomentAs(todayNormalized) || visitDateNormalized.isAfter(todayNormalized)) {
        DateTime visitDt = visitDateNormalized;
        if (visit.visitTime != null && visit.visitTime!.isNotEmpty) {
          final timeParts = parseTimeStr(visit.visitTime!);
          if (timeParts != null) {
            visitDt = DateTime(
              visit.visitDate!.year,
              visit.visitDate!.month,
              visit.visitDate!.day,
              timeParts.hour,
              timeParts.minute,
            );
          }
        }

        if (minDiff == null || visitDt.isBefore(minDiff)) {
          minDiff = visitDt;
          nextVisit = visit;
        }
      }
    }
    return nextVisit;
  }

  void _previewPhoto(String fileName, String label) {
    if (_localDocsDirPath == null) return;
    final file = File('$_localDocsDirPath/$fileName');

    if (!file.existsSync()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Photo not found on this device')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppBar(
                  title: Text(label),
                  leading: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  foregroundColor: Colors.black87,
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 450),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: InteractiveViewer(
                      panEnabled: true,
                      minScale: 1.0,
                      maxScale: 5.0,
                      child: Image.file(
                        file,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openAddEditDialog({MarketingLead? existingLead}) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AddEditMarketingLeadDialog(
          existingLead: existingLead,
          localDocsDirPath: _localDocsDirPath,
          onSave: () {
            ref.invalidate(marketingListProvider);
          },
        );
      },
    );
  }

  void _deleteLead(int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lead'),
        content: const Text('Are you sure you want to delete this marketing lead?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true) {
      final db = ref.read(databaseServiceProvider);
      await db.deleteMarketingLead(id);
      ref.invalidate(marketingListProvider);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Marketing lead deleted')),
        );
      }
    }
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.08) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey[200]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4))]
              : [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4, offset: const Offset(0, 2))],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, color: color, size: 24),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            value,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? color : Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final List<String> filters = ['All', 'Confirmed', 'Hold', 'Postponed', 'Documents Pending', 'Dropped'];
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: filters.map((filter) {
        final isSelected = _selectedStatusFilter.toLowerCase() == filter.toLowerCase();
        final Color color = getStatusColor(filter == 'All' ? 'hold' : filter);
        final displayColor = filter == 'All' ? Colors.blue : color;

        return FilterChip(
          label: Text(
            filter,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black87,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
          selected: isSelected,
          onSelected: (selected) {
            setState(() {
              _selectedStatusFilter = filter;
            });
          },
          selectedColor: displayColor,
          backgroundColor: Colors.grey[100],
          checkmarkColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? Colors.transparent : Colors.grey[300]!,
            ),
          ),
          elevation: isSelected ? 1 : 0,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final leadsAsync = ref.watch(marketingListProvider);
    final bool isWide = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text('Marketing Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton.icon(
              onPressed: () => _openAddEditDialog(),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('New Lead'),
              style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
      body: leadsAsync.when(
        data: (leads) {
          // Calculate statistics based on actual leads in db
          final totalLeadsCount = leads.length;
          final confirmedCount = leads.where((l) => getNormalizedStatus(l.status) == 'Confirmed').length;
          final droppedCount = leads.where((l) => getNormalizedStatus(l.status) == 'Dropped').length;
          
          final holdCount = leads.where((l) => getNormalizedStatus(l.status) == 'Hold').length;
          final postponedCount = leads.where((l) => getNormalizedStatus(l.status) == 'Postponed').length;
          final pendDocsCount = leads.where((l) => getNormalizedStatus(l.status) == 'Documents Pending').length;
          final pendingCount = holdCount + postponedCount + pendDocsCount;

          // Apply filters and searches locally
          var filteredLeads = leads.where((lead) {
            final query = _searchQuery.toLowerCase().trim();
            final matchesQuery = query.isEmpty ||
                lead.name.toLowerCase().contains(query) ||
                lead.mobile.contains(query) ||
                lead.status.toLowerCase().contains(query) ||
                lead.visits.any((v) => v.visitNote?.toLowerCase().contains(query) ?? false);
            
            if (_selectedStatusFilter == 'All') {
              return matchesQuery;
            } else {
              return matchesQuery && getNormalizedStatus(lead.status).toLowerCase() == _selectedStatusFilter.toLowerCase();
            }
          }).toList();

          // Apply Sorting
          if (_sortColumnIndex != null) {
            filteredLeads.sort((a, b) {
              int cmp = 0;
              if (_sortColumnIndex == 1) {
                // Sort by Name
                cmp = a.name.toLowerCase().compareTo(b.name.toLowerCase());
              } else if (_sortColumnIndex == 3) {
                // Sort by Next Visit Date
                final dateA = _getNextFutureVisit(a.visits)?.visitDate;
                final dateB = _getNextFutureVisit(b.visits)?.visitDate;
                if (dateA == null && dateB == null) cmp = 0;
                else if (dateA == null) cmp = 1;
                else if (dateB == null) cmp = -1;
                else cmp = dateA.compareTo(dateB);
              } else if (_sortColumnIndex == 6) {
                // Sort by Status
                cmp = getNormalizedStatus(a.status).compareTo(getNormalizedStatus(b.status));
              }
              return _sortAscending ? cmp : -cmp;
            });
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Stat Cards Dashboard
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth = constraints.maxWidth;
                    if (cardWidth < 600) {
                      // Scrollable Row for Mobile
                      return SizedBox(
                        height: 90,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          children: [
                            SizedBox(
                              width: 150,
                              child: _buildStatCard(
                                title: 'Total Leads',
                                value: '$totalLeadsCount',
                                icon: Icons.campaign_outlined,
                                color: Colors.blue,
                                isSelected: _selectedStatusFilter == 'All',
                                onTap: () => setState(() => _selectedStatusFilter = 'All'),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: _buildStatCard(
                                title: 'Confirmed',
                                value: '$confirmedCount',
                                icon: Icons.check_circle_outline,
                                color: Colors.green,
                                isSelected: _selectedStatusFilter == 'Confirmed',
                                onTap: () => setState(() => _selectedStatusFilter = 'Confirmed'),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: _buildStatCard(
                                title: 'Pending/Hold',
                                value: '$pendingCount',
                                icon: Icons.hourglass_empty_outlined,
                                color: Colors.orange,
                                isSelected: ['Hold', 'Postponed', 'Documents Pending'].contains(_selectedStatusFilter),
                                onTap: () => setState(() => _selectedStatusFilter = 'Hold'),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: _buildStatCard(
                                title: 'Dropped',
                                value: '$droppedCount',
                                icon: Icons.cancel_outlined,
                                color: Colors.red,
                                isSelected: _selectedStatusFilter == 'Dropped',
                                onTap: () => setState(() => _selectedStatusFilter = 'Dropped'),
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      // Grid/Flex Row for Desktop
                      return Row(
                        children: [
                          _buildStatCard(
                            title: 'Total Leads',
                            value: '$totalLeadsCount',
                            icon: Icons.campaign_outlined,
                            color: Colors.blue,
                            isSelected: _selectedStatusFilter == 'All',
                            onTap: () => setState(() => _selectedStatusFilter = 'All'),
                          ),
                          _buildStatCard(
                            title: 'Confirmed',
                            value: '$confirmedCount',
                            icon: Icons.check_circle_outline,
                            color: Colors.green,
                            isSelected: _selectedStatusFilter == 'Confirmed',
                            onTap: () => setState(() => _selectedStatusFilter = 'Confirmed'),
                          ),
                          _buildStatCard(
                            title: 'Pending/Hold',
                            value: '$pendingCount',
                            icon: Icons.hourglass_empty_outlined,
                            color: Colors.orange,
                            isSelected: ['Hold', 'Postponed', 'Documents Pending'].contains(_selectedStatusFilter),
                            onTap: () => setState(() => _selectedStatusFilter = 'Hold'),
                          ),
                          _buildStatCard(
                            title: 'Dropped',
                            value: '$droppedCount',
                            icon: Icons.cancel_outlined,
                            color: Colors.red,
                            isSelected: _selectedStatusFilter == 'Dropped',
                            onTap: () => setState(() => _selectedStatusFilter = 'Dropped'),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),

              // Search & Filter Panel
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.grey[200]!),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: SearchBar(
                                controller: _searchController,
                                hintText: 'Search by name, mobile, status or visit notes...',
                                leading: const Icon(Icons.search, color: Colors.blue),
                                trailing: [
                                  if (_searchController.text.isNotEmpty)
                                    IconButton(
                                      icon: const Icon(Icons.clear, color: Colors.grey),
                                      onPressed: () {
                                        setState(() {
                                          _searchController.clear();
                                          _searchQuery = '';
                                        });
                                      },
                                    ),
                                ],
                                elevation: WidgetStateProperty.all(0),
                                backgroundColor: WidgetStateProperty.all(Colors.grey[50]),
                                padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 12.0)),
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side: BorderSide(color: Colors.grey[200]!),
                                  ),
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    _searchQuery = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        _buildFilterChips(),
                      ],
                    ),
                  ),
                ),
              ),

              // Results Count
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Row(
                  children: [
                    Text(
                      'Showing ${filteredLeads.length} leads',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (_selectedStatusFilter != 'All' || _searchQuery.isNotEmpty) ...[
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedStatusFilter = 'All';
                            _searchQuery = '';
                            _searchController.clear();
                          });
                        },
                        child: Text(
                          '• Clear filters',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue[800],
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),

              // Leads Table/List
              Expanded(
                child: filteredLeads.isEmpty
                    ? Center(
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.campaign_outlined, size: 64, color: Colors.grey[300]),
                              const SizedBox(height: 16),
                              Text(
                                'No marketing leads match your filter',
                                style: TextStyle(fontSize: 16, color: Colors.grey[600], fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () {
                                  setState(() {
                                    _selectedStatusFilter = 'All';
                                    _searchQuery = '';
                                    _searchController.clear();
                                  });
                                },
                                icon: const Icon(Icons.refresh),
                                label: const Text('Reset Search Filters'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : isWide
                        ? _buildDesktopTable(filteredLeads)
                        : _buildMobileList(filteredLeads),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error loading leads: $err')),
      ),
    );
  }

  Widget _buildDesktopTable(List<MarketingLead> leads) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return true;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width - 32),
            child: Card(
              elevation: 0.5,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Colors.grey[200]!),
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: DataTable(
                  sortColumnIndex: _sortColumnIndex,
                  sortAscending: _sortAscending,
                  showCheckboxColumn: false,
                  headingRowColor: WidgetStateProperty.all(Colors.blue.withOpacity(0.03)),
                  dataRowMaxHeight: 60,
                  columns: [
                    const DataColumn(label: Text('SI.No', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                      label: const Text('Name', style: TextStyle(fontWeight: FontWeight.bold)),
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _sortAscending = ascending;
                        });
                      },
                    ),
                    const DataColumn(label: Text('Mobile', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                      label: const Text('Next Visit Date', style: TextStyle(fontWeight: FontWeight.bold)),
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _sortAscending = ascending;
                        });
                      },
                    ),
                    const DataColumn(label: Text('Next Visit Time', style: TextStyle(fontWeight: FontWeight.bold))),
                    const DataColumn(label: Text('Next Visit Note', style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                      label: const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                      onSort: (columnIndex, ascending) {
                        setState(() {
                          _sortColumnIndex = columnIndex;
                          _sortAscending = ascending;
                        });
                      },
                    ),
                    const DataColumn(label: Text('Attached Photo', style: TextStyle(fontWeight: FontWeight.bold))),
                  ],
                  rows: List.generate(leads.length, (index) {
                    final lead = leads[index];
                    final nextVisit = _getNextFutureVisit(lead.visits);
                    final photo = nextVisit?.attachedPhoto;
                    final hasPhoto = photo != null && _localDocsDirPath != null;
                    final normStatus = getNormalizedStatus(lead.status);

                    return DataRow(
                      key: ValueKey(lead.id),
                      onSelectChanged: (_) => _openAddEditDialog(existingLead: lead),
                      cells: [
                        DataCell(Text('${index + 1}')),
                        DataCell(Text(lead.name, style: const TextStyle(fontWeight: FontWeight.bold))),
                        DataCell(Text(lead.mobile)),
                        DataCell(
                          Text(
                            nextVisit?.visitDate != null
                                ? DateFormat('dd MMM yyyy').format(nextVisit!.visitDate!)
                                : 'No upcoming visit',
                            style: TextStyle(
                              color: nextVisit?.visitDate != null ? Colors.black87 : Colors.grey,
                              fontStyle: nextVisit?.visitDate != null ? FontStyle.normal : FontStyle.italic,
                            ),
                          ),
                        ),
                        DataCell(Text(nextVisit?.visitTime ?? '--')),
                        DataCell(
                          Container(
                            constraints: const BoxConstraints(maxWidth: 180),
                            child: Text(
                              nextVisit?.visitNote ?? '--',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        // Dropdown Status badge using PopupMenuButton to avoid focus/hover glitches
                        DataCell(
                          GestureDetector(
                            onTap: () {}, // Swallows click to avoid row selection popups
                            child: PopupMenuButton<String>(
                              initialValue: normStatus,
                              tooltip: 'Change Status',
                              onSelected: (newStatus) async {
                                final db = ref.read(databaseServiceProvider);
                                lead.status = newStatus;
                                lead.updatedAt = DateTime.now();
                                await db.saveMarketingLead(lead);
                              },
                              itemBuilder: (BuildContext context) {
                                return statusOptions.map((String s) {
                                  return PopupMenuItem<String>(
                                    value: s,
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            color: getStatusColor(s),
                                            shape: BoxShape.circle,
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          s,
                                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  color: getStatusColor(normStatus).withOpacity(0.08),
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: getStatusColor(normStatus).withOpacity(0.3)),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      normStatus,
                                      style: TextStyle(
                                        color: getStatusColor(normStatus),
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(Icons.arrow_drop_down, color: getStatusColor(normStatus), size: 16),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Photo column wrapped in GestureDetector
                        DataCell(
                          hasPhoto
                              ? GestureDetector(
                                  onTap: () {}, // Swallows tap
                                  child: InkWell(
                                    onTap: () => _previewPhoto(photo, lead.name),
                                    borderRadius: BorderRadius.circular(4),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(6),
                                      child: Image.file(
                                        File('$_localDocsDirPath/$photo'),
                                        width: 36,
                                        height: 36,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 24, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                )
                              : const Text('--', style: TextStyle(color: Colors.grey)),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileList(List<MarketingLead> leads) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: leads.length,
      itemBuilder: (context, index) {
        final lead = leads[index];
        final nextVisit = _getNextFutureVisit(lead.visits);
        final photo = nextVisit?.attachedPhoto;
        final normStatus = getNormalizedStatus(lead.status);
        final statusColor = getStatusColor(normStatus);

        final String visitDateText = nextVisit?.visitDate != null
            ? DateFormat('dd MMM yyyy').format(nextVisit!.visitDate!)
            : 'No upcoming visit';
        final String? visitTimeText = (nextVisit?.visitTime != null && nextVisit!.visitTime!.isNotEmpty)
            ? nextVisit.visitTime
            : null;
        final String? visitNoteText = (nextVisit?.visitNote != null && nextVisit!.visitNote!.isNotEmpty)
            ? nextVisit.visitNote
            : null;

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          elevation: 1,
          shadowColor: statusColor.withOpacity(0.15),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.grey[200]!),
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Left stripe showing status color
                Container(
                  width: 5,
                  color: statusColor,
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => _openAddEditDialog(existingLead: lead),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      radius: 12,
                                      backgroundColor: Colors.blue.withOpacity(0.08),
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          fontSize: 11,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue[900],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        lead.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Status Dropdown on mobile card using PopupMenuButton
                              GestureDetector(
                                onTap: () {}, // Swallows card tap
                                child: PopupMenuButton<String>(
                                  initialValue: normStatus,
                                  tooltip: 'Change Status',
                                  onSelected: (newStatus) async {
                                    final db = ref.read(databaseServiceProvider);
                                    lead.status = newStatus;
                                    lead.updatedAt = DateTime.now();
                                    await db.saveMarketingLead(lead);
                                  },
                                  itemBuilder: (BuildContext context) {
                                    return statusOptions.map((String s) {
                                      return PopupMenuItem<String>(
                                        value: s,
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                color: getStatusColor(s),
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Text(
                                              s,
                                              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList();
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.08),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(color: statusColor.withOpacity(0.3)),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          normStatus,
                                          style: TextStyle(
                                            color: statusColor,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 2),
                                        Icon(Icons.arrow_drop_down, color: statusColor, size: 14),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 20),
                          Row(
                            children: [
                              Icon(Icons.phone_outlined, size: 14, color: Colors.grey[600]),
                              const SizedBox(width: 8),
                              Text(
                                lead.mobile,
                                style: const TextStyle(
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Next Visit Scheduled',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      visitDateText,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: nextVisit?.visitDate != null ? Colors.black87 : Colors.grey,
                                        fontStyle: nextVisit?.visitDate != null ? FontStyle.normal : FontStyle.italic,
                                      ),
                                    ),
                                    if (visitTimeText != null) ...[
                                      const SizedBox(height: 2),
                                      Text(
                                        visitTimeText,
                                        style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                      ),
                                    ],
                                    if (visitNoteText != null) ...[
                                      const SizedBox(height: 6),
                                      Text(
                                        visitNoteText,
                                        style: const TextStyle(fontSize: 13, color: Colors.black54),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                              if (photo != null && _localDocsDirPath != null) ...[
                                const SizedBox(width: 12),
                                GestureDetector(
                                  onTap: () {}, // Swallows card tap
                                  child: InkWell(
                                    onTap: () => _previewPhoto(photo, lead.name),
                                    borderRadius: BorderRadius.circular(8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.file(
                                        File('$_localDocsDirPath/$photo'),
                                        width: 54,
                                        height: 54,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 28, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              GestureDetector(
                                onTap: () {}, // Swallows card tap
                                child: IconButton(
                                  icon: const Icon(Icons.edit_outlined, color: Colors.blue),
                                  onPressed: () => _openAddEditDialog(existingLead: lead),
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.all(8),
                                  iconSize: 20,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {}, // Swallows card tap
                                child: IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                                  onPressed: () => _deleteLead(lead.id),
                                  constraints: const BoxConstraints(),
                                  padding: const EdgeInsets.all(8),
                                  iconSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AddEditMarketingLeadDialog extends ConsumerStatefulWidget {
  final MarketingLead? existingLead;
  final String? localDocsDirPath;
  final VoidCallback onSave;

  const AddEditMarketingLeadDialog({
    super.key,
    this.existingLead,
    this.localDocsDirPath,
    required this.onSave,
  });

  @override
  ConsumerState<AddEditMarketingLeadDialog> createState() => _AddEditMarketingLeadDialogState();
}

class _AddEditMarketingLeadDialogState extends ConsumerState<AddEditMarketingLeadDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  String _status = 'Confirmed';

  // Draft lists of visits
  final List<DateTime?> _visitDates = [];
  final List<String> _visitTimes = [];
  final List<TextEditingController> _visitNoteControllers = [];
  final List<String?> _visitPhotos = [];

  @override
  void initState() {
    super.initState();
    if (widget.existingLead != null) {
      final lead = widget.existingLead!;
      _nameController.text = lead.name;
      _mobileController.text = lead.mobile;
      _status = getNormalizedStatus(lead.status);

      for (final visit in lead.visits) {
        _visitDates.add(visit.visitDate);
        _visitTimes.add(visit.visitTime ?? '');
        _visitNoteControllers.add(TextEditingController(text: visit.visitNote ?? ''));
        _visitPhotos.add(visit.attachedPhoto);
      }
    } else {
      // Initialize with at least 1 visit
      _addVisitField();
    }
  }

  void _addVisitField() {
    if (_visitDates.length >= 5) return;
    setState(() {
      _visitDates.add(null);
      _visitTimes.add('');
      _visitNoteControllers.add(TextEditingController());
      _visitPhotos.add(null);
    });
  }

  void _removeVisitField(int index) {
    if (_visitDates.length <= 1) return;
    setState(() {
      _visitDates.removeAt(index);
      _visitTimes.removeAt(index);
      _visitNoteControllers[index].dispose();
      _visitNoteControllers.removeAt(index);
      _visitPhotos.removeAt(index);
    });
  }

  Future<void> _selectDate(BuildContext context, int index) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _visitDates[index] ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _visitDates[index] = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context, int index) async {
    TimeOfDay initialTime = TimeOfDay.now();
    if (_visitTimes[index].isNotEmpty) {
      final parsed = parseTimeStr(_visitTimes[index]);
      if (parsed != null) {
        initialTime = parsed;
      }
    }
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialTime,
    );
    if (picked != null) {
      setState(() {
        _visitTimes[index] = picked.format(context);
      });
    }
  }

  Future<void> _pickPhoto(int index) async {
    ref.read(isPickingFileProvider.notifier).state = true;
    FilePickerResult? result;
    try {
      result = await FilePicker.platform.pickFiles(type: FileType.image);
    } finally {
      ref.read(isPickingFileProvider.notifier).state = false;
    }
    if (result != null && result.files.single.path != null) {
      final File srcFile = File(result.files.single.path!);
      
      // Ask user to rename attachment
      final customFileName = await showRenameFileDialog(context, srcFile.path);
      if (customFileName == null) {
        return; // User canceled upload
      }

      // Save locally
      final appDir = await getApplicationDocumentsDirectory();
      final docsDir = Directory('${appDir.path}/customer_documents');
      if (!await docsDir.exists()) {
        await docsDir.create(recursive: true);
      }

      final localFileName = 'marketing_${DateTime.now().millisecondsSinceEpoch}_$customFileName';
      await srcFile.copy('${docsDir.path}/$localFileName');

      setState(() {
        _visitPhotos[index] = localFileName;
      });
    }
  }

  void _deleteLead() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Lead'),
        content: const Text('Are you sure you want to permanently delete this marketing lead?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm == true && widget.existingLead != null) {
      final db = ref.read(databaseServiceProvider);
      await db.deleteMarketingLead(widget.existingLead!.id);
      widget.onSave();
      if (mounted) {
        Navigator.pop(context); // Close the edit dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Marketing lead deleted'), backgroundColor: Colors.redAccent),
        );
      }
    }
  }

  void _saveLead() async {
    if (!_formKey.currentState!.validate()) return;

    // Check if at least one visit date is selected
    for (int i = 0; i < _visitDates.length; i++) {
      if (_visitDates[i] == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Please select a date for visit #${i + 1}')),
        );
        return;
      }
    }

    final db = ref.read(databaseServiceProvider);
    final lead = widget.existingLead ?? MarketingLead()
      ..uuid = widget.existingLead?.uuid ?? '';

    lead.name = _nameController.text.trim();
    lead.mobile = _mobileController.text.trim();
    lead.status = _status;
    
    // Construct visits list
    final List<MarketingVisit> visits = [];
    for (int i = 0; i < _visitDates.length; i++) {
      visits.add(
        MarketingVisit()
          ..visitDate = _visitDates[i]
          ..visitTime = _visitTimes[i]
          ..visitNote = _visitNoteControllers[i].text.trim()
          ..attachedPhoto = _visitPhotos[i],
      );
    }
    lead.visits = visits;
    lead.updatedAt = DateTime.now();

    await db.saveMarketingLead(lead);
    widget.onSave();
    if (mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(widget.existingLead != null ? 'Lead updated' : 'Lead added')),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    for (final controller in _visitNoteControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: isMobile ? screenWidth * 0.95 : 550,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.85,
        ),
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.existingLead != null ? 'Edit Marketing Lead' : 'Add Marketing Lead',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Name *',
                          prefixIcon: Icon(Icons.person_outline),
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value == null || value.trim().isEmpty ? 'Name is required' : null,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _mobileController,
                        decoration: const InputDecoration(
                          labelText: 'Mobile *',
                          prefixIcon: Icon(Icons.phone_outlined),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => value == null || value.trim().isEmpty ? 'Mobile is required' : null,
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: statusOptions.contains(_status) ? _status : statusOptions.first,
                        decoration: const InputDecoration(
                          labelText: 'Status *',
                          prefixIcon: Icon(Icons.flag_outlined),
                          border: OutlineInputBorder(),
                        ),
                        items: statusOptions.map((opt) => DropdownMenuItem(value: opt, child: Text(opt))).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setState(() {
                              _status = val;
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Visits Schedule (At least 1, at most 5)',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          if (_visitDates.length < 5)
                            TextButton.icon(
                              onPressed: _addVisitField,
                              icon: const Icon(Icons.add),
                              label: const Text('Add Visit'),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _visitDates.length,
                        itemBuilder: (context, index) {
                          final photoFileName = _visitPhotos[index];
                          final photoFile = photoFileName != null && widget.localDocsDirPath != null
                              ? File('${widget.localDocsDirPath}/$photoFileName')
                              : null;

                          return Card(
                            color: Colors.grey[50],
                            margin: const EdgeInsets.only(bottom: 16),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(color: Colors.grey[200]!),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Visit #${index + 1}',
                                        style: TextStyle(fontWeight: FontWeight.w600, color: Colors.blue[800]),
                                      ),
                                      if (_visitDates.length > 1)
                                        IconButton(
                                          icon: const Icon(Icons.delete_outline, color: Colors.red),
                                          onPressed: () => _removeVisitField(index),
                                        ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: () => _selectDate(context, index),
                                          icon: const Icon(Icons.calendar_today, size: 16),
                                          label: Text(
                                            _visitDates[index] == null
                                                ? 'Pick Date *'
                                                : DateFormat('dd MMM yyyy').format(_visitDates[index]!),
                                            style: const TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: () => _selectTime(context, index),
                                          icon: const Icon(Icons.access_time, size: 16),
                                          label: Text(
                                            _visitTimes[index].isEmpty ? 'Pick Time' : _visitTimes[index],
                                            style: const TextStyle(fontSize: 13),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  TextFormField(
                                    controller: _visitNoteControllers[index],
                                    decoration: const InputDecoration(
                                      labelText: 'Visit Note',
                                      alignLabelWithHint: true,
                                      border: OutlineInputBorder(),
                                    ),
                                    maxLines: 2,
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton.icon(
                                          onPressed: () => _pickPhoto(index),
                                          icon: const Icon(Icons.photo_outlined, size: 16),
                                          label: const Text('Attach Photo', style: TextStyle(fontSize: 13)),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      if (photoFile != null && photoFile.existsSync())
                                        Stack(
                                          alignment: Alignment.topRight,
                                          children: [
                                            ClipRRect(
                                              borderRadius: BorderRadius.circular(4),
                                              child: Image.file(
                                                photoFile,
                                                width: 50,
                                                height: 50,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  _visitPhotos[index] = null;
                                                });
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                child: const Icon(Icons.close, size: 14, color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        )
                                      else
                                        const Text('No photo', style: TextStyle(color: Colors.grey, fontSize: 12)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (widget.existingLead != null)
                    TextButton.icon(
                      onPressed: _deleteLead,
                      icon: const Icon(Icons.delete_outline, color: Colors.redAccent),
                      label: const Text('Delete', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
                    )
                  else
                    const SizedBox.shrink(),
                  Row(
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: _saveLead,
                        child: const Text('Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
