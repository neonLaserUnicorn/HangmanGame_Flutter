import 'package:flutter/material.dart';
import 'package:hangman/models/game_model.dart';


class AlphaButton extends StatefulWidget {
  AlphaButton({ 
    Key? key,
    required this.value, required this.isTap}) : super(key: key);
  final String value;
  bool isTap; 
  @override
  State<AlphaButton> createState() => _AlphaButtonState();
}

class _AlphaButtonState extends State<AlphaButton> {
  
  bool isTap = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mod = GameModelProvider.watch(context);
    mod?.addListener(() {
      if(mod.isNew)
      {
        isTap = !mod.lose;
        setState(() {});
        return;
      }
      if(mod.h == widget.value.toLowerCase())
      {
        isTap = false;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double elev = 2.0;
    var color = MaterialStateProperty.all<Color?>(const Color.fromARGB(248, 56, 8, 78));
    if(!isTap)
    {
      elev = 0.0;
      color = MaterialStateProperty.all<Color?>(const Color.fromARGB(206, 78, 65, 97));
    }
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: (){
          if(isTap)
          {
            GameModelProvider.read(context)?.check(widget.value);
            // isTap = false;
            // setState(() {});
          }
        },
        style: ButtonStyle(
            elevation: MaterialStateProperty.all<double?>(elev),
            splashFactory: NoSplash.splashFactory,
            backgroundColor: color,
            minimumSize: MaterialStateProperty.all<Size>(const Size(20, 20)),
            maximumSize: MaterialStateProperty.all<Size>(const Size(40, 40)),
          ),
        
        child: Text(widget.value, style: Theme.of(context).textTheme.bodySmall,), ),
    );
  }
}



class HangKeyboardWidget extends StatefulWidget {
  const HangKeyboardWidget({ Key? key,}) : super(key: key);
  
  @override
  State<HangKeyboardWidget> createState() => _HangKeyboardWidgetState();
}

class _HangKeyboardWidgetState extends State<HangKeyboardWidget> {
  String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  bool status = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final mod = GameModelProvider.watch(context);
    mod?.addListener(() {
      if(mod.isNew)
      {
        status = !mod.lose;
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 7,
      shrinkWrap: true,
      children: List<AlphaButton>.generate(
        alphabet.length, (index) => AlphaButton(key: Key(alphabet[index]),value: alphabet[index], isTap: status)),
      );
  }
}