import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:readtrack/core/constants/app_constants.dart';
import 'package:readtrack/core/services/storage_service.dart';
import 'package:readtrack/core/theme/app_theme.dart';
import 'package:readtrack/features/home/home_screen.dart';
import 'package:readtrack/features/home/home_view_model.dart';
import 'package:readtrack/features/settings/settings_screen.dart';
import 'package:readtrack/features/settings/settings_view_model.dart';
import 'package:readtrack/features/weekly/weekly_screen.dart';
import 'package:readtrack/features/weekly/weekly_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Prevent google_fonts from fetching fonts at runtime —
  // fonts are bundled via the package assets.
  GoogleFonts.config.allowRuntimeFetching = false;

  await Hive.initFlutter();
  await Hive.openBox<String>(AppConstants.dataBox);
  await Hive.openBox<String>(AppConstants.settingsBox);

  final storage = StorageService();

  runApp(
    MultiProvider(
      providers: [
        Provider<StorageService>.value(value: storage),
        ChangeNotifierProvider(create: (_) => SettingsViewModel(storage)),
        ChangeNotifierProvider(create: (_) => HomeViewModel(storage)),
        ChangeNotifierProvider(create: (_) => WeeklyViewModel(storage)),
      ],
      child: const ReadTrackApp(),
    ),
  );
}

class ReadTrackApp extends StatelessWidget {
  const ReadTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsViewModel>(
      builder: (context, settings, _) {
        return MaterialApp(
          title: 'ReadTrack',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: settings.themeMode,
          home: const _AppShell(),
        );
      },
    );
  }
}

class _AppShell extends StatefulWidget {
  const _AppShell();

  @override
  State<_AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<_AppShell> {
  int _currentIndex = 0;

  static const _pages = [HomeScreen(), WeeklyScreen(), SettingsScreen()];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) {
          setState(() => _currentIndex = i);
          // Refresh data when switching to Weekly tab
          if (i == 1) {
            context.read<WeeklyViewModel>().load();
          }
        },
        backgroundColor: cs.surface,
        indicatorColor: cs.primaryContainer,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined),
            selectedIcon: Icon(Icons.bar_chart_rounded),
            label: 'Weekly',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings_rounded),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
