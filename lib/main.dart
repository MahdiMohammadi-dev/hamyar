import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hamyar/view/splashScreen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //TODO:Set the url and key on a variable and passed it onto Supabase
  await Supabase.initialize(
      url: 'https://sauzexiguejrtjahrkda.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNhdXpleGlndWVqcnRqYWhya2RhIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTI0NzY2MjEsImV4cCI6MjAwODA1MjYyMX0.Lrgeo3xpUhuCSDVkd_c228Wl5dXtTt5x1XXacGYb6Fk');

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale("fa", "IR"),
        ],
        locale: Locale("fa", "IR"),
        debugShowCheckedModeBanner: false,
        home: SplashScreen());
  }
}
