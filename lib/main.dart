import 'package:flutter/material.dart';
import 'package:hangman/screens/game_screen.dart';
import 'package:hangman/screens/start_screen.dart';
import 'package:hangman/screens/high_scores_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hangman/models/user.dart';

void main() async
 {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
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
        '/high_scores': (context){ 
          return  const LeaderboardWidget();
        },
      },
      initialRoute: '/',
      );
  }
}



