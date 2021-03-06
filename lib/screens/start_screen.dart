
import 'package:flutter/material.dart';
import 'package:hangman/models/screen_model.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Text('HANGMAN', style: Theme.of(context).textTheme.bodyLarge),
          Expanded(
            child: Image.asset('images/gallow.png',fit: BoxFit.fitWidth )),
          const SizedBox(height: 10),
          StartButton(),
          const  HighScoreButton(),
        ],
      )
    );
  }
}

class MenuButton extends StatelessWidget {
  const MenuButton({ Key? key,
                    required this.onPress,
                    required this.text }) : super(key: key);

  final Function() onPress;
  final String  text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color?>(Colors.blue),
          minimumSize: MaterialStateProperty.all<Size>(const Size(150, 50)),
          maximumSize: MaterialStateProperty.all<Size>(const Size(300, 50))
        ), 
        child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
class StartButton extends StatelessWidget {
  StartButton({ Key? key }) : super(key: key);

  final model = GameWords();
  @override
  Widget build(BuildContext context) {
    return MenuButton(
      onPress: ()=>Navigator.of(context).pushNamed('/game'),
      text: 'START');
  }
}
class HighScoreButton extends StatelessWidget {
  const HighScoreButton ({Key? key }) : super(key: key);

  void highScore(BuildContext context)
  {
  }
  @override
  Widget build(BuildContext context) {
    return MenuButton(
      onPress:()=> Navigator.of(context).pushNamed('/high_scores'),
      text: 'HIGH SCORE'
      );
  }
}

