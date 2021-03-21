import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mcr/screens/food_selector.dart';


class AddButton extends StatefulWidget {
  final ValueListenable<dynamic> choosenDb;
  final selectedDb;
  AddButton({Key key, this.selectedDb, this.choosenDb}) : super(key: key);
  
@override
  _AddButtonState createState() => _AddButtonState();
}
class _AddButtonState extends State<AddButton>{
  


  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:(){
          print("selectedDbProvider2.value ${widget.selectedDb}");         
          Navigator.push(context, MaterialPageRoute(builder: (context) => FoodSelector(choosenDb: widget.selectedDb,),),);},
            child: Icon(
              Icons.add,
              color: Theme.of(context).accentColor,
              size: 24.0,
              semanticLabel: 'Text to announce in accessibility modes',
                
            ),
      );
      
    
  }
}