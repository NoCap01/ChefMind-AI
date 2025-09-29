import 'package:flutter/material.dart';

class MealCalendar extends StatefulWidget {
  final DateTime initialDate;
  final Map<DateTime, List<dynamic>> mealPlans;
  final ValueChanged<DateTime>? onDateSelected;

  const MealCalendar({
    super.key,
    required this.initialDate,
    required this.mealPlans,
    this.onDateSelected,
  });

  @override
  State<MealCalendar> createState() => _MealCalendarState();
}

class _MealCalendarState extends State<MealCalendar> {
  late DateTime _selectedDate;
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _focusedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Calendar header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _getMonthYearString(_focusedDate),
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => _changeMonth(-1),
                      icon: const Icon(Icons.chevron_left),
                    ),
                    IconButton(
                      onPressed: () => _changeMonth(1),
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Weekday headers
            Row(
              children: ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']
                  .map((day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),

            const SizedBox(height: 8),

            // Calendar grid
            ..._buildCalendarWeeks(),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildCalendarWeeks() {
    final firstDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month, 1);
    final lastDayOfMonth = DateTime(_focusedDate.year, _focusedDate.month + 1, 0);
    final firstDayOfWeek = firstDayOfMonth.weekday % 7;

    final weeks = <Widget>[];
    var currentDate = firstDayOfMonth.subtract(Duration(days: firstDayOfWeek));

    while (currentDate.isBefore(lastDayOfMonth) || currentDate.day != lastDayOfMonth.day) {
      final weekDays = <Widget>[];
      
      for (int i = 0; i < 7; i++) {
        weekDays.add(_buildCalendarDay(currentDate));
        currentDate = currentDate.add(const Duration(days: 1));
      }

      weeks.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Row(children: weekDays),
        ),
      );

      if (currentDate.month != _focusedDate.month && currentDate.day > 7) {
        break;
      }
    }

    return weeks;
  }

  Widget _buildCalendarDay(DateTime date) {
    final theme = Theme.of(context);
    final isCurrentMonth = date.month == _focusedDate.month;
    final isSelected = _isSameDay(date, _selectedDate);
    final isToday = _isSameDay(date, DateTime.now());
    final hasMealPlan = widget.mealPlans.containsKey(_normalizeDate(date));

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() => _selectedDate = date);
          widget.onDateSelected?.call(date);
        },
        child: Container(
          height: 40,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: isSelected
                ? theme.colorScheme.primary
                : isToday
                    ? theme.colorScheme.primaryContainer
                    : null,
            borderRadius: BorderRadius.circular(8),
            border: hasMealPlan && !isSelected
                ? Border.all(color: theme.colorScheme.primary, width: 1)
                : null,
          ),
          child: Stack(
            children: [
              Center(
                child: Text(
                  date.day.toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : isToday
                            ? theme.colorScheme.onPrimaryContainer
                            : isCurrentMonth
                                ? theme.colorScheme.onSurface
                                : theme.colorScheme.onSurface.withOpacity(0.4),
                    fontWeight: isSelected || isToday ? FontWeight.bold : null,
                  ),
                ),
              ),
              if (hasMealPlan && !isSelected)
                Positioned(
                  bottom: 2,
                  right: 2,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _changeMonth(int delta) {
    setState(() {
      _focusedDate = DateTime(_focusedDate.year, _focusedDate.month + delta, 1);
    });
  }

  String _getMonthYearString(DateTime date) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return '${months[date.month - 1]} ${date.year}';
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}