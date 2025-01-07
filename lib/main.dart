import 'package:flutter/material.dart';
import 'package:notes/notepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async { 
  //supabase setup
  await Supabase.initialize(
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImNraWRzenNzdmJ1b2hvd3F3YnR0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzQ5MzE5NzEsImV4cCI6MjA1MDUwNzk3MX0.0xnKViNCaKFxMElAPkirMHuaHaYSTCRt_ACLtGK88hc",
    url:"https://ckidszssvbuohowqwbtt.supabase.co" ,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const NotePage(),
    );
  }
}

