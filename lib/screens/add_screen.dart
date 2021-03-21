import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcr/app.dart';
import 'package:mcr/logic/date_formatter.dart';
import 'package:mcr/db/product_db_provider.dart';
import 'package:mcr/models/product_model.dart';
import 'package:mcr/screens/food_selector.dart';

class AddScreen extends StatefulWidget {
  final choosenDb;
  final bool goBackToFirstScreen;
  const AddScreen({Key key, this.choosenDb, this.goBackToFirstScreen})
      : super(key: key);
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final TextEditingController _nameTextEditingController =
      TextEditingController();
  final TextEditingController _brandTextEditingController =
      TextEditingController();
  final TextEditingController _priceTextEditingController =
      TextEditingController();
  final TextEditingController _sizeTextEditingController =
      TextEditingController();
  final TextEditingController _servingSizeTextEditingController =
      TextEditingController();
  final TextEditingController _fatTextEditingController =
      TextEditingController();
  final TextEditingController _carbTextEditingController =
      TextEditingController();
  final TextEditingController _proteinTextEditingController =
      TextEditingController();
  var db = DatabaseHelper();
  final List<ProductModel> _productList = <ProductModel>[];
  String unitSelected = 'grams';
  void _handleSubmitted(name, brand, price, size, unit, fat, carbs, protein,
      lastServingSize) async {
    _nameTextEditingController.clear();
    _brandTextEditingController.clear();
    _priceTextEditingController.clear();
    _sizeTextEditingController.clear();
    _fatTextEditingController.clear();
    _carbTextEditingController.clear();
    _proteinTextEditingController.clear();

    ProductModel noDoItem = ProductModel(
        name,
        brand,
        price.toDouble(),
        size,
        unit,
        fat.toDouble(),
        carbs.toDouble(),
        protein.toDouble(),
        dateFormatted(),
        0,
        lastServingSize.toDouble(),
        lastServingSize.toDouble());
    int savedProductId = await db.saveProduct(noDoItem);

    ProductModel addedProduct = await db.getProduct(savedProductId);

    setState(() {
      _productList.insert(0, addedProduct);
      print("Item saved id:$savedProductId");
    });
  }

  _validate() {
    return (input) {
      final isDigitsOnly = double.tryParse(input);
      return isDigitsOnly == null ? 'Input needs to be digits only' : null;
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor
          /*gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.1,1],
          colors: [
            
            Color(0xff182133),
            Color(0xff111724),

          ],
        ),*/
          ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          title: Text("Add Food", style: Theme.of(context).textTheme.headline6),
          backgroundColor: Colors.transparent,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: Theme.of(context)
                  .primaryColor, //borderRadius: new BorderRadius.only(topLeft:Radius.circular(20.0),topRight:Radius.circular(20.0),),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView(
                children: <Widget>[
                  Container(
                    child: Row(
                      children: <Widget>[
                        Text("Discription: ",
                            style: Theme.of(context).textTheme.bodyText1),
                        Expanded(
                          child: TextFormField(
                              controller: _nameTextEditingController,
                              textAlign: TextAlign.end,
                              style: Theme.of(context).textTheme.bodyText1,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Brand: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        child: TextField(
                            controller: _brandTextEditingController,
                            textAlign: TextAlign.end,
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Price: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        child: TextFormField(
                            controller: _priceTextEditingController,
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: _validate(),
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Container Size: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        child: TextFormField(
                            controller: _sizeTextEditingController,
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: _validate(),
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Serving Size: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        child: TextFormField(
                            controller: _servingSizeTextEditingController,
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: _validate(),
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Unit",
                          style: Theme.of(context).textTheme.bodyText1),
                      DropdownButton<String>(
                        icon: Icon(
                          Icons.arrow_downward,
                          color: Theme.of(context).accentColor,
                        ),
                        underline: Container(
                          height: 0,
                          color: Color(0xff667AFF),
                        ),
                        elevation: 0,
                        value: unitSelected,
                        style: GoogleFonts.ubuntu(
                          color: Colors.white,
                        ),
                        dropdownColor: Theme.of(context).primaryColor,
                        onChanged: (String newValue) {
                          setState(() {
                            unitSelected = newValue;
                          });
                        },
                        items: <String>['grams', 'container', 'ml', 'kg', 'l']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Fat: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        child: TextFormField(
                            controller: _fatTextEditingController,
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: _validate(),
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Carbs: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        child: TextFormField(
                            controller: _carbTextEditingController,
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: _validate(),
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Row(
                    children: <Widget>[
                      Text("Protein: ",
                          style: Theme.of(context).textTheme.bodyText1),
                      Expanded(
                        child: TextFormField(
                            controller: _proteinTextEditingController,
                            textAlign: TextAlign.end,
                            keyboardType: TextInputType.numberWithOptions(),
                            validator: _validate(),
                            style: Theme.of(context).textTheme.bodyText1,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            )),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                            onPressed: () {
                              _handleSubmitted(
                                _nameTextEditingController.text,
                                _brandTextEditingController.text,
                                double.parse(_priceTextEditingController.text),
                                int.parse(_sizeTextEditingController.text),
                                unitSelected,
                                double.parse(_fatTextEditingController.text),
                                double.parse(_carbTextEditingController.text),
                                double.parse(
                                    _proteinTextEditingController.text),
                                int.parse(
                                    _servingSizeTextEditingController.text),
                              );
                              _nameTextEditingController.clear();
                              _brandTextEditingController.clear();
                              _priceTextEditingController.clear();
                              _sizeTextEditingController.clear();
                              _fatTextEditingController.clear();
                              _carbTextEditingController.clear();
                              _proteinTextEditingController.clear();
                              (widget.goBackToFirstScreen)
                                  ? Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyApp()))
                                  : Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => FoodSelector(
                                          choosenDb: widget.choosenDb,
                                        ),
                                      ),
                                    );
                            },
                            child: Text("Save",
                                style: GoogleFonts.lato(
                                  color: Color(0xffDAFF7D),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ))),
                        FlatButton(
                            onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => FoodSelector(
                                      choosenDb: widget.choosenDb,
                                    ),
                                  ),
                                ),
                            child: Text("Cancel",
                                style: GoogleFonts.ubuntu(
                                    color: Color(0xffdf5d57)))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
