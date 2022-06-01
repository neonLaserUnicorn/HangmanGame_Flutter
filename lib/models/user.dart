import 'package:hive_flutter/hive_flutter.dart';

part 'user.g.dart';
  
@HiveType(typeId: 0)
class User
{
  @HiveField(0, defaultValue: 'Guest')
  String name = 'Guest';

  @HiveField(1)
  int? scores;
  
  User(this.name, this.scores);
}