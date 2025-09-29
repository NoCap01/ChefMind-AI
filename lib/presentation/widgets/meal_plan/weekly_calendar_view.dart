import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/meal_plan.dart';
import '../../../domain/enums/meal_type.dart';
import '../../../application/providers/meal_planner_provider.dart';
import 'meal_slot_widget.dart';

class WeeklyCalendarView extends ConsumerStatefulWidget {
  final MealPlan? mealPlan;
  final DateTime? selectedDate;
  final ValueChanged<DateTime>? onDateSelected;

  const WeeklyCalendarView({
    super.key,
    this.mealPlan,
    this.selectedDate,
    this.onDateSelected,
  });

  @override
  ConsumerState<WeeklyCalendarView> createState() => _WeeklyCalendarViewState();
}

class _WeeklyCalendarViewState extends ConsumerState<WeeklyCalendarView> {
  late DateTime _currentWeekStart;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    final now = widget.selectedDate ?? DateTime.now();
    _currentWeekStart = _getWeekStart(now);
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  DateTime _getWeekStart(DateTime date) {
    final weekday = date.weekday;
    return date.subtract(Duration(days: weekday % 7));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Week navigation header
        _buildWeekHeader(theme),
        
        // Calendar view
        Expanded(
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentWeekStart = _currentWeekStart.add(Duration(days: 7 * (index - 1000)));
              });
            },
            itemBuilder: (context, index) {
              final weekStart = _currentWeekStart.add(Duration(days: 7 * (index - 1000)));
              return _buildWeekView(weekStart);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildWeekHeader(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: theme.colorScheme.outline.withValues(alpha: 0.2),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _getWeekRangeText(_currentWeekStart),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () => _navigateWeek(-1),
                icon: const Icon(Icons.chevron_left),
                tooltip: 'Previous week',
              ),
              TextButton(
                onPressed: () => _goToCurrentWeek(),
                child: const Text('Today'),
              ),
              IconButton(
                onPressed: () => _navigateWeek(1),
                icon: const Icon(Icons.chevron_right),
                tooltip: 'Next week',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeekView(DateTime weekStart) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Day headers
          _buildDayHeaders(weekStart),
          
          // Meal slots for each day
          for (int dayIndex = 0; dayIndex < 7; dayIndex++)
            _buildDayColumn(weekStart.add(Duration(days: dayIndex))),
        ],
      ),
    );
  }

  Widget _buildDayHeaders(DateTime weekStart) {
    final theme = Theme.of(context);
    final today = DateTime.now();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          for (int i = 0; i < 7; i++) ...[
            Expanded(
              child: GestureDetector(
                onTap: () {
                  final date = weekStart.add(Duration(days: i));
                  widget.onDateSelected?.call(date);
                  ref.read(selectedDateProvider.notifier).state = date;
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: _isSameDay(weekStart.add(Duration(days: i)), widget.selectedDate ?? today)
                        ? theme.colorScheme.primaryContainer
                        : null,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(
                        _getDayName(i),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        weekStart.add(Duration(days: i)).day.toString(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: _isSameDay(weekStart.add(Duration(days: i)), today)
                              ? theme.colorScheme.primary
                              : _isSameDay(weekStart.add(Duration(days: i)), widget.selectedDate ?? today)
                                  ? theme.colorScheme.onPrimaryContainer
                                  : null,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildDayColumn(DateTime date) {
    final theme = Theme.of(context);
    final dailyPlan = _getDailyPlan(date);
    final isSelected = _isSameDay(date, widget.selectedDate ?? DateTime.now());

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isSelected 
            ? theme.colorScheme.primaryContainer.withValues(alpha: 0.1)
            : theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: isSelected 
            ? Border.all(color: theme.colorScheme.primary.withValues(alpha: 0.3))
            : null,
      ),
      child: Column(
        children: [
          // Date header
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Text(
                  _formatDateHeader(date),
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Spacer(),
                if (dailyPlan != null && _getPlannedMealsCount(dailyPlan) > 0) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${_getCookedMealsCount(dailyPlan)}/${_getPlannedMealsCount(dailyPlan)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onPrimaryContainer,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          
          // Meal slots
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Column(
              children: [
                for (final mealType in MealType.values)
                  MealSlotWidget(
                    date: date,
                    mealType: mealType,
                    plannedMeal: dailyPlan?.meals[mealType],
                  ),
              ],
            ),
          ),
          
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  DailyMealPlan? _getDailyPlan(DateTime date) {
    if (widget.mealPlan == null) return null;
    
    try {
      return widget.mealPlan!.dailyPlans.firstWhere(
        (plan) => _isSameDay(plan.date, date),
      );
    } catch (e) {
      return null;
    }
  }

  int _getPlannedMealsCount(DailyMealPlan dailyPlan) {
    return dailyPlan.meals.values.where((meal) => meal != null).length;
  }

  int _getCookedMealsCount(DailyMealPlan dailyPlan) {
    return dailyPlan.meals.values
        .where((meal) => meal?.isCooked == true)
        .length;
  }

  String _getWeekRangeText(DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    final monthNames = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];

    if (weekStart.month == weekEnd.month) {
      return '${monthNames[weekStart.month - 1]} ${weekStart.day}-${weekEnd.day}, ${weekStart.year}';
    } else {
      return '${monthNames[weekStart.month - 1]} ${weekStart.day} - ${monthNames[weekEnd.month - 1]} ${weekEnd.day}, ${weekStart.year}';
    }
  }

  String _getDayName(int dayIndex) {
    const dayNames = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    return dayNames[dayIndex];
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    if (_isSameDay(date, now)) {
      return 'Today';
    } else if (_isSameDay(date, now.add(const Duration(days: 1)))) {
      return 'Tomorrow';
    } else if (_isSameDay(date, now.subtract(const Duration(days: 1)))) {
      return 'Yesterday';
    } else {
      const monthNames = [
        'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
      ];
      return '${monthNames[date.month - 1]} ${date.day}';
    }
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _navigateWeek(int direction) {
    setState(() {
      _currentWeekStart = _currentWeekStart.add(Duration(days: 7 * direction));
    });
  }

  void _goToCurrentWeek() {
    final now = DateTime.now();
    setState(() {
      _currentWeekStart = _getWeekStart(now);
    });
    widget.onDateSelected?.call(now);
    ref.read(selectedDateProvider.notifier).state = now;
  }
}