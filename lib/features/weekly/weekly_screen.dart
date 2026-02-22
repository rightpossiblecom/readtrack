import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readtrack/features/weekly/weekly_view_model.dart';

class WeeklyScreen extends StatefulWidget {
  const WeeklyScreen({super.key});

  @override
  State<WeeklyScreen> createState() => _WeeklyScreenState();
}

class _WeeklyScreenState extends State<WeeklyScreen> {
  static const _dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeeklyViewModel>().load();
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final today = DateTime.now();
    final todayNorm = DateTime(today.year, today.month, today.day);

    return Consumer<WeeklyViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: cs.surface,
          appBar: AppBar(
            backgroundColor: cs.surface,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text('Weekly Summary', style: tt.titleLarge),
          ),
          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    children: [
                      // Stat cards
                      Row(
                        children: [
                          Expanded(
                            child: _StatCard(
                              label: 'Total This Week',
                              value: '${vm.totalMinutes} min',
                              icon: Icons.menu_book_rounded,
                              colorScheme: cs,
                              textTheme: tt,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: _StatCard(
                              label: 'Longest Streak',
                              value: '${vm.longestStreak} 🔥',
                              icon: Icons.local_fire_department_rounded,
                              colorScheme: cs,
                              textTheme: tt,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      Text(
                        'Daily Breakdown',
                        style: tt.labelLarge?.copyWith(
                          color: cs.onSurfaceVariant,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),

                      ...vm.days.asMap().entries.map((entry) {
                        final i = entry.key;
                        final date = entry.value.key;
                        final minutes = entry.value.value;
                        final isToday = date == todayNorm;
                        final frac = vm.maxMinutes > 0
                            ? minutes / vm.maxMinutes
                            : 0.0;
                        final dayName = _dayNames[date.weekday - 1];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: _DayRow(
                            dayName: isToday ? 'Today' : dayName,
                            minutes: minutes,
                            fraction: frac,
                            isToday: isToday,
                            colorScheme: cs,
                            textTheme: tt,
                            index: i,
                          ),
                        );
                      }),
                    ],
                  ),
                ),
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.colorScheme,
    required this.textTheme,
  });
  final String label;
  final String value;
  final IconData icon;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colorScheme.primary, size: 22),
          const SizedBox(height: 10),
          Text(
            value,
            style: textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: textTheme.bodySmall?.copyWith(
              color: colorScheme.onPrimaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _DayRow extends StatelessWidget {
  const _DayRow({
    required this.dayName,
    required this.minutes,
    required this.fraction,
    required this.isToday,
    required this.colorScheme,
    required this.textTheme,
    required this.index,
  });

  final String dayName;
  final int minutes;
  final double fraction;
  final bool isToday;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final int index;

  @override
  Widget build(BuildContext context) {
    final barColor = isToday
        ? colorScheme.primary
        : minutes > 0
        ? colorScheme.secondary
        : colorScheme.surfaceContainerHighest;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isToday
            ? colorScheme.secondaryContainer
            : colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(12),
        border: isToday
            ? Border.all(color: colorScheme.primary.withAlpha(120), width: 1.5)
            : null,
      ),
      child: Row(
        children: [
          SizedBox(
            width: 44,
            child: Text(
              dayName,
              style: textTheme.labelMedium?.copyWith(
                fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                color: isToday ? colorScheme.primary : colorScheme.onSurface,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: TweenAnimationBuilder<double>(
                tween: Tween(begin: 0, end: fraction),
                duration: Duration(milliseconds: 500 + index * 60),
                curve: Curves.easeOut,
                builder: (_, val, child) => LinearProgressIndicator(
                  value: val,
                  minHeight: 8,
                  backgroundColor: colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation<Color>(barColor),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 52,
            child: Text(
              minutes > 0 ? '$minutes min' : '–',
              textAlign: TextAlign.right,
              style: textTheme.labelMedium?.copyWith(
                color: minutes > 0
                    ? colorScheme.onSurface
                    : colorScheme.outline,
                fontWeight: minutes > 0 ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
