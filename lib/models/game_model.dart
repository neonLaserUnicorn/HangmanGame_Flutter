
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hangman/models/screen_model.dart';
import 'package:hangman/models/user.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:hive/hive.dart';

class GameModel extends ChangeNotifier
{
  String? answer;
  String question = "";
  bool _res = true;
  bool _isNew = true;
  bool _isLose = false;
  String? h;
  get lose => _isLose;
  get isNew => _isNew;
  get res => _res;
  late GameWords words;
  int lives = 2;
  int scores = 0;
  final BuildContext _context;
  final hangman = HangmanModel();
  final String loser = 'You lose:(';


  GameModel(this._context)
  {
    words = GameWords();
    reset();
  }

  Future gameOver() async
  {
    final leaderboard = await Hive.openBox('leaderboard');
    final user = User('Guest', scores);
    await leaderboard.add(user);
    print(leaderboard.toMap());
    leaderboard.close();
    return Future.delayed(const Duration(seconds: 1), 
      ()=>Navigator.of(_context).pushReplacementNamed('/'));
  }
  void reset() async
  {
    if(!_isLose)
    {
      if(isWin())
      {
        ++scores;
      }
      hangman.reset();
      if(words.isEmpty())
      {
        await words.writeList();
      }    
      answer = words.pickRandom();
      question = '';
      int end = answer!.length;
      for (int i = 0; i < end; ++i)
      {
        question+='_';
      }
      print(answer);
      _isNew = true;
      notifyListeners();
      return;
    }
    question = loser;
    // int end = loser.length;
    // for (int i = 0; i < end; ++i)
    //   {
    //     question.add(loser[i]);
    //   }
    _isNew = true;
    notifyListeners();
  }

  void check(String let)
  {
    _isNew = false;
    let = let.toLowerCase();
    _res = false;
    h=let;
    String tmp = '';
    for (int i = 0; i < answer!.length; ++i)
    {
      if(answer![i] == let)
      {
        _res = true;
        tmp+=let;
        continue;
      }
      tmp+=question[i];

    }
    question = tmp;
    if(!_res)
    {
      mistake();
    }

    notifyListeners();
  }

  void hint()
  {
    int i;
    do{
      i = Random().nextInt(question.length-1);
    }while(question[i]!='_');
    h = answer![i];
    check(answer![i]);
  }

  bool isWin() => !question.contains('_') && question != loser;

  void mistake()  async
  {
    hangman.eshaf();
    if(hangman.morte==6)
    {
      lives--;
      _isLose = true;
      // notifyListeners();
      if(lives==0)
      {
        reset();
        await gameOver();
        return;
      }
      reset();
      await Future.delayed(const Duration(seconds: 1), (){});
      _isLose = false;
      reset();
      return;
    }
  }
}


class GameModelProvider extends InheritedNotifier
{
  const GameModelProvider({Key? key, required Widget child, required this.model}) : super(key: key, child: child);
  final GameModel model;

  static GameModel? read(BuildContext context)
  {
    final widget = context.getElementForInheritedWidgetOfExactType<GameModelProvider>()?.widget;
    return widget is GameModelProvider ? widget.model : null;
  }

  static GameModel? watch(BuildContext context)
  {
    return context.
      dependOnInheritedWidgetOfExactType<GameModelProvider>()?.model;
  }
}

class HangmanModel
{
  final List<Image> johny =[
    Image.asset('images/0.png', fit:BoxFit.fitWidth,),
    Image.asset('images/1.png', fit:BoxFit.fitWidth),
    Image.asset('images/2.png', fit:BoxFit.fitWidth),
    Image.asset('images/3.png', fit:BoxFit.fitWidth),
    Image.asset('images/4.png', fit:BoxFit.fitWidth),
    Image.asset('images/5.png', fit:BoxFit.fitWidth),
    Image.asset('images/6.png', fit:BoxFit.fitWidth),
  ];
  int _morte = 0;
  void reset()=>_morte = 0;
  get morte => _morte;
  void eshaf()
  {
    _morte++;
  }
  Image loser()=>johny[_morte];
}