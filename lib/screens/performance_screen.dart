import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/performance_record.dart';
import '../providers/performance_provider.dart';

class PerformanceScreen extends ConsumerStatefulWidget {
  const PerformanceScreen({super.key});

  @override
  ConsumerState<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends ConsumerState<PerformanceScreen> {
  // Box 1 Controllers
  late TextEditingController _urgentController;
  late TextEditingController _newBusinessController;
  late TextEditingController _lifeController;
  late TextEditingController _fireHealthPaController;
  late TextEditingController _earnedController;

  // Box 2 Controllers
  late TextEditingController _box2Row1DaysController;
  late TextEditingController _box2EarningsOnWorkedDaysController;
  late TextEditingController _box2Row2DaysController;
  late TextEditingController _box2TotalWorkingDayController;

  // Box 3 Controllers (5 Column Headers x 4 Input Rows)
  late List<TextEditingController> _box3JjWorkwayControllers;
  late List<TextEditingController> _box3TargetControllers;
  late List<TextEditingController> _box3YyControllers;
  late List<TextEditingController> _box3ZzControllers;
  late List<TextEditingController> _box3PercentageControllers;

  // Box 4 Controllers (For MDRT)
  late TextEditingController _box4BalanceController;
  late TextEditingController _box4TargetController;
  late TextEditingController _box4AchievedController;

  final List<String> _monthNames = const [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ];

  final List<int> _availableYears = List.generate(16, (index) => 2020 + index);

  @override
  void initState() {
    super.initState();
    // Box 1 Controllers Init
    _urgentController = TextEditingController();
    _newBusinessController = TextEditingController();
    _lifeController = TextEditingController();
    _fireHealthPaController = TextEditingController();
    _earnedController = TextEditingController();

    // Box 2 Controllers Init
    _box2Row1DaysController = TextEditingController();
    _box2EarningsOnWorkedDaysController = TextEditingController();
    _box2Row2DaysController = TextEditingController();
    _box2TotalWorkingDayController = TextEditingController();

    // Box 3 Controllers Init (5 Column Headers x 4 Input Rows)
    _box3JjWorkwayControllers = List.generate(4, (_) => TextEditingController());
    _box3TargetControllers = List.generate(4, (_) => TextEditingController());
    _box3YyControllers = List.generate(4, (_) => TextEditingController());
    _box3ZzControllers = List.generate(4, (_) => TextEditingController());
    _box3PercentageControllers = List.generate(4, (_) => TextEditingController());

    // Box 4 Controllers Init (For MDRT)
    _box4BalanceController = TextEditingController();
    _box4TargetController = TextEditingController();
    _box4AchievedController = TextEditingController();
  }

  @override
  void dispose() {
    // Box 1 Controllers Dispose
    _urgentController.dispose();
    _newBusinessController.dispose();
    _lifeController.dispose();
    _fireHealthPaController.dispose();
    _earnedController.dispose();

    // Box 2 Controllers Dispose
    _box2Row1DaysController.dispose();
    _box2EarningsOnWorkedDaysController.dispose();
    _box2Row2DaysController.dispose();
    _box2TotalWorkingDayController.dispose();

    // Box 3 Controllers Dispose
    for (var c in _box3JjWorkwayControllers) {
      c.dispose();
    }
    for (var c in _box3TargetControllers) {
      c.dispose();
    }
    for (var c in _box3YyControllers) {
      c.dispose();
    }
    for (var c in _box3ZzControllers) {
      c.dispose();
    }
    for (var c in _box3PercentageControllers) {
      c.dispose();
    }

    // Box 4 Controllers Dispose
    _box4BalanceController.dispose();
    _box4TargetController.dispose();
    _box4AchievedController.dispose();

    super.dispose();
  }

  void _syncBox3Controllers(PerformanceRecord record) {
    final box3JjWorkwayValues = [
      record.box3JjWorkwayCol1,
      record.box3JjWorkwayCol2,
      record.box3JjWorkwayCol3,
      record.box3JjWorkwayCol4,
    ];
    final box3TargetValues = [
      record.box3TargetCol1,
      record.box3TargetCol2,
      record.box3TargetCol3,
      record.box3TargetCol4,
    ];
    final box3YyValues = [
      record.box3YyCol1,
      record.box3YyCol2,
      record.box3YyCol3,
      record.box3YyCol4,
    ];
    final box3ZzValues = [
      record.box3ZzCol1,
      record.box3ZzCol2,
      record.box3ZzCol3,
      record.box3ZzCol4,
    ];
    final box3PercentageValues = [
      record.box3PercentageCol1,
      record.box3PercentageCol2,
      record.box3PercentageCol3,
      record.box3PercentageCol4,
    ];

    _syncRowControllers(_box3JjWorkwayControllers, box3JjWorkwayValues);
    _syncRowControllers(_box3TargetControllers, box3TargetValues);
    _syncRowControllers(_box3YyControllers, box3YyValues);
    _syncRowControllers(_box3ZzControllers, box3ZzValues);
    _syncRowControllers(_box3PercentageControllers, box3PercentageValues);
  }

  void _syncRowControllers(List<TextEditingController> controllers, List<String> values) {
    for (int i = 0; i < 4; i++) {
      if (controllers[i].text != values[i]) {
        controllers[i].value = TextEditingValue(
          text: values[i],
          selection: TextSelection.collapsed(offset: values[i].length),
        );
      }
    }
  }

  void _syncControllers(PerformanceRecord record) {
    if (_urgentController.text != record.urgent) {
      _urgentController.value = TextEditingValue(
        text: record.urgent,
        selection: TextSelection.collapsed(offset: record.urgent.length),
      );
    }
    if (_newBusinessController.text != record.newBusiness) {
      _newBusinessController.value = TextEditingValue(
        text: record.newBusiness,
        selection: TextSelection.collapsed(offset: record.newBusiness.length),
      );
    }
    if (_lifeController.text != record.life) {
      _lifeController.value = TextEditingValue(
        text: record.life,
        selection: TextSelection.collapsed(offset: record.life.length),
      );
    }
    if (_fireHealthPaController.text != record.fireHealthPa) {
      _fireHealthPaController.value = TextEditingValue(
        text: record.fireHealthPa,
        selection: TextSelection.collapsed(offset: record.fireHealthPa.length),
      );
    }
    if (_earnedController.text != record.earned) {
      _earnedController.value = TextEditingValue(
        text: record.earned,
        selection: TextSelection.collapsed(offset: record.earned.length),
      );
    }

    // Box 2 Sync
    if (_box2Row1DaysController.text != record.box2Row1Days) {
      _box2Row1DaysController.value = TextEditingValue(
        text: record.box2Row1Days,
        selection: TextSelection.collapsed(offset: record.box2Row1Days.length),
      );
    }
    if (_box2EarningsOnWorkedDaysController.text != record.box2EarningsOnWorkedDays) {
      _box2EarningsOnWorkedDaysController.value = TextEditingValue(
        text: record.box2EarningsOnWorkedDays,
        selection: TextSelection.collapsed(offset: record.box2EarningsOnWorkedDays.length),
      );
    }
    if (_box2Row2DaysController.text != record.box2Row2Days) {
      _box2Row2DaysController.value = TextEditingValue(
        text: record.box2Row2Days,
        selection: TextSelection.collapsed(offset: record.box2Row2Days.length),
      );
    }
    if (_box2TotalWorkingDayController.text != record.box2TotalWorkingDay) {
      _box2TotalWorkingDayController.value = TextEditingValue(
        text: record.box2TotalWorkingDay,
        selection: TextSelection.collapsed(offset: record.box2TotalWorkingDay.length),
      );
    }

    // Box 3 Sync
    _syncBox3Controllers(record);

    // Box 4 Sync
    if (_box4BalanceController.text != record.box4Balance) {
      _box4BalanceController.value = TextEditingValue(
        text: record.box4Balance,
        selection: TextSelection.collapsed(offset: record.box4Balance.length),
      );
    }
    if (_box4TargetController.text != record.box4Target) {
      _box4TargetController.value = TextEditingValue(
        text: record.box4Target,
        selection: TextSelection.collapsed(offset: record.box4Target.length),
      );
    }
    if (_box4AchievedController.text != record.box4Achieved) {
      _box4AchievedController.value = TextEditingValue(
        text: record.box4Achieved,
        selection: TextSelection.collapsed(offset: record.box4Achieved.length),
      );
    }
  }

  void _previousMonth(int currentYear, int currentMonth) {
    if (currentMonth == 1) {
      ref.read(selectedPerformanceYearProvider.notifier).state = currentYear - 1;
      ref.read(selectedPerformanceMonthProvider.notifier).state = 12;
    } else {
      ref.read(selectedPerformanceMonthProvider.notifier).state = currentMonth - 1;
    }
  }

  void _nextMonth(int currentYear, int currentMonth) {
    if (currentMonth == 12) {
      ref.read(selectedPerformanceYearProvider.notifier).state = currentYear + 1;
      ref.read(selectedPerformanceMonthProvider.notifier).state = 1;
    } else {
      ref.read(selectedPerformanceMonthProvider.notifier).state = currentMonth + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedYear = ref.watch(selectedPerformanceYearProvider);
    final selectedMonth = ref.watch(selectedPerformanceMonthProvider);
    final providerKey = '${selectedYear}_$selectedMonth';
    final performanceRecord = ref.watch(performanceRecordProvider(providerKey));
    final notifier = ref.read(performanceRecordProvider(providerKey).notifier);

    // Sync input text controllers with loaded record
    _syncControllers(performanceRecord);

    final bool isDesktop = MediaQuery.of(context).size.width > 700;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.analytics_rounded, color: Theme.of(context).primaryColor, size: 28),
                      const SizedBox(width: 10),
                      const Text(
                        'Performance Metrics',
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Year and Month Selector Row
                  Card(
                    elevation: 1.5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        spacing: 20,
                        runSpacing: 12,
                        children: [
                          // Year Selector
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.calendar_today_rounded, size: 20, color: Colors.blueAccent),
                              const SizedBox(width: 8),
                              const Text('Year: ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue.shade200),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    value: selectedYear,
                                    isDense: true,
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                                    items: _availableYears.map((yr) {
                                      return DropdownMenuItem<int>(
                                        value: yr,
                                        child: Text('$yr'),
                                      );
                                    }).toList(),
                                    onChanged: (newYear) {
                                      if (newYear != null) {
                                        ref.read(selectedPerformanceYearProvider.notifier).state = newYear;
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),

                          // Month Selector with Arrows
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.date_range_rounded, size: 20, color: Colors.blueAccent),
                              const SizedBox(width: 8),
                              const Text('Month: ', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                              IconButton(
                                icon: const Icon(Icons.arrow_back_ios_rounded, size: 18),
                                tooltip: 'Previous Month',
                                onPressed: () => _previousMonth(selectedYear, selectedMonth),
                                color: Colors.blueAccent,
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: Colors.blue.shade200),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<int>(
                                    value: selectedMonth,
                                    isDense: true,
                                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 16),
                                    items: List.generate(12, (index) => index + 1).map((m) {
                                      return DropdownMenuItem<int>(
                                        value: m,
                                        child: Text(_monthNames[m - 1]),
                                      );
                                    }).toList(),
                                    onChanged: (newMonth) {
                                      if (newMonth != null) {
                                        ref.read(selectedPerformanceMonthProvider.notifier).state = newMonth;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_forward_ios_rounded, size: 18),
                                tooltip: 'Next Month',
                                onPressed: () => _nextMonth(selectedYear, selectedMonth),
                                color: Colors.blueAccent,
                              ),
                            ],
                          ),

                          // Summary badge
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.green.shade300),
                            ),
                            child: Text(
                              'Data for ${_monthNames[selectedMonth - 1]} $selectedYear',
                              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.green.shade800, fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // TAB CONTENT - DIVIDED INTO TWO HALVES
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ==================== FIRST HALF ====================
                  // Main Performance Cards Grid/Flex Layout
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double boxWidth = isDesktop ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth;
                      return Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          // --- Primary Metrics ---
                          SizedBox(
                            width: boxWidth,
                            child: _buildBoxOneCard(context, notifier),
                          ),

                          // --- Days & Earnings ---
                          SizedBox(
                            width: boxWidth,
                            child: _buildBoxTwoCard(context, notifier),
                          ),

                          // --- JJ Workway & Targets ---
                          SizedBox(
                            width: boxWidth,
                            child: _buildBoxThreeCard(context, notifier),
                          ),

                          // --- For MDRT ---
                          SizedBox(
                            width: boxWidth,
                            child: _buildBoxFourCard(context, notifier),
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // ==================== ADDITIONAL ANALYTICS & REPORTS ====================
                  Card(
                    elevation: 1.5,
                    color: Colors.grey.shade100,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderStyle.solid == BorderStyle.solid
                          ? BorderSide(color: Colors.grey.shade300, width: 1.5)
                          : BorderSide.none,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Icon(Icons.analytics_outlined, size: 40, color: Colors.grey.shade500),
                          const SizedBox(height: 12),
                          Text(
                            'Additional Analytics & Reports',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'This section is prepared for future metric charts, comparative reports, and deep analytics.',
                            style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Build Box One Card with the 5 required input text fields
  Widget _buildBoxOneCard(BuildContext context, PerformanceNotifier notifier) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue.shade200, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.dashboard_rounded, color: Colors.blueAccent, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Primary Metrics',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blueAccent),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 1. Urgent Field
            _buildInputField(
              controller: _urgentController,
              label: 'Urgent',
              icon: Icons.priority_high_rounded,
              onChanged: (val) => notifier.updateBox1(urgent: val),
            ),

            const SizedBox(height: 12),

            // 2. New Business Field
            _buildInputField(
              controller: _newBusinessController,
              label: 'New Business',
              icon: Icons.business_center_rounded,
              onChanged: (val) => notifier.updateBox1(newBusiness: val),
            ),

            const SizedBox(height: 12),

            // 3. Life Field
            _buildInputField(
              controller: _lifeController,
              label: 'Life',
              icon: Icons.favorite_rounded,
              onChanged: (val) => notifier.updateBox1(life: val),
            ),

            const SizedBox(height: 12),

            // 4. Fire / Health / PA Field
            _buildInputField(
              controller: _fireHealthPaController,
              label: 'Fire / Health / PA',
              icon: Icons.local_hospital_rounded,
              onChanged: (val) => notifier.updateBox1(fireHealthPa: val),
            ),

            const SizedBox(height: 12),

            // 5. Earned Field
            _buildInputField(
              controller: _earnedController,
              label: 'Earned',
              icon: Icons.payments_rounded,
              onChanged: (val) => notifier.updateBox1(earned: val),
            ),
          ],
        ),
      ),
    );
  }

  // Build Box Two Card with 2 rows of fields
  Widget _buildBoxTwoCard(BuildContext context, PerformanceNotifier notifier) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.indigo.shade200, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.work_history_rounded, color: Colors.indigo, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Days & Earnings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Row 1: Days & Earnings on worked Days
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    controller: _box2Row1DaysController,
                    label: 'Days',
                    icon: Icons.today_rounded,
                    onChanged: (val) => notifier.updateBox2(box2Row1Days: val),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInputField(
                    controller: _box2EarningsOnWorkedDaysController,
                    label: 'Earnings on worked Days',
                    icon: Icons.monetization_on_rounded,
                    onChanged: (val) => notifier.updateBox2(box2EarningsOnWorkedDays: val),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Row 2: Days & Total working Day
            Row(
              children: [
                Expanded(
                  child: _buildInputField(
                    controller: _box2Row2DaysController,
                    label: 'Days',
                    icon: Icons.calendar_month_rounded,
                    onChanged: (val) => notifier.updateBox2(box2Row2Days: val),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildInputField(
                    controller: _box2TotalWorkingDayController,
                    label: 'Total working Day',
                    icon: Icons.work_history_rounded,
                    onChanged: (val) => notifier.updateBox2(box2TotalWorkingDay: val),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Build Box Three Card with 5 Column Headers, each having 4 Input Rows below
  Widget _buildBoxThreeCard(BuildContext context, PerformanceNotifier notifier) {
    final columns = [
      {
        'title': 'JJ workway',
        'icon': Icons.alt_route_rounded,
        'color': Colors.teal,
        'controllers': _box3JjWorkwayControllers,
        'prefixKey': 'box3JjWorkwayCol',
      },
      {
        'title': 'Target',
        'icon': Icons.track_changes_rounded,
        'color': Colors.deepOrange,
        'controllers': _box3TargetControllers,
        'prefixKey': 'box3TargetCol',
      },
      {
        'title': 'YY',
        'icon': Icons.analytics_outlined,
        'color': Colors.purple,
        'controllers': _box3YyControllers,
        'prefixKey': 'box3YyCol',
      },
      {
        'title': 'ZZ',
        'icon': Icons.assessment_outlined,
        'color': Colors.blue,
        'controllers': _box3ZzControllers,
        'prefixKey': 'box3ZzCol',
      },
      {
        'title': 'Percentage',
        'icon': Icons.percent_rounded,
        'color': Colors.green,
        'controllers': _box3PercentageControllers,
        'prefixKey': 'box3PercentageCol',
      },
    ];

    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.teal.shade200, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.table_chart_rounded, color: Colors.teal, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'JJ Workway & Targets',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // Horizontal Table View: 5 Column Headers across top, 4 input rows below
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columns.map((col) {
                  final String title = col['title'] as String;
                  final IconData icon = col['icon'] as IconData;
                  final Color color = col['color'] as Color;
                  final List<TextEditingController> controllers = col['controllers'] as List<TextEditingController>;
                  final String prefixKey = col['prefixKey'] as String;

                  return Container(
                    width: 125,
                    margin: const EdgeInsets.only(right: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Column Header Title Badge
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: color.withOpacity(0.3)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(icon, size: 16, color: color),
                              const SizedBox(height: 4),
                              Text(
                                title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: color,
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),

                        // 4 Input Rows under this Column Header
                        ...List.generate(4, (rowIdx) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: TextField(
                              controller: controllers[rowIdx],
                              onChanged: (val) {
                                notifier.updateBox3Field('$prefixKey${rowIdx + 1}', val);
                              },
                              decoration: InputDecoration(
                                labelText: 'Row ${rowIdx + 1}',
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(color: Colors.grey.shade300),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: BorderSide(color: color, width: 1.5),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                              ),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Build Box Four Card ("For MDRT") with 3 input text fields
  Widget _buildBoxFourCard(BuildContext context, PerformanceNotifier notifier) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.amber.shade300, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Colors.amber.shade100,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.stars_rounded, color: Colors.amber, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'For MDRT',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // 1. Balance Field
            _buildInputField(
              controller: _box4BalanceController,
              label: 'Balance',
              icon: Icons.account_balance_wallet_rounded,
              onChanged: (val) => notifier.updateBox4(box4Balance: val),
            ),

            const SizedBox(height: 12),

            // 2. Target Field
            _buildInputField(
              controller: _box4TargetController,
              label: 'Target',
              icon: Icons.flag_rounded,
              onChanged: (val) => notifier.updateBox4(box4Target: val),
            ),

            const SizedBox(height: 12),

            // 3. Achieved Field
            _buildInputField(
              controller: _box4AchievedController,
              label: 'Achieved',
              icon: Icons.emoji_events_rounded,
              onChanged: (val) => notifier.updateBox4(box4Achieved: val),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable text input field
  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required ValueChanged<String> onChanged,
  }) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20, color: Colors.blue.shade700),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }
}
