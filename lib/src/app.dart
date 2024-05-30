import 'package:flutter/material.dart';
import 'package:moodpick/src/modules/authentication/landing.dart';
import 'package:moodpick/src/modules/home/home.dart';
import 'package:moodpick/src/providers/state.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(), // Provide the state object
      child: MaterialApp(
        home: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: "/landing",
          routes: {
            "/home": (context) => const HomeScreen(),
            "/landing": (context) => const LandingScreen(),
          },
        ),
      ),
    );
  }
}
