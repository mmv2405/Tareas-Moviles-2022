import 'package:find_track_app/Music.dart';
import 'package:find_track_app/homeScreen.dart';
import 'package:find_track_app/test.dart';
import 'package:flutter/material.dart';
import 'package:find_track_app/favorites.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith( colorScheme: ColorScheme.dark().copyWith(primary: Colors.purple),),

      initialRoute: '/',
      routes: {
        '/': (context) => homeScreen(),
        '/favorites': (context) => favorites(),
        '/test': (context) => test(),
        '/music': (context) => Music(),

      },
    );
  }
}

