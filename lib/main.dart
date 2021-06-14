import 'package:flutter/material.dart';
import 'package:flutterpro/product-edit.dart';

import 'home.dart';
import 'models/product.dart';
import 'product-add.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    HomePage.tag: (context) => HomePage(),
    ProductAddPage.tag: (context) => ProductAddPage(),
    ProductEditPage.tag: (context) => ProductEditPage(),
  };

  @override
  Widget build(BuildContext context) {
    List list = getProducts();
    return MaterialApp(
        title: 'ThizerList',
        theme: ThemeData(
            primaryColor: Colors.blue,
            accentColor: Colors.white,
            textTheme: TextTheme(
                headline: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                title: TextStyle(
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    color: Colors.blue),
                body1: TextStyle(fontSize: 14))),
        home: HomePage(),
        routes: routes);
  }

  List getProducts() {
    return [
      Product(
        name: "Artigo0",
        description: "Artigo0",
        price: 2,
        quantity: 2,
      ),
      Product(
        name: "Artigo1",
        description: "Artigo1",
        price: 10,
        quantity: 5,
      ),
      Product(
        name: "Artigo2",
        description: "Artigo2",
        price: 1,
        quantity: 1,
      ),
      Product(
        name: "Artigo3",
        description: "Artigo3",
        price: 1.5,
        quantity: 3,
      ),
    ];
  }
}
