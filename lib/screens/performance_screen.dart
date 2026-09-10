import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/performance_record.dart';
import '../providers/performance_provider.dart';
import '../theme/app_colors.dart';
import '../widgets/brand_background.dart';
import '../widgets/key_cycle_dropdown.dart';

class PerformanceScreen extends ConsumerStatefulWidget {
  const PerformanceScreen({super.key});

  @override
  ConsumerState<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends ConsumerState<PerformanceScreen> {
  // Monthly Topic Table Controllers & Pagination
  String? _lastLoadedKey;
  int _topicTablePage = 0;
  static const int _entriesPerPage = 10;
  final Map<String, TextEditingController> _topicCellControllers = {};
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

  // Box 3 Controllers (7 Column Headers x 4 Input Rows)
  late List<TextEditingController> _box3JjWorkwayControllers;
  late List<TextEditingController> _box3TargetControllers;
  late List<TextEditingController> _box3YyControllers;
  late List<TextEditingController> _box3ZzControllers;
  late List<TextEditingController> _box3PercentageControllers;
  late List<TextEditingController> _box3Col6Controllers;
  late List<TextEditingController> _box3Col7Controllers;

  // Box 3 Focus Nodes for Excel / Spreadsheet style Keyboard Navigation (7 Cols x 4 Rows)
  late List<List<FocusNode>> _box3FocusNodes;

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

    // Box 3 Controllers Init (7 Column Headers x 4 Input Rows)
    _box3JjWorkwayControllers = List.generate(4, (_) => TextEditingController());
    _box3TargetControllers = List.generate(4, (_) => TextEditingController());
    _box3YyControllers = List.generate(4, (_) => TextEditingController());
    _box3ZzControllers = List.generate(4, (_) => TextEditingController());
    _box3PercentageControllers = List.generate(4, (_) => TextEditingController());
    _box3Col6Controllers = List.generate(4, (_) => TextEditingController());
    _box3Col7Controllers = List.generate(4, (_) => TextEditingController());

    // Box 3 Focus Nodes Init (7 Cols x 4 Rows Grid)
    _box3FocusNodes = List.generate(
      7,
      (colIdx) => List.generate(4, (rowIdx) {
        final node = FocusNode();
        node.addListener(() {
          if (node.hasFocus) {
            final controller = _getBox3Controller(colIdx, rowIdx);
            if (controller.text.isNotEmpty) {
              controller.selection = TextSelection(
                baseOffset: 0,
                extentOffset: controller.text.length,
              );
            }
          }
        });
        return node;
      }),
    );

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
    for (var c in _box3Col6Controllers) {
      c.dispose();
    }
    for (var c in _box3Col7Controllers) {
      c.dispose();
    }

    // Box 3 Focus Nodes Dispose
    for (var col in _box3FocusNodes) {
      for (var node in col) {
        node.dispose();
      }
    }

    // Box 4 Controllers Dispose
    _box4BalanceController.dispose();
    _box4TargetController.dispose();
    _box4AchievedController.dispose();

    // Monthly Topic Table Controllers Dispose
    for (var c in _topicCellControllers.values) {
      c.dispose();
    }
    _topicCellControllers.clear();

    super.dispose();
  }

  TextEditingController _getBox3Controller(int colIdx, int rowIdx) {
    switch (colIdx) {
      case 0:
        return _box3JjWorkwayControllers[rowIdx];
      case 1:
        return _box3TargetControllers[rowIdx];
      case 2:
        return _box3YyControllers[rowIdx];
      case 3:
        return _box3ZzControllers[rowIdx];
      case 4:
        return _box3PercentageControllers[rowIdx];
      case 5:
        return _box3Col6Controllers[rowIdx];
      case 6:
        return _box3Col7Controllers[rowIdx];
      default:
        return _box3JjWorkwayControllers[rowIdx];
    }
  }

  // Excel / Spreadsheet Navigation Helpers
  void _focusCell(int colIdx, int rowIdx) {
    if (rowIdx >= 4) {
      rowIdx = 0;
      colIdx = (colIdx + 1) % 7;
    } else if (rowIdx < 0) {
      rowIdx = 3;
      colIdx = (colIdx - 1 + 7) % 7;
    }

    if (colIdx >= 7) {
      colIdx = 0;
    } else if (colIdx < 0) {
      colIdx = 6;
    }

    _box3FocusNodes[colIdx][rowIdx].requestFocus();
  }

  void _focusNextRow(int colIdx, int rowIdx) {
    _focusCell(colIdx, rowIdx + 1);
  }

  void _focusPrevRow(int colIdx, int rowIdx) {
    _focusCell(colIdx, rowIdx - 1);
  }

  void _focusNextCol(int colIdx, int rowIdx) {
    _focusCell(colIdx + 1, rowIdx);
  }

  void _focusPrevCol(int colIdx, int rowIdx) {
    _focusCell(colIdx - 1, rowIdx);
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
    final box3Col6Values = [
      record.box3Col6Col1,
      record.box3Col6Col2,
      record.box3Col6Col3,
      record.box3Col6Col4,
    ];
    final box3Col7Values = [
      record.box3Col7Col1,
      record.box3Col7Col2,
      record.box3Col7Col3,
      record.box3Col7Col4,
    ];

    _syncRowControllers(_box3JjWorkwayControllers, box3JjWorkwayValues);
    _syncRowControllers(_box3TargetControllers, box3TargetValues);
    _syncRowControllers(_box3YyControllers, box3YyValues);
    _syncRowControllers(_box3ZzControllers, box3ZzValues);
    _syncRowControllers(_box3PercentageControllers, box3PercentageValues);
    _syncRowControllers(_box3Col6Controllers, box3Col6Values);
    _syncRowControllers(_box3Col7Controllers, box3Col7Values);
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

  void _syncTopicControllers(PerformanceRecord record) {
    final rowCount = record.topicRows.length;
    final keysToRemove = <String>[];
    _topicCellControllers.forEach((key, controller) {
      if (key.startsWith('date_')) {
        final rIdx = int.tryParse(key.substring(5));
        if (rIdx == null || rIdx >= rowCount) {
          keysToRemove.add(key);
        }
      } else if (key.startsWith('cell_')) {
        final parts = key.split('_');
        if (parts.length >= 2) {
          final rIdx = int.tryParse(parts[1]);
          if (rIdx == null || rIdx >= rowCount) {
            keysToRemove.add(key);
          }
        }
      }
    });

    for (final k in keysToRemove) {
      _topicCellControllers[k]?.dispose();
      _topicCellControllers.remove(k);
    }
  }

  TextEditingController _getTopicCellController(String key, String initialText) {
    if (!_topicCellControllers.containsKey(key)) {
      _topicCellControllers[key] = TextEditingController(text: initialText);
    } else {
      if (_topicCellControllers[key]!.text != initialText && !_topicCellControllers[key]!.selection.isValid) {
        _topicCellControllers[key]!.text = initialText;
      }
    }
    return _topicCellControllers[key]!;
  }

  @override
  Widget build(BuildContext context) {
    final selectedYear = ref.watch(selectedPerformanceYearProvider);
    final selectedMonth = ref.watch(selectedPerformanceMonthProvider);
    final providerKey = '${selectedYear}_$selectedMonth';

    if (_lastLoadedKey != providerKey) {
      _lastLoadedKey = providerKey;
      _topicTablePage = 0;
      for (var c in _topicCellControllers.values) {
        c.dispose();
      }
      _topicCellControllers.clear();
    }

    final performanceRecord = ref.watch(performanceRecordProvider(providerKey));
    final notifier = ref.read(performanceRecordProvider(providerKey).notifier);

    // Sync input text controllers with loaded record
    _syncControllers(performanceRecord);
    _syncTopicControllers(performanceRecord);

    final bool isDesktop = MediaQuery.of(context).size.width > 700;

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: BrandBackground(
        child: CustomScrollView(
          slivers: [
            // Top Header Bar
            SliverToBoxAdapter(
              child: Container(
                color: AppColors.cardSurface,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 16,
                  runSpacing: 12,
                  children: [
                    // Tab Heading (Left Side)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.badgeBlueBg,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(Icons.analytics_rounded, color: AppColors.skyBlue, size: 24),
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Performance Dashboard',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.headingText),
                        ),
                      ],
                    ),

                  // Year and Month Controls (Right Side, Same Line)
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Year Control Box
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.calendar_month_rounded, size: 16, color: Colors.blueAccent),
                            const SizedBox(width: 6),
                            const Text(
                              'YEAR',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.blueGrey,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 6),
                             DropdownButtonHideUnderline(
                              child: KeyCycleDropdownButton<int>(
                                value: selectedYear,
                                isDense: true,
                                icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.blueAccent, size: 18),
                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900, fontSize: 14),
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
                          ],
                        ),
                      ),

                      const SizedBox(width: 10),

                      // Month Navigation & Control Bar
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(width: 4),
                            const Icon(Icons.date_range_rounded, size: 16, color: Colors.blueAccent),
                            const SizedBox(width: 4),
                            const Text(
                              'MONTH',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 11,
                                color: Colors.blueGrey,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(width: 8),

                            // Left Navigation Button (<)
                            Material(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(6),
                                onTap: () => _previousMonth(selectedYear, selectedMonth),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.blue.shade200),
                                  ),
                                  child: const Icon(Icons.chevron_left_rounded, size: 16, color: Colors.blueAccent),
                                ),
                              ),
                            ),

                            const SizedBox(width: 6),

                            // Month Dropdown Selector
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: Colors.blue.shade200),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: KeyCycleDropdownButton<int>(
                                  value: selectedMonth,
                                  isDense: true,
                                  icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.blueAccent, size: 18),
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue.shade900, fontSize: 14),
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

                            const SizedBox(width: 6),

                            // Right Navigation Button (>)
                            Material(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(6),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(6),
                                onTap: () => _nextMonth(selectedYear, selectedMonth),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(6),
                                    border: Border.all(color: Colors.blue.shade200),
                                  ),
                                  child: const Icon(Icons.chevron_right_rounded, size: 16, color: Colors.blueAccent),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Main Performance Containers Layout
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LayoutBuilder(
                    builder: (context, constraints) {
                      final double halfWidth = isDesktop ? (constraints.maxWidth - 16) / 2 : constraints.maxWidth;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Row 1: Primary Metrics & Days & Earnings
                          if (isDesktop)
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: halfWidth,
                                  child: _buildBoxOneCard(context, notifier),
                                ),
                                const SizedBox(width: 16),
                                SizedBox(
                                  width: halfWidth,
                                  child: Column(
                                    children: [
                                      _buildBoxTwoCard(context, notifier),
                                      const SizedBox(height: 16),
                                      _buildBoxFourCard(context, notifier),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          else ...[
                            _buildBoxOneCard(context, notifier),
                            const SizedBox(height: 16),
                            _buildBoxTwoCard(context, notifier),
                            const SizedBox(height: 16),
                            _buildBoxFourCard(context, notifier),
                          ],

                          const SizedBox(height: 16),

                          // Row 2: JJ Workway & Targets (Spreadsheet keyboard-navigable matrix)
                          _buildBoxThreeCard(context, notifier),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 24),

                  // ==================== MONTHLY TOPIC TABLE (14 COLUMNS) ====================
                  _buildMonthlyTopicTableCard(context, performanceRecord, notifier),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  // Second Half: Monthly Topic Matrix Table Card (14 Columns with 10 Entries/Page Pagination)
  Widget _buildMonthlyTopicTableCard(
    BuildContext context,
    PerformanceRecord record,
    PerformanceNotifier notifier,
  ) {
    // Determine Topic Headers (Topic 1 to Topic 13)
    final topicHeaders = List<String>.generate(13, (i) {
      if (i < record.topicHeaders.length && record.topicHeaders[i].trim().isNotEmpty) {
        return record.topicHeaders[i];
      }
      return 'Topic ${i + 1}';
    });

    // Pagination Calculations (10 entries per page)
    final totalEntries = record.topicRows.length;
    final totalPages = totalEntries == 0 ? 1 : ((totalEntries + _entriesPerPage - 1) ~/ _entriesPerPage);

    if (_topicTablePage >= totalPages) {
      _topicTablePage = (totalPages - 1).clamp(0, totalPages);
    }

    final startIndex = _topicTablePage * _entriesPerPage;
    final endIndex = (startIndex + _entriesPerPage) < totalEntries ? (startIndex + _entriesPerPage) : totalEntries;

    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.blue.shade100, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header Bar with Title & Add Entry Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Monthly Activity & Topic Matrix',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
                ),

                // Add Entry Button
                ElevatedButton.icon(
                  onPressed: () async {
                    final now = DateTime.now();
                    final todayStr = DateFormat('dd/MM/yyyy').format(now);
                    await notifier.addTopicRow(dateStr: todayStr);
                    final newTotal = record.topicRows.length + 1;
                    final newPage = (newTotal - 1) ~/ _entriesPerPage;
                    setState(() {
                      _topicTablePage = newPage;
                    });
                  },
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Add Entry', style: TextStyle(fontWeight: FontWeight.bold)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    elevation: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),
            const Divider(height: 1),
            const SizedBox(height: 16),

            // Table Content Area
            if (record.topicRows.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: Column(
                  children: [
                    Icon(Icons.post_add_rounded, size: 48, color: Colors.blue.shade200),
                    const SizedBox(height: 12),
                    Text(
                      'No entries added for ${_monthNames[record.month - 1]} ${record.year} yet.',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Click the "+ Add Entry" button to add a new row to this month\'s performance table.',
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () async {
                        final now = DateTime.now();
                        final todayStr = DateFormat('dd/MM/yyyy').format(now);
                        await notifier.addTopicRow(dateStr: todayStr);
                        final newTotal = record.topicRows.length + 1;
                        final newPage = (newTotal - 1) ~/ _entriesPerPage;
                        setState(() {
                          _topicTablePage = newPage;
                        });
                      },
                      icon: const Icon(Icons.add_rounded, size: 18),
                      label: const Text('Add Entry', style: TextStyle(fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        elevation: 1,
                      ),
                    ),
                  ],
                ),
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue.shade100),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Header Row (14 Columns: Date + Topic 1..13 + Action)
                        Container(
                          color: Colors.blue.shade50,
                          child: Row(
                            children: [
                              // Col 1: Date Header
                              Container(
                                width: 140,
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                                alignment: Alignment.centerLeft,
                                decoration: BoxDecoration(
                                  border: Border(right: BorderSide(color: Colors.blue.shade200)),
                                ),
                                child: const Text(
                                  'Date',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent, fontSize: 13),
                                ),
                              ),

                              // Cols 2..14: Topic 1 to Topic 13 Headers (Renameable)
                              for (int c = 0; c < 13; c++)
                                Container(
                                  width: 160,
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                                  decoration: BoxDecoration(
                                    border: Border(right: BorderSide(color: Colors.blue.shade200)),
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(6),
                                    onTap: () {
                                      _showRenameTopicDialog(context, c, topicHeaders[c], notifier);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: Colors.blue.shade200),
                                      ),
                                      child: Text(
                                        topicHeaders[c],
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.blue.shade900,
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),

                              // Action Column Header
                              Container(
                                width: 60,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                                alignment: Alignment.center,
                                child: const Text(
                                  'Action',
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey, fontSize: 11),
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Table Body Rows (Paginated: 10 per page, Typable multiline cells)
                        for (int r = startIndex; r < endIndex; r++) ...[
                          Container(
                            decoration: BoxDecoration(
                              color: r.isEven ? Colors.white : Colors.grey.shade50.withOpacity(0.5),
                              border: Border(top: BorderSide(color: Colors.grey.shade200)),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Col 1: Date Cell
                                Container(
                                  width: 140,
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    border: Border(right: BorderSide(color: Colors.grey.shade200)),
                                  ),
                                  child: TextField(
                                    controller: _getTopicCellController('date_$r', record.topicRows[r].dateStr),
                                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                                    decoration: InputDecoration(
                                      isDense: true,
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      suffixIcon: IconButton(
                                        icon: const Icon(Icons.event, size: 16, color: Colors.blueAccent),
                                        padding: EdgeInsets.zero,
                                        constraints: const BoxConstraints(),
                                        onPressed: () async {
                                          final currentParts = record.topicRows[r].dateStr.split('/');
                                          DateTime initialDate = DateTime.now();
                                          if (currentParts.length == 3) {
                                            final d = int.tryParse(currentParts[0]);
                                            final m = int.tryParse(currentParts[1]);
                                            final y = int.tryParse(currentParts[2]);
                                            if (d != null && m != null && y != null) {
                                              initialDate = DateTime(y, m, d);
                                            }
                                          }
                                          final picked = await showDatePicker(
                                            context: context,
                                            initialDate: initialDate,
                                            firstDate: DateTime(2000),
                                            lastDate: DateTime(2100),
                                          );
                                          if (picked != null) {
                                            final formatted = DateFormat('dd/MM/yyyy').format(picked);
                                            _topicCellControllers['date_$r']?.text = formatted;
                                            notifier.updateTopicRowDate(r, formatted);
                                          }
                                        },
                                      ),
                                    ),
                                    onChanged: (val) {
                                      notifier.updateTopicRowDate(r, val);
                                    },
                                  ),
                                ),

                                // Cols 2..14: Topic 1 to Topic 13 Multiline Cells (Enter inserts \n)
                                for (int c = 0; c < 13; c++)
                                  Container(
                                    width: 160,
                                    padding: const EdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      border: Border(right: BorderSide(color: Colors.grey.shade200)),
                                    ),
                                    child: TextField(
                                      controller: _getTopicCellController(
                                        'cell_${r}_$c',
                                        c < record.topicRows[r].values.length ? record.topicRows[r].values[c] : '',
                                      ),
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      minLines: 1,
                                      textInputAction: TextInputAction.newline,
                                      style: const TextStyle(fontSize: 12),
                                      decoration: InputDecoration(
                                        isDense: true,
                                        hintText: 'Type text...',
                                        hintStyle: TextStyle(fontSize: 11, color: Colors.grey.shade400),
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: BorderSide(color: Colors.grey.shade300),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(6),
                                          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      onChanged: (val) {
                                        notifier.updateTopicCell(r, c, val);
                                      },
                                    ),
                                  ),

                                // Action Cell (Delete Row Button)
                                Container(
                                  width: 60,
                                  padding: const EdgeInsets.all(6),
                                  alignment: Alignment.center,
                                  child: IconButton(
                                    icon: const Icon(Icons.delete_outline_rounded, color: Colors.redAccent, size: 20),
                                    tooltip: 'Delete Row #${r + 1}',
                                    onPressed: () {
                                      _topicCellControllers.remove('date_$r');
                                      for (int c = 0; c < 13; c++) {
                                        _topicCellControllers.remove('cell_${r}_$c');
                                      }
                                      notifier.deleteTopicRow(r);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),

            // Pagination Controls Footer Bar (10 Entries Per Page)
            if (record.topicRows.isNotEmpty) ...[
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.blue.shade50.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.blue.shade100),
                ),
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 8,
                  children: [
                    Text(
                      'Showing ${totalEntries == 0 ? 0 : startIndex + 1} to $endIndex of $totalEntries entries (10 per page)',
                      style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue.shade900),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Previous Page Button (<)
                        OutlinedButton.icon(
                          onPressed: _topicTablePage > 0
                              ? () {
                                  setState(() {
                                    _topicTablePage--;
                                  });
                                }
                              : null,
                          icon: const Icon(Icons.chevron_left_rounded, size: 18),
                          label: const Text('Prev', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            side: BorderSide(color: Colors.blue.shade200),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Page Number Badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Colors.blue.shade300),
                          ),
                          child: Text(
                            'Page ${_topicTablePage + 1} of $totalPages',
                            style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // Next Page Button (>)
                        OutlinedButton.icon(
                          onPressed: _topicTablePage < totalPages - 1
                              ? () {
                                  setState(() {
                                    _topicTablePage++;
                                  });
                                }
                              : null,
                          icon: const Text('Next', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                          label: const Icon(Icons.chevron_right_rounded, size: 18),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            side: BorderSide(color: Colors.blue.shade200),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // Rename Topic Dialog
  void _showRenameTopicDialog(
    BuildContext context,
    int colIdx,
    String currentTitle,
    PerformanceNotifier notifier,
  ) {
    final controller = TextEditingController(text: currentTitle);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          children: [
            const Icon(Icons.edit_note_rounded, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text('Rename Topic ${colIdx + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter a new title for column #${colIdx + 2}:',
              style: const TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Topic Title',
                hintText: 'e.g. Calls, Meetings, Proposals...',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onSubmitted: (val) {
                if (val.trim().isNotEmpty) {
                  notifier.updateTopicHeader(colIdx, val.trim());
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newTitle = controller.text.trim();
              if (newTitle.isNotEmpty) {
                notifier.updateTopicHeader(colIdx, newTitle);
              }
              Navigator.pop(context);
            },
            child: const Text('Save Header'),
          ),
        ],
      ),
    );
  }

  // Section 1: Primary Metrics Card
  Widget _buildBoxOneCard(BuildContext context, PerformanceNotifier notifier) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColors.violetAccent.withOpacity(0.3), width: 1.5),
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
                    color: AppColors.badgeVioletBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.dashboard_rounded, color: AppColors.violetAccent, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Primary Metrics',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.headingText),
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

  // Section 2: Days & Earnings Card
  Widget _buildBoxTwoCard(BuildContext context, PerformanceNotifier notifier) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColors.emeraldGreen.withOpacity(0.3), width: 1.5),
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
                    color: AppColors.badgeGreenBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.work_history_rounded, color: AppColors.emeraldGreen, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'Days & Earnings',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.headingText),
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

  // Section 3: JJ Workway & Targets Card (7 Columns x 4 Input Rows)
  Widget _buildBoxThreeCard(BuildContext context, PerformanceNotifier notifier) {
    final selectedYear = ref.watch(selectedPerformanceYearProvider);
    final selectedMonth = ref.watch(selectedPerformanceMonthProvider);
    final providerKey = '${selectedYear}_$selectedMonth';
    final performanceRecord = ref.watch(performanceRecordProvider(providerKey));

    final defaultColTitles = ['JJ workway', 'Target', 'YY', 'ZZ', 'Percentage', 'Column 6', 'Column 7'];
    final colTitles = List<String>.generate(7, (i) {
      if (i < performanceRecord.box3ColHeaders.length && performanceRecord.box3ColHeaders[i].trim().isNotEmpty) {
        return performanceRecord.box3ColHeaders[i];
      }
      return defaultColTitles[i];
    });

    final defaultRowTitles = ['Row 1', 'Row 2', 'Row 3', 'Row 4'];
    final rowTitles = List<String>.generate(4, (i) {
      if (i < performanceRecord.box3RowHeaders.length && performanceRecord.box3RowHeaders[i].trim().isNotEmpty) {
        return performanceRecord.box3RowHeaders[i];
      }
      return defaultRowTitles[i];
    });

    final columns = [
      {
        'title': colTitles[0],
        'icon': Icons.alt_route_rounded,
        'controllers': _box3JjWorkwayControllers,
        'prefixKey': 'box3JjWorkwayCol',
        'bgColor': AppColors.badgeIndigoBg,
        'fgColor': AppColors.badgeIndigoText,
      },
      {
        'title': colTitles[1],
        'icon': Icons.track_changes_rounded,
        'controllers': _box3TargetControllers,
        'prefixKey': 'box3TargetCol',
        'bgColor': AppColors.badgeRoseBg,
        'fgColor': AppColors.badgeRoseText,
      },
      {
        'title': colTitles[2],
        'icon': Icons.analytics_outlined,
        'controllers': _box3YyControllers,
        'prefixKey': 'box3YyCol',
        'bgColor': AppColors.badgeAmberBg,
        'fgColor': AppColors.badgeAmberText,
      },
      {
        'title': colTitles[3],
        'icon': Icons.assessment_outlined,
        'controllers': _box3ZzControllers,
        'prefixKey': 'box3ZzCol',
        'bgColor': AppColors.badgeCyanBg,
        'fgColor': AppColors.badgeCyanText,
      },
      {
        'title': colTitles[4],
        'icon': Icons.percent_rounded,
        'controllers': _box3PercentageControllers,
        'prefixKey': 'box3PercentageCol',
        'bgColor': AppColors.badgeGreenBg,
        'fgColor': AppColors.badgeGreenText,
      },
      {
        'title': colTitles[5],
        'icon': Icons.view_column_rounded,
        'controllers': _box3Col6Controllers,
        'prefixKey': 'box3Col6Col',
        'bgColor': AppColors.badgeBlueBg,
        'fgColor': AppColors.badgeBlueText,
      },
      {
        'title': colTitles[6],
        'icon': Icons.table_chart_outlined,
        'controllers': _box3Col7Controllers,
        'prefixKey': 'box3Col7Col',
        'bgColor': AppColors.badgeVioletBg,
        'fgColor': AppColors.badgeVioletText,
      },
    ];

    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColors.cyanAccent.withOpacity(0.3), width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.badgeCyanBg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.table_chart_rounded, color: AppColors.cyanAccent, size: 20),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'JJ Workway & Targets',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.headingText),
                    ),
                  ],
                ),
                Text(
                  '7 Columns Matrix',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.blue.shade700),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Spreadsheet Keyboard-Navigable Matrix (7 Columns x 4 Rows)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: columns.asMap().entries.map((entry) {
                  final int colIdx = entry.key;
                  final col = entry.value;
                  final String title = col['title'] as String;
                  final IconData icon = col['icon'] as IconData;
                  final List<TextEditingController> controllers = col['controllers'] as List<TextEditingController>;
                  final String prefixKey = col['prefixKey'] as String;

                  return Container(
                    width: 140,
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Column Header Badge (Editable)
                        InkWell(
                          onTap: () => _showRenameBox3ColDialog(context, colIdx, title, notifier),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                            decoration: BoxDecoration(
                              color: Colors.blue.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: Colors.blue.shade200),
                            ),
                            child: Text(
                              title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blueAccent,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // 4 Input Rows under this Column Header with Excel/Spreadsheet Keyboard Controls
                        ...List.generate(4, (rowIdx) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 6.0),
                            child: Focus(
                              onKeyEvent: (node, event) {
                                if (event is KeyDownEvent) {
                                  final key = event.logicalKey;
                                  if (key == LogicalKeyboardKey.arrowDown) {
                                    _focusNextRow(colIdx, rowIdx);
                                    return KeyEventResult.handled;
                                  } else if (key == LogicalKeyboardKey.arrowUp) {
                                    _focusPrevRow(colIdx, rowIdx);
                                    return KeyEventResult.handled;
                                  } else if (key == LogicalKeyboardKey.arrowRight) {
                                    bool isAtEnd = false;
                                    final sel = controllers[rowIdx].selection;
                                    if (!sel.isValid || sel.isCollapsed) {
                                      if (sel.baseOffset == controllers[rowIdx].text.length) {
                                        isAtEnd = true;
                                      }
                                    } else {
                                      isAtEnd = true;
                                    }
                                    if (isAtEnd) {
                                      _focusNextCol(colIdx, rowIdx);
                                      return KeyEventResult.handled;
                                    }
                                  } else if (key == LogicalKeyboardKey.arrowLeft) {
                                    bool isAtStart = false;
                                    final sel = controllers[rowIdx].selection;
                                    if (!sel.isValid || sel.isCollapsed) {
                                      if (sel.baseOffset == 0) {
                                        isAtStart = true;
                                      }
                                    } else {
                                      isAtStart = true;
                                    }
                                    if (isAtStart) {
                                      _focusPrevCol(colIdx, rowIdx);
                                      return KeyEventResult.handled;
                                    }
                                  }
                                }
                                return KeyEventResult.ignored;
                              },
                              child: TextField(
                                focusNode: _box3FocusNodes[colIdx][rowIdx],
                                controller: controllers[rowIdx],
                                textInputAction: TextInputAction.next,
                                onSubmitted: (_) {
                                  _focusNextRow(colIdx, rowIdx);
                                },
                                onChanged: (val) {
                                  notifier.updateBox3Field('$prefixKey${rowIdx + 1}', val);
                                },
                                style: const TextStyle(fontSize: 12),
                                decoration: InputDecoration(
                                  isDense: true,
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: BorderSide(color: Colors.grey.shade300),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(6),
                                    borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
                                  ),
                                  filled: true,
                                  fillColor: Colors.grey.shade50,
                                ),
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

  // Rename Box 3 Column Dialog
  void _showRenameBox3ColDialog(
    BuildContext context,
    int colIdx,
    String currentTitle,
    PerformanceNotifier notifier,
  ) {
    final controller = TextEditingController(text: currentTitle);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          children: [
            const Icon(Icons.edit_note_rounded, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text('Rename Column #${colIdx + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter a custom title for this target matrix column:',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Column Header',
                hintText: 'e.g. Target, Achieved, Notes...',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onSubmitted: (val) {
                if (val.trim().isNotEmpty) {
                  notifier.updateBox3ColHeader(colIdx, val.trim());
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newTitle = controller.text.trim();
              if (newTitle.isNotEmpty) {
                notifier.updateBox3ColHeader(colIdx, newTitle);
              }
              Navigator.pop(context);
            },
            child: const Text('Save Header'),
          ),
        ],
      ),
    );
  }

  // Rename Box 3 Row Heading Dialog
  void _showRenameBox3RowDialog(
    BuildContext context,
    int rowIdx,
    String currentTitle,
    PerformanceNotifier notifier,
  ) {
    final controller = TextEditingController(text: currentTitle);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        title: Row(
          children: [
            const Icon(Icons.edit_rounded, color: Colors.blueAccent),
            const SizedBox(width: 8),
            Text('Rename Row Heading #${rowIdx + 1}', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter a custom label for this target matrix row heading:',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                labelText: 'Row Heading Label',
                hintText: 'e.g. Life Insurance, Health, General...',
                border: OutlineInputBorder(),
                isDense: true,
              ),
              onSubmitted: (val) {
                if (val.trim().isNotEmpty) {
                  notifier.updateBox3RowHeader(rowIdx, val.trim());
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final newTitle = controller.text.trim();
              if (newTitle.isNotEmpty) {
                notifier.updateBox3RowHeader(rowIdx, newTitle);
              }
              Navigator.pop(context);
            },
            child: const Text('Save Row Heading'),
          ),
        ],
      ),
    );
  }

  // Section 4: For MDRT Card
  Widget _buildBoxFourCard(BuildContext context, PerformanceNotifier notifier) {
    return Card(
      elevation: 1,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(color: AppColors.amberAccent.withOpacity(0.3), width: 1.5),
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
                    color: AppColors.badgeAmberBg,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.stars_rounded, color: AppColors.amberAccent, size: 20),
                ),
                const SizedBox(width: 10),
                const Text(
                  'For MDRT Goal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.headingText),
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

  // Reusable text input field aligned with app design system
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
        labelStyle: TextStyle(color: Colors.grey.shade700, fontSize: 13, fontWeight: FontWeight.w500),
        prefixIcon: Icon(icon, size: 18, color: Colors.blue.shade700),
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
