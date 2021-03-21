import 'package:flutter/material.dart';
import 'package:mcr/models/product_model.dart';
import 'package:mcr/db/product_db_provider.dart';
import 'package:mcr/screens/add_food_to_meal.dart';
import 'package:mcr/screens/add_screen.dart';

class FoodSelector extends StatefulWidget {
  final choosenDb;

  const FoodSelector({Key key, this.choosenDb}) : super(key: key);
  @override
  _FoodSelectorState createState() => _FoodSelectorState();
}

class _FoodSelectorState extends State<FoodSelector> {
  var db = DatabaseHelper();
  final List<ProductModel> _productList = <ProductModel>[];
  final List<ProductModel> items = <ProductModel>[];
  TextEditingController searchcontroller = TextEditingController();
  var ddb;

  @override
  void initState() {
    super.initState();
    _readProducts();
    ddb = widget.choosenDb;
  }

  _readProducts() async {
    List products = await db.getProducts();
    products.forEach((product) {
      setState(() {
        _productList.add(ProductModel.map(product));
        items.add(ProductModel.map(product));
      });
    });
  }

  _deleteProduct(int id, int index) async {
    await db.deleteProduct(id);
    setState(() {
      items.removeAt(index);
    });
  }

  void filterSearchResults(String query) {
    List<ProductModel> dummySearchList = List<ProductModel>();
    dummySearchList.addAll(_productList);
    if (query.isNotEmpty) {
      List<ProductModel> dummyListData = List<ProductModel>();
      dummySearchList.forEach((item) {
        if (item.productname.toLowerCase().contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(_productList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: InkWell(
                child: Icon(Icons.add, color: Colors.white),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddScreen(
                              choosenDb: ddb,
                              goBackToFirstScreen: false,
                            ))),
              ),
            )
          ],
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
            child: Text('Food Library',
                style: Theme.of(context).textTheme.headline6),
          ),
        ),
        body: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: TextField(
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0),
                      hintText: "Search",
                      hintStyle: Theme.of(context).textTheme.bodyText2,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white10,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                      )),
                  controller: searchcontroller,
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                ),
              ),
            ),
            Divider(
              thickness: 1,
              height: 5,
              color: Theme.of(context).primaryColorDark,
            ),
            Expanded(
              child: ListView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(0.0),
                  reverse: false,
                  itemCount: items.length,
                  itemBuilder: (_, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 2),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 40,
                            child: InkWell(
                              onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AddFoodToMeal(
                                          choosenDb: ddb,
                                          selectedProduct: items[index]))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Text(items[index].productname,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 2.0),
                                          child: Text(items[index].brand ?? "",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () =>
                                        _deleteProduct(items[index].id, index),
                                    child: Icon(
                                      Icons.clear,
                                      size: 20,
                                      color: Color(0xffdf5d57),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            height: 0,
                            color: Theme.of(context).dividerColor,
                          ),
                        ],
                      ),
                    );
                  }),
            ),

            // Divider(
            //   height: 10.0,
            // )
          ],
        ),
      ),
    );
  }
}
