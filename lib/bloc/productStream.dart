import 'dart:async';

import 'package:mcr/db/db_from_asset.dart';
import 'package:mcr/db/product_db_provider.dart';
import 'package:mcr/models/product_model.dart';
import 'package:rxdart/rxdart.dart';

class ProductStreams{

  var db = DatabaseHelper();
  var assetDb = GettingCopyDb();

  final _productList = BehaviorSubject<List<ProductModel>>();

  Stream<List<ProductModel>> get productList => _productList.stream;
  StreamSink<List<ProductModel>> get toProductList => _productList.sink;

  ProductStreams(){
    _addProducts();
  }

  _addProducts()async{
    List<ProductModel> b = <ProductModel>[];
    List assetproducts = await assetDb.getProducts();
    assetproducts.forEach((product){
      b.add(ProductModel.map(product));
    });
    List products = await db.getProducts();
    products.forEach((product){
        b.add(ProductModel.map(product));
    });
  }

  void dispose(){
    _productList.close();
  }
}