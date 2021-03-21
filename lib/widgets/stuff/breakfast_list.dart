import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcr/app.dart';
import 'package:mcr/bloc/bloc_meals.dart';
import 'package:mcr/db/breakfast_db_provider.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/models/breakfast_model.dart';
import 'package:mcr/widgets/add_button.dart';
import 'package:provider/provider.dart';

class BreakfastList extends StatefulWidget {
  final BreakfastModel breakfastMeal;

  const BreakfastList({Key key, this.breakfastMeal}) : super(key: key);
  @override
  _BreakfastListState createState() => _BreakfastListState();
}

class _BreakfastListState extends State<BreakfastList> {
  BreakfastDatabase db = BreakfastDatabase();
  final bloc = MealsBloc();
  
  _deleteProduct(int id)async{
    await db.deleteMeal(id);
    
  }

  _updateProduct(int id){
    var alert = AlertDialog(

      title: Text("Delete?",style: GoogleFonts.lato(color:Color(0xff668CD9),fontSize: 14,fontWeight: FontWeight.w300,),),
      actions: <Widget>[
        FlatButton(onPressed:(){Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()));_deleteProduct(id);Navigator.of(context, rootNavigator: true).pop();} , child: Text("Yes")),
        FlatButton(onPressed: () {Navigator.of(context, rootNavigator: true).pop();} ,
         child: Text("No")),
      ],
    );
    showDialog(context: context,
    builder:(_){
      return alert;
    }
    );
  }

  _emptySpace(){ 
    return Consumer<DaySelectorModel>(
      builder: (context, dateSe, child){
        
        bloc.addMealsToStream('%${dateSe.daySelected.day}-0${dateSe.daySelected.month}-${dateSe.daySelected.year}%');
      return StreamBuilder(
        stream: bloc.breakfastList,
        builder: (context, AsyncSnapshot<List<BreakfastModel>>snapshot) {
          double totalBreakfastCalories = 0;

          if(!snapshot.hasData || snapshot.data.length == 0){
            return Column(
              children: <Widget>[
                Container(
                  color: Theme.of(context).cardColor,
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      child: Container(
                        height: 55.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Breakfast', style:Theme.of(context).textTheme.headline2),
                              AddButton(selectedDb :"breakfast"),
                            ],
                          ),
                        )
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          else{
          for(int i = 0;i < snapshot.data.length; i++) {
            totalBreakfastCalories+=snapshot.data[i].breakfastCalories;
          }
            return  Column(
              children: <Widget>[
                Container(
                  color: Theme.of(context).cardColor,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SizedBox(
                      child: Container(
                        height: 50.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text('Breakfast', style:Theme.of(context).textTheme.headline2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal:10),
                                    child: Text("Kcal: ${totalBreakfastCalories.toInt()}",style:Theme.of(context).textTheme.bodyText2),
                                  ), 
                                  AddButton(selectedDb :"breakfast"),
                                ],
                              ),
                            ],
                          ),
                        )
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).primaryColor,  
                  child: ListView.builder(  
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder:(BuildContext buildContext, index){   
                      totalBreakfastCalories=snapshot.data[index].breakfastCalories+totalBreakfastCalories;
                      String brandd;
                      (snapshot.data[index].brand == null) ? brandd = "" :brandd =  " (${snapshot.data[index].brand})";
                      return Column(
                        children: <Widget>[
                          InkWell(
                            onLongPress: () => _updateProduct(snapshot.data[index].id),
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 4),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8.0, vertical: 4),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: RichText(
                                          text: TextSpan(
                                            style: Theme.of(context).textTheme.headline4,
                                            children:<TextSpan>[
                                              TextSpan(text:"${snapshot.data[index].breakfastProductName}" ),
                                              TextSpan(text:"$brandd" ,style: Theme.of(context).textTheme.headline6)
                                            ]
                                          ) , )
                                        ),
                                      
                                    ),
                                     Container(
                                      height: 11.0,
                                      child:Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: <Widget>[        
                                          Text("Price: ${snapshot.data[index].breakfastPrices}", style:Theme.of(context).textTheme.headline6),
                                          Text('Fat: ${snapshot.data[index].breakfastFat}', style:Theme.of(context).textTheme.headline6),
                                          Text('Carbs: ${snapshot.data[index].breakfastCarbs}',style:Theme.of(context).textTheme.headline6),
                                          Text('Protein: ${snapshot.data[index].breakfastProtein}', style:Theme.of(context).textTheme.headline6),
                                          Text('Kcal: ${snapshot.data[index].breakfastCalories}', style:Theme.of(context).textTheme.headline6),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              
                           
                            ),
                          ),
                                
                          Divider(
                            indent: 30,
                            endIndent:30,
                            thickness: 1,
                            height: 5,
                          ),
                        ],
                      );
                    } 
                  ),
                ),    
              ],
            );            
          }
        }   
      );
      }
    );         
  }
    

  

  @override
  Widget build(BuildContext context) {
    return _emptySpace();}
  
}