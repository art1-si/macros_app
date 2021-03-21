import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mcr/app.dart';
import 'package:mcr/db/breakfast_db_provider.dart';
import 'package:mcr/db/product_db_provider.dart';
import 'package:mcr/logic/day_selector_model.dart';
import 'package:mcr/models/breakfast_model.dart';
import 'package:mcr/models/product_model.dart';
import 'dart:math';
import 'package:mcr/widgets/add_button.dart';

class AddFoodToMeal extends StatefulWidget {
  final ProductModel selectedProduct;
  final choosenDb;

  AddFoodToMeal({Key key, this.choosenDb, this.selectedProduct})
      : super(key: key);

  @override
  _AddFoodToMealState createState() => _AddFoodToMealState();
}

class _AddFoodToMealState extends State<AddFoodToMeal> {
  TextEditingController textEditingController = TextEditingController();

  var controller = TextEditingController(text: "100");
  int selectedIndex;
  AddButton abutton;
  var db = BreakfastDatabase();
  var productDb = DatabaseHelper();
  final dSM = DaySelectorModel();
  double inputSize = 100;
  final List<BreakfastModel> _productList = <BreakfastModel>[];

  @override
  void initState() {
    super.initState();
    print(widget.choosenDb);
    inputSize = widget.selectedProduct.lastServingSize.toDouble();
    controller = TextEditingController(
        text: "${widget.selectedProduct.lastServingSize}");
  }

  @override
  Widget build(BuildContext context) {
    print("selectedDb: ${widget.selectedProduct.lastServingSize}");
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(widget.selectedProduct.productname,
                style: Theme.of(context).textTheme.headline6)),
        body: Column(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Text("FAT", style: Theme.of(context).textTheme.bodyText2),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          width: 10,
                          height: 1,
                        ),
                      ),
                      Text("${_calToSize(_getFat100())}",
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("CARBS",
                          style: Theme.of(context).textTheme.bodyText2),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          width: 10,
                          height: 1,
                        ),
                      ),
                      Text("${_calToSize(_getCarb100())}",
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("PROTEIN",
                          style: Theme.of(context).textTheme.bodyText2),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          width: 10,
                          height: 1,
                        ),
                      ),
                      Text("${_calToSize(_getProtein100())}",
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text("CALORIES",
                          style: Theme.of(context).textTheme.bodyText2),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          color: Theme.of(context).primaryColor,
                          width: 10,
                          height: 1,
                        ),
                      ),
                      Text("${_calToSize(_calculateCal())}",
                          style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              height: 1,
              thickness: 1.5,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
              child: Row(
                children: <Widget>[
                  Text("Size: ", style: Theme.of(context).textTheme.bodyText1),
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          inputSize = (double.parse(controller.text));
                        });
                      },
                      //inputSetState(),
                      style: Theme.of(context).textTheme.bodyText1,
                      controller: controller,
                      maxLines: 1,
                      autofocus: false,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.numberWithOptions(),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  FlatButton(
                    child: Text("${widget.selectedProduct.unit}",
                        style: Theme.of(context).textTheme.bodyText1),
                    onPressed: () => _marty(),
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              height: 1,
              thickness: 1.5,
            ),
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Theme.of(context).dividerColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 00),
                child:
                    DataTable(dataRowHeight: 40, columnSpacing: 50, columns: [
                  DataColumn(
                    label: Text(
                      "Name",
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "${widget.selectedProduct.servingSize} ${widget.selectedProduct.unit}",
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      "$inputSize ${widget.selectedProduct.unit}",
                      style: Theme.of(context).textTheme.overline,
                    ),
                  ),
                ], rows: [
                  DataRow(cells: [
                    DataCell(Text("Calories(Kcal)",
                        style: Theme.of(context).textTheme.bodyText2)),
                    DataCell(Text("${_calculateCal()}",
                        style: Theme.of(context).textTheme.bodyText2)),
                    DataCell(Text("${_calToSize(_calculateCal())}",
                        style: Theme.of(context).textTheme.bodyText2)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Fat",
                        style: Theme.of(context).textTheme.bodyText2)),
                    DataCell(Text("${_getFat100()}",
                        style: Theme.of(context).textTheme.bodyText2)),
                    DataCell(Text("${_calToSize(_getFat100())}",
                        style: Theme.of(context).textTheme.bodyText2)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Carbs",
                        style: Theme.of(context).textTheme.bodyText2)),
                    DataCell(Text("${_getCarb100()}",
                        style: Theme.of(context).textTheme.bodyText2)),
                    DataCell(Text("${_calToSize(_getCarb100())}",
                        style: Theme.of(context).textTheme.bodyText2)),
                  ]),
                  DataRow(cells: [
                    DataCell(Text("Protein",
                        style: Theme.of(context).textTheme.bodyText2)),
                    DataCell(Text("${_getProtein100()}",
                        style: Theme.of(context).textTheme.bodyText2)),
                    DataCell(Text("${_calToSize(_getProtein100())}",
                        style: Theme.of(context).textTheme.bodyText2)),
                  ]),
                ]),
              ),
            ),
            Expanded(
              child: Container(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          onPressed: () {
                            print("${widget.selectedProduct.uses}");
                            _updateToUse(widget.selectedProduct.id);
                            _handleSubmitted(
                                widget.selectedProduct.productname,
                                widget.selectedProduct.brand,
                                widget.choosenDb,
                                _calPrice(),
                                inputSize,
                                _calToSize(_getFat100()),
                                _calToSize(_getCarb100()),
                                _calToSize(_getProtein100()),
                                _calToSize(_calculateCal()));
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyApp()));
                          },
                          child: Text(
                            "Save",
                            style: GoogleFonts.lato(
                              color: Colors.green,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.lato(
                              color: Color(0xffdf5d57),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _updateToUse(id) async {
    ProductModel updateProduct = ProductModel(
        widget.selectedProduct.productname,
        widget.selectedProduct.brand,
        widget.selectedProduct.prices,
        widget.selectedProduct.sizeg,
        widget.selectedProduct.unit,
        widget.selectedProduct.fat100,
        widget.selectedProduct.carbs100,
        widget.selectedProduct.protein100,
        widget.selectedProduct.dateCreated,
        1,
        widget.selectedProduct.servingSize,
        inputSize.toDouble());
    await productDb.updateItem(updateProduct, id);
  }

  double roundDouble(double value, int places) {
    double mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  _getFat100() {
    double productFat = widget.selectedProduct.fat100;
    double roundFat = roundDouble(productFat, 2);
    return roundFat;
  }

  _getCarb100() {
    double productCarb = widget.selectedProduct.carbs100;
    double roundCarb = roundDouble(productCarb, 2);
    return roundCarb;
  }

  _getProtein100() {
    double productProtein = widget.selectedProduct.protein100;
    double roundProtein = roundDouble(productProtein, 2);
    return roundProtein;
  }

  _calculateCal() {
    double calories =
        (_getFat100() * 9) + (_getCarb100() * 4) + (_getProtein100() * 4);
    double roundCalories = roundDouble(calories, 2);
    return roundCalories;
  }

  _marty() {
    var mm = new AlertDialog(
      content: Text(""),
    );
    showDialog(
        context: context,
        builder: (_) {
          return mm;
        });
  }

  _calToSize(double productnum) {
    double size = inputSize;

    //void toSize =  ((productnum) * ((size)/100.0));
    double toSize =
        ((productnum) * ((size) / widget.selectedProduct.servingSize));
    double roundToSize = roundDouble(toSize, 2);
    return roundToSize;
  }

  _calPrice() {
    double price = widget.selectedProduct.prices;
    double submitPrice = (price / (widget.selectedProduct.sizeg / inputSize));
    double roundPrice = roundDouble(submitPrice, 2);
    return roundPrice;
  }

  void _handleSubmitted(
      name, brand, type, price, size, fat, carbs, protein, calories) async {
    BreakfastModel toMeal = BreakfastModel(
        name,
        brand,
        type,
        price,
        size,
        fat,
        carbs,
        protein,
        calories,
        "${dSM.daySelected.day}-0${dSM.daySelected.month}-${dSM.daySelected.year}");
    print(
        "added at ${dSM.daySelected.day}/${dSM.daySelected.month}/${dSM.daySelected.year}");
    int savedProductId = await db.saveMeal(toMeal);

    BreakfastModel addedProduct = await db.getMeal(savedProductId);

    setState(() {
      _productList.insert(0, addedProduct);
    });
  }
}
