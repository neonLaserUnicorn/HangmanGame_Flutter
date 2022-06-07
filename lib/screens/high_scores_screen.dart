import 'package:flutter/material.dart';
import 'package:hangman/screens/start_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../models/user.dart';

class LeaderboardWidget extends StatelessWidget {
  const LeaderboardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          const SizedBox(height: 8.0,),
          Text('HIGH SCORES', style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 8.0,),
          const SizedBox(height: 16.0),
          const LeadersTable(),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MenuButton(
                  onPress: ()=> Navigator.of(context).pop(),
                  text: 'Back')
                ],
            ),
          ),
          const SizedBox(height: 8.0),
        ]
         ,
      ),
    );
  }
}

class LeadersTable extends StatefulWidget {
  const LeadersTable({Key? key}) : super(key: key);

  @override
  State<LeadersTable> createState() => _LeadersTableState();
}

class _LeadersTableState extends State<LeadersTable> {
  List<User> scores = [];
  @override
  void initState()
  {
    super.initState();
    final leaderboard = Hive.openBox<User>('leaderboard');
    leaderboard.then((value) 
    {
      scores = List.from(value.toMap().values);
      value.close();
      setState((){});
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children:  List.generate(scores.length, (index) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(child: Text('${scores[index]}', style: Theme.of(context).textTheme.bodyMedium , )),
    )),
    );
  }
}