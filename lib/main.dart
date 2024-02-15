import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:habit_tracker/domain/database/habit_database.dart';
import 'package:habit_tracker/presentation/pages/splash_screen.dart';
import 'package:habit_tracker/utils/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initializate();
  await HabitDatabase().saveFirstLaunchDate();
  final prefs = await SharedPreferences.getInstance();
  final firstLaunch = prefs.getBool('firstLaunch') ?? true;

  runApp(
    MultiProvider(
      providers: [
        //Habit Provider
        ChangeNotifierProvider(create: (context) => HabitDatabase()),

        //Theme Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      child: DevicePreview(
        enabled: false,
        builder: (context) =>
            MainApp(firstLaunch: firstLaunch), // Wrap your app
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool firstLaunch;
  const MainApp({
    super.key,
    required this.firstLaunch,
  });

  @override
  Widget build(BuildContext context) {
    Provider.of<ThemeProvider>(context).loadTheme();
    return MaterialApp(
      home: SplashScreen(firstLaunch: firstLaunch),
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
