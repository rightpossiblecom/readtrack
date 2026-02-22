import 'package:flutter/material.dart';
import 'package:readtrack/core/constants/app_constants.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: cs.surface,
      appBar: AppBar(
        backgroundColor: cs.surface,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Text('About', style: tt.titleLarge),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // App logo + name
            Center(
              child: Column(
                children: [
                  Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      color: cs.primaryContainer,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: Text('📖', style: const TextStyle(fontSize: 44)),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'ReadTrack',
                    style: tt.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Version ${AppConstants.appVersion}',
                    style: tt.bodySmall?.copyWith(color: cs.outline),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Description
            _Section(
              title: 'About the App',
              cs: cs,
              tt: tt,
              child: Text(
                'ReadTrack is a simple daily reading time tracker. '
                'Log how many minutes you read each day, build a streak, '
                'and stay consistent — no accounts, no cloud, no noise.',
                style: tt.bodyMedium?.copyWith(height: 1.6),
              ),
            ),

            const SizedBox(height: 24),

            _Section(
              title: 'How it works',
              cs: cs,
              tt: tt,
              child: Column(
                children: [
                  _InfoRow(
                    icon: '✏️',
                    text: 'Enter how many minutes you read each day.',
                    tt: tt,
                    cs: cs,
                  ),
                  _InfoRow(
                    icon: '🔥',
                    text:
                        'Your streak grows every day you log at least 1 minute.',
                    tt: tt,
                    cs: cs,
                  ),
                  _InfoRow(
                    icon: '🎯',
                    text: 'Set a daily reading goal to stay motivated.',
                    tt: tt,
                    cs: cs,
                  ),
                  _InfoRow(
                    icon: '📊',
                    text: 'Review your weekly progress at a glance.',
                    tt: tt,
                    cs: cs,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            _Section(
              title: 'Privacy',
              cs: cs,
              tt: tt,
              child: Text(
                'ReadTrack stores all data locally on your device. '
                'We do not collect, share, or transmit any personal information.',
                style: tt.bodyMedium?.copyWith(height: 1.6),
              ),
            ),

            const SizedBox(height: 24),

            _Section(
              title: 'Developer',
              cs: cs,
              tt: tt,
              child: Text(
                'Built with ❤️ using Flutter.\n'
                'Designed to be simple, focused, and distraction-free.',
                style: tt.bodyMedium?.copyWith(height: 1.6),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({
    required this.title,
    required this.child,
    required this.cs,
    required this.tt,
  });
  final String title;
  final Widget child;
  final ColorScheme cs;
  final TextTheme tt;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: tt.labelLarge?.copyWith(
            color: cs.primary,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cs.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({
    required this.icon,
    required this.text,
    required this.tt,
    required this.cs,
  });
  final String icon;
  final String text;
  final TextTheme tt;
  final ColorScheme cs;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(icon, style: const TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: tt.bodyMedium?.copyWith(height: 1.5)),
        ),
      ],
    ),
  );
}
