import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home.dart';
import 'models/product.dart';

class ProductAddPage extends StatefulWidget {
  static String tag = 'page-item-add';

  @override
  _ProductAddPageState createState() => _ProductAddPageState();
}

class _ProductAddPageState extends State<ProductAddPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cName = TextEditingController();
  final TextEditingController _cDescription = TextEditingController();
  final TextEditingController _cValor = TextEditingController();
  final TextEditingController _cQtd = TextEditingController();
  File imageFile;
  Future<File> image;
  Product produto =
      new Product(name: "ola", description: "ola", quantity: 2, price: 2.0);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    List listProduct = ModalRoute.of(context).settings.arguments;

    final inputName = TextFormField(
      controller: _cName,
      autofocus: true,
      decoration: InputDecoration(
          hintText: 'Nome do item',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return "";
      },
    );

    final inputDescription = TextFormField(
      controller: _cDescription,
      autofocus: true,
      decoration: InputDecoration(
          hintText: 'Descricao do item',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return "";
      },
    );

    final inputQuantidade = TextFormField(
      controller: _cQtd,
      autofocus: false,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          hintText: 'Quantidade',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return "";
      },
    );

    final inputValor = TextFormField(
      controller: _cValor,
      autofocus: false,
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
          hintText: 'Valor €',
          contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
      validator: (value) {
        if (value.isEmpty) {
          return 'Obrigatório';
        }
        return "";
      },
    );

    void adicionaLista(
        String name, String descricao, int quantidade, double preco) {
      Product product = new Product(
          name: name,
          description: descricao,
          price: preco,
          quantity: quantidade);
      if (image != null) {
        product.imageFile = image;
      }
      listProduct.add(product);
    }

    //Open gallery
    pickImageFromGallery(ImageSource source) {
      setState(() {
        image = ImagePicker.pickImage(source: source);
      });
    }

    Widget showImage() {
      return FutureBuilder<File>(
        future: image,
        builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data != null) {
            return Image.file(
              snapshot.data,
              width: 300,
              height: 300,
            );
          } else if (snapshot.error != null) {
            return const Text(
              'Error na Imagem',
              textAlign: TextAlign.center,
            );
          } else {
            return const Text(
              'Imagem predefinida carregada',
              textAlign: TextAlign.center,
            );
          }
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text("Adicionar Produto"),
      ),
      body: Center(
        child: Container(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(20),
              children: <Widget>[
                showImage(),
                RaisedButton(
                  child: Text("Altera a imagem"),
                  onPressed: () {
                    pickImageFromGallery(ImageSource.gallery);
                  },
                ),
                SizedBox(height: 10),
                Text('Nome do produto'),
                inputName,
                SizedBox(height: 10),
                Text('descrição do produto'),
                inputDescription,
                SizedBox(height: 10),
                Text('Quantidade'),
                inputQuantidade,
                Text('Preço por unidade'),
                inputValor,
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      color: Colors.black12,
                      child: Text('Cancelar',
                          style: TextStyle(color: Colors.white)),
                      padding: EdgeInsets.only(left: 50, right: 50),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    RaisedButton(
                      color: Colors.redAccent,
                      child: Text('Adicionar',
                          style: TextStyle(color: Colors.white)),
                      padding: EdgeInsets.only(left: 50, right: 50),
                      onPressed: () {
                        adicionaLista(_cName.text, _cDescription.text,
                            int.parse(_cQtd.text), double.parse(_cValor.text));
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage(),
                              settings: RouteSettings(
                                arguments: listProduct,
                              )),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
