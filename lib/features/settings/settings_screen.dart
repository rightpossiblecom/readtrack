import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readtrack/core/constants/app_constants.dart';
import 'package:readtrack/features/home/home_view_model.dart';
import 'package:readtrack/features/settings/settings_view_model.dart';
import 'package:readtrack/features/about/about_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Consumer<SettingsViewModel>(
      builder: (context, vm, _) {
        return Scaffold(
          backgroundColor: cs.surface,
          appBar: AppBar(
            backgroundColor: cs.surface,
            elevation: 0,
            scrolledUnderElevation: 0,
            title: Text('Settings', style: tt.titleLarge),
          ),
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              children: [
                // ─── Reading Goal ──────────────────────────────────────────
                _SectionHeader(label: 'Reading Goal', textTheme: tt),
                _Card(
                  colorScheme: cs,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Daily goal', style: tt.bodyLarge),
                          Text(
                            '${vm.dailyGoal} min',
                            style: tt.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: cs.primary,
                            ),
                          ),
                        ],
                      ),
                      Slider(
                        value: vm.dailyGoal.toDouble(),
                        min: 5,
                        max: 120,
                        divisions: 23,
                        label: '${vm.dailyGoal} min',
                        activeColor: cs.primary,
                        onChanged: (val) {
                          vm.setDailyGoal(val.round());
                          context.read<HomeViewModel>().updateDailyGoal(
                            val.round(),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                // ─── Appearance ────────────────────────────────────────────
                _SectionHeader(label: 'Appearance', textTheme: tt),
                _Card(
                  colorScheme: cs,
                  child: Column(
                    children: [
                      _ThemeOption(
                        label: 'System Default',
                        mode: ThemeMode.system,
                        current: vm.themeMode,
                        onTap: () => vm.setThemeMode(ThemeMode.system),
                        cs: cs,
                        tt: tt,
                      ),
                      Divider(height: 1, color: cs.outlineVariant),
                      _ThemeOption(
                        label: 'Light',
                        mode: ThemeMode.light,
                        current: vm.themeMode,
                        onTap: () => vm.setThemeMode(ThemeMode.light),
                        cs: cs,
                        tt: tt,
                      ),
                      Divider(height: 1, color: cs.outlineVariant),
                      _ThemeOption(
                        label: 'Dark',
                        mode: ThemeMode.dark,
                        current: vm.themeMode,
                        onTap: () => vm.setThemeMode(ThemeMode.dark),
                        cs: cs,
                        tt: tt,
                      ),
                    ],
                  ),
                ),

                // ─── Data ──────────────────────────────────────────────────
                _SectionHeader(label: 'Data', textTheme: tt),
                _Card(
                  colorScheme: cs,
                  child: _ActionTile(
                    label: 'Clear App Data',
                    icon: Icons.delete_outline_rounded,
                    color: cs.error,
                    onTap: () => _confirmClear(context, vm),
                    tt: tt,
                  ),
                ),

                // ─── Legal ─────────────────────────────────────────────────
                _SectionHeader(label: 'Legal', textTheme: tt),
                _Card(
                  colorScheme: cs,
                  child: Column(
                    children: [
                      _ActionTile(
                        label: 'Privacy Policy',
                        icon: Icons.privacy_tip_outlined,
                        color: cs.onSurface,
                        onTap: () => _launch(AppConstants.privacyPolicyUrl),
                        tt: tt,
                        trailing: const Icon(Icons.open_in_new, size: 16),
                      ),
                      Divider(height: 1, color: cs.outlineVariant),
                      _ActionTile(
                        label: 'Terms of Service',
                        icon: Icons.description_outlined,
                        color: cs.onSurface,
                        onTap: () => _launch(AppConstants.termsOfServiceUrl),
                        tt: tt,
                        trailing: const Icon(Icons.open_in_new, size: 16),
                      ),
                    ],
                  ),
                ),

                // ─── About ─────────────────────────────────────────────────
                _SectionHeader(label: 'About', textTheme: tt),
                _Card(
                  colorScheme: cs,
                  child: Column(
                    children: [
                      _ActionTile(
                        label: 'About ReadTrack',
                        icon: Icons.info_outline_rounded,
                        color: cs.onSurface,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AboutScreen(),
                          ),
                        ),
                        tt: tt,
                      ),
                      Divider(height: 1, color: cs.outlineVariant),
                      _ActionTile(
                        label: 'Rate the App',
                        icon: Icons.star_outline_rounded,
                        color: cs.onSurface,
                        onTap: () {
                          // Link to Play Store listing once published
                        },
                        tt: tt,
                      ),
                      Divider(height: 1, color: cs.outlineVariant),
                      ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(Icons.tag, color: cs.outline, size: 20),
                        title: Text('Version', style: tt.bodyMedium),
                        trailing: Text(
                          AppConstants.appVersion,
                          style: tt.bodyMedium?.copyWith(color: cs.outline),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _confirmClear(BuildContext context, SettingsViewModel vm) async {
    final homeVm = context.read<HomeViewModel>();
    final messenger = ScaffoldMessenger.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear All Data?'),
        content: const Text(
          'This will permanently delete all your reading logs. Your settings will be kept.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await vm.clearAll();
      homeVm.refresh();
      messenger.showSnackBar(
        const SnackBar(content: Text('All reading data cleared.')),
      );
    }
  }

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.label, required this.textTheme});
  final String label;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 20, bottom: 8),
    child: Text(
      label.toUpperCase(),
      style: textTheme.labelSmall?.copyWith(
        color: Theme.of(context).colorScheme.outline,
        letterSpacing: 1.2,
      ),
    ),
  );
}

class _Card extends StatelessWidget {
  const _Card({required this.child, required this.colorScheme});
  final Widget child;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    decoration: BoxDecoration(
      color: colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(16),
    ),
    child: child,
  );
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.label,
    required this.icon,
    required this.color,
    required this.onTap,
    required this.tt,
    this.trailing,
  });
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final TextTheme tt;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => ListTile(
    dense: true,
    contentPadding: EdgeInsets.zero,
    leading: Icon(icon, color: color, size: 20),
    title: Text(label, style: tt.bodyMedium?.copyWith(color: color)),
    trailing: trailing ?? const Icon(Icons.chevron_right, size: 18),
    onTap: onTap,
  );
}

class _ThemeOption extends StatelessWidget {
  const _ThemeOption({
    required this.label,
    required this.mode,
    required this.current,
    required this.onTap,
    required this.cs,
    required this.tt,
  });
  final String label;
  final ThemeMode mode;
  final ThemeMode current;
  final VoidCallback onTap;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    final selected = mode == current;
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      title: Text(
        label,
        style: tt.bodyMedium?.copyWith(
          color: selected ? cs.primary : cs.onSurface,
          fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
      trailing: selected
          ? Icon(Icons.check_rounded, color: cs.primary, size: 20)
          : null,
      onTap: onTap,
    );
  }
}
