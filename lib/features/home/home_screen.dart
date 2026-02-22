import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:readtrack/features/home/home_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final TextEditingController _minutesController = TextEditingController();
  bool _isEditing = false;

  late AnimationController _streakAnimController;
  late Animation<double> _streakScaleAnim;
  late AnimationController _goalAnimController;
  late Animation<double> _goalPulseAnim;

  @override
  void initState() {
    super.initState();
    _streakAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _streakScaleAnim = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _streakAnimController, curve: Curves.elasticOut),
    );

    _goalAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _goalPulseAnim = Tween<double>(begin: 1.0, end: 1.08).animate(
      CurvedAnimation(parent: _goalAnimController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _minutesController.dispose();
    _streakAnimController.dispose();
    _goalAnimController.dispose();
    super.dispose();
  }

  Future<void> _logMinutes(HomeViewModel vm) async {
    final text = _minutesController.text.trim();
    final minutes = int.tryParse(text);
    if (minutes == null || minutes < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid number of minutes.'),
        ),
      );
      return;
    }

    final wasGoalReached = vm.goalReached;
    await vm.logMinutes(minutes);
    HapticFeedback.lightImpact();

    _streakAnimController.forward(from: 0);

    if (!wasGoalReached && vm.goalReached) {
      _goalAnimController.forward(from: 0);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Theme.of(context).colorScheme.primary,
            content: Row(
              children: [
                const Text('🎉  '),
                Text(
                  'Daily goal reached!',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    setState(() => _isEditing = false);
    _minutesController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Consumer<HomeViewModel>(
      builder: (context, vm, _) {
        if (vm.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        final now = DateTime.now();
        final dateStr =
            '${_weekday(now.weekday)}, ${_month(now.month)} ${now.day}';

        return Scaffold(
          backgroundColor: cs.surface,
          appBar: AppBar(
            backgroundColor: cs.surface,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text(
              dateStr,
              style: tt.titleMedium?.copyWith(color: cs.onSurfaceVariant),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: _StreakBadge(
                  streak: vm.currentStreak,
                  scaleAnim: _streakScaleAnim,
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  // Goal progress ring + minutes display
                  _GoalRing(
                    progress: vm.goalProgress,
                    goalReached: vm.goalReached,
                    todayMinutes: vm.todayMinutes,
                    dailyGoal: vm.dailyGoal,
                    pulseAnim: _goalPulseAnim,
                    colorScheme: cs,
                    textTheme: tt,
                  ),
                  const SizedBox(height: 36),

                  // Input or logged display
                  if (vm.todayMinutes > 0 && !_isEditing)
                    _LoggedDisplay(
                      minutes: vm.todayMinutes,
                      onEdit: () => setState(() {
                        _isEditing = true;
                        _minutesController.text = vm.todayMinutes.toString();
                      }),
                      colorScheme: cs,
                      textTheme: tt,
                    )
                  else
                    _InputSection(
                      controller: _minutesController,
                      onLog: () => _logMinutes(vm),
                      colorScheme: cs,
                    ),

                  const SizedBox(height: 40),

                  // Weekly preview
                  _WeeklyMiniPreview(
                    preview: vm.weeklyPreview,
                    colorScheme: cs,
                    textTheme: tt,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  String _weekday(int wd) =>
      ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'][wd - 1];

  String _month(int m) => [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ][m - 1];
}

// ─────────────────────────────────────────────────────────────────────────────

class _StreakBadge extends StatelessWidget {
  const _StreakBadge({required this.streak, required this.scaleAnim});
  final int streak;
  final Animation<double> scaleAnim;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return ScaleTransition(
      scale: scaleAnim,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔥', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
            Text(
              '$streak',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: cs.onPrimaryContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _GoalRing extends StatelessWidget {
  const _GoalRing({
    required this.progress,
    required this.goalReached,
    required this.todayMinutes,
    required this.dailyGoal,
    required this.pulseAnim,
    required this.colorScheme,
    required this.textTheme,
  });

  final double progress;
  final bool goalReached;
  final int todayMinutes;
  final int dailyGoal;
  final Animation<double> pulseAnim;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final ringColor = goalReached ? colorScheme.primary : colorScheme.secondary;
    return ScaleTransition(
      scale: pulseAnim,
      child: SizedBox(
        width: 220,
        height: 220,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox.expand(
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 14,
                backgroundColor: colorScheme.surfaceContainerHighest,
                valueColor: AlwaysStoppedAnimation<Color>(ringColor),
                strokeCap: StrokeCap.round,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '$todayMinutes',
                  style: textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    color: colorScheme.onSurface,
                    height: 1,
                  ),
                ),
                Text(
                  'min today',
                  style: textTheme.titleSmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Goal: $dailyGoal min',
                  style: textTheme.bodySmall?.copyWith(
                    color: colorScheme.outline,
                  ),
                ),
                if (goalReached)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '✓ Goal reached!',
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _LoggedDisplay extends StatelessWidget {
  const _LoggedDisplay({
    required this.minutes,
    required this.onEdit,
    required this.colorScheme,
    required this.textTheme,
  });

  final int minutes;
  final VoidCallback onEdit;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('📖', style: TextStyle(fontSize: 20)),
              const SizedBox(width: 10),
              Text(
                "You've logged $minutes min today.",
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.onPrimaryContainer,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        TextButton.icon(
          onPressed: onEdit,
          icon: Icon(Icons.edit_outlined, size: 18, color: colorScheme.primary),
          label: Text('Edit', style: TextStyle(color: colorScheme.primary)),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _InputSection extends StatelessWidget {
  const _InputSection({
    required this.controller,
    required this.onLog,
    required this.colorScheme,
  });

  final TextEditingController controller;
  final VoidCallback onLog;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
          decoration: InputDecoration(
            hintText: 'Enter minutes read',
            hintStyle: TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 16,
            ),
            filled: true,
            fillColor: colorScheme.surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            suffixText: 'min',
          ),
          onSubmitted: (_) => onLog(),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          height: 54,
          child: FilledButton.icon(
            onPressed: onLog,
            icon: const Icon(Icons.check_rounded),
            label: const Text(
              'Log Reading',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _WeeklyMiniPreview extends StatelessWidget {
  const _WeeklyMiniPreview({
    required this.preview,
    required this.colorScheme,
    required this.textTheme,
  });

  final List<int> preview;
  final ColorScheme colorScheme;
  final TextTheme textTheme;

  static const _days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];

  @override
  Widget build(BuildContext context) {
    final maxVal = preview.isEmpty
        ? 1
        : preview.reduce((a, b) => a > b ? a : b);
    final todayIndex = 6; // last entry is today

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'This Week',
          style: textTheme.labelLarge?.copyWith(
            color: colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(preview.length, (i) {
            final minutes = preview[i];
            final frac = maxVal > 0 ? minutes / maxVal : 0.0;
            final isToday = i == todayIndex;
            final barColor = isToday
                ? colorScheme.primary
                : minutes > 0
                ? colorScheme.secondary
                : colorScheme.surfaceContainerHighest;

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                      height: (frac * 60).clamp(4.0, 60.0),
                      decoration: BoxDecoration(
                        color: barColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _days[i],
                      style: textTheme.labelSmall?.copyWith(
                        color: isToday
                            ? colorScheme.primary
                            : colorScheme.onSurfaceVariant,
                        fontWeight: isToday
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
