import 'package:flutter/material.dart';
import 'package:hangman/utilities/h_keyboard.dart';
import 'package:hangman/models/game_model.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) { 
    // quest = words.pickRandom();
    final model = GameModel(context);
    return GameModelProvider(
      model: model,
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: const Size.fromHeight(40),
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [Color.fromARGB(156, 124, 54, 221),Color.fromRGBO(100, 30, 200, 100)])
        //     ),
        //   ),
        // ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children:[
              const SizedBox(height: 6.0,),
              Row(
                children: const[
                   LivesWidget(),
                   ScoresWidget(),
                   HintWidget(),
                ]),
              const Expanded(child:Hangman()),
              const WordWidget(),
              const HangKeyboardWidget(),
            ]
          ),
        ),
      ),
    );
  }
}



class WordWidget extends StatefulWidget {
  const WordWidget({ Key? key}) : super(key: key);

  @override
  State<WordWidget> createState() => _WordWidgetState();
}

class _WordWidgetState extends State<WordWidget> {

  List<String> _val = [];
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    final model = GameModelProvider.watch(context);
    model?.addListener(() { 
      if(model.isWin() && !model.lose)
      {
        model.reset();
      }
      _val = model.question;
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    final model = GameModelProvider.watch(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(model?.question.length ?? 0, ((index) => 
      Padding(
          padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
          child: Text(
            _val[index],
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        )))
    );
  }
}


class Hangman extends StatefulWidget {
  const Hangman({ Key? key}) : super(key: key);
  @override
  State<Hangman> createState() => _HangmanState();
}

class _HangmanState extends State<Hangman> {
  late GameModel? mod;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    mod = GameModelProvider.watch(context);
    mod?.addListener(() { 
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return mod!.hangman.loser();
  }
}

class LivesWidget extends StatefulWidget {
  const LivesWidget({ Key? key }) : super(key: key);

  @override
  State<LivesWidget> createState() => _LivesWidgetState();
}

class _LivesWidgetState extends State<LivesWidget> {

  String? text;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final  mod = GameModelProvider.watch(context);
    mod?.addListener(() {
      text = mod.lives.toString(); 
      setState((){});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Icon(Icons.favorite, color: Colors.white, size: 40,),
            Text('$text',style: const TextStyle(
              fontFamily: 'PatrickHand',
              fontSize: 24,
              color: Color.fromRGBO(100, 30, 200, 100),
              )
            ),
          ],
        ),
      ),
    );
  }
}

class HintWidget extends StatefulWidget {
  const HintWidget({ Key? key }) : super(key: key);

  @override
  State<HintWidget> createState() => _HintWidgetState();
}

class _HintWidgetState extends State<HintWidget> {
  bool isTap = false;
  Color? color = Colors.white;

  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   final mod=GameModelProvider.watch(context);
  //   mod?.addListener(() {
  //     if(mod.isNew)
  //     {
  //       isTap = !mod.lose;
  //       setState(() {});
  //     }
  //    });
  // }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: GestureDetector(
          child: Icon(Icons.question_mark, size: 40, color: color),
          onTap: (){
            if(!isTap)
            {
              isTap = true;
              color = Colors.black;
              GameModelProvider.read(context)?.hint();
              setState(() {});
            }
          },
        ),
      ),
    );
  }
}

class ScoresWidget extends StatefulWidget {
  const ScoresWidget({ Key? key }) : super(key: key);

  @override
  State<ScoresWidget> createState() => _ScoresWidgetState();
}

class _ScoresWidgetState extends State<ScoresWidget> {

  String scores = '0';
  @override
  void didChangeDependencies()
  {
    super.didChangeDependencies();
    final model = GameModelProvider.watch(context);
    model?.addListener(() { 
      if(model.isWin())
      {
        scores = model.scores.toString();
        setState(() {});          
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          scores, style: Theme.of(context).textTheme.bodyMedium
          )
        )
      );
  }
}