import 'dart:math';
import 'package:flutter/services.dart';


class GameWords
{
  List<String> _words=[];
  String pickRandom()
  {
    return _words[Random().nextInt(_words.length)];
  }
  bool isEmpty() => _words.isEmpty;
  Future writeList() async
  {
    String file = await rootBundle.loadString('resources/hangman_words.txt');
    _words = file.split('\n');
  } 
}
