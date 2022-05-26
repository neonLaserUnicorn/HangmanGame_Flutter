import 'package:flutter/material.dart';
import 'package:hangman/screens/game_screen.dart';
import 'package:hangman/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color.fromRGBO(100, 30, 200, 100),
        // colorScheme: const ColorScheme.dark(
        //   secondary: Color.fromARGB(206, 67, 23, 128),
        //   primary:Color.fromRGBO(100, 30, 200, 100),
        // ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: 'PatrickHand',
            fontSize: 60,
            color: Colors.white,
            ),
          bodyMedium: TextStyle(
            fontFamily: 'PatrickHand',
            fontSize: 40,
            color: Colors.white,
            ),
          bodySmall: TextStyle(
            fontFamily: 'PatrickHand',
            fontSize: 24,
            color: Colors.white,
            )
          )
      ),
      routes: {
        '/': (context)=> const StartScreen(),
        '/game': (context)=> const GameWidget(),
      },
      initialRoute: '/',
      );
  }
}