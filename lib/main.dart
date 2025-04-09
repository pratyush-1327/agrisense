import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:agrisense/themes/my_theme.dart';
import 'package:agrisense/providers/chat_provider.dart';
import 'package:agrisense/providers/settings_provider.dart';
import 'package:agrisense/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized(); // Initialize EasyLocalization

  await dotenv.load(fileName: ".env");
  await ChatProvider.initHive();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('hi'), Locale('te'), Locale('bn'), Locale('mr'), Locale('ta'), Locale('as')], // Supported locales
      path: 'assets/translations', // Path to translation files
      fallbackLocale: const Locale('en'), // Fallback locale
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ChatProvider()),
          ChangeNotifierProvider(create: (context) => SettingsProvider()),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    setTheme();
    super.initState();
  }

  void setTheme() {
    final settingsProvider = context.read<SettingsProvider>();
    settingsProvider.getSavedSettings();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'appTitle'.tr(), // Use translated title
      localizationsDelegates: context.localizationDelegates, // Add delegates
      supportedLocales: context.supportedLocales, // Add supported locales
      locale: context.locale, // Set current locale
      theme:
          context.watch<SettingsProvider>().isDarkMode ? darkTheme : lightTheme,
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
