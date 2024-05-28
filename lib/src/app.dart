import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moodpick/src/modules/authentication/landing.dart';
import 'package:moodpick/src/modules/home/home.dart';
import 'package:moodpick/src/modules/home/widgets/app_bar.dart';
import 'package:moodpick/src/modules/home/widgets/fab.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    if (!isAuthenticated) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: LandingScreen(),
        ),
      );
    }

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              preferredSize: Size.fromHeight(100.0),
              child: SafeArea(
                  minimum: EdgeInsets.fromLTRB(15, 40, 15, 0),
                  child: AppBarWidget())),
          body: HomeScreen(),
          floatingActionButton: FloatingActionButtonWidget()),
    );
  }
}
