import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

import 'src/app.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: "https://qaytoeaupdapzuyuzark.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFheXRvZWF1cGRhcHp1eXV6YXJrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTY3MjQ2NTEsImV4cCI6MjAzMjMwMDY1MX0.PHv_WsUM6J-OH6m8CsuoqhozlWZlwpU1hxJNZh3TlBk",
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
    ),
  );

  runApp(MyApp());
}
