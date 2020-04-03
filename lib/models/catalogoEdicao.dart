/*
 * Nesse arquivo é feita a primira parte do app, criando e mostransdo os produtos disponiveis, é feita a transação
 * do obejeto dart para ser exibida no app.
*/

import 'dart:convert';
import 'package:flutter/material.dart';
//import 'package:manipulacao/http/webclient.dart';
import 'package:manipulacao/models/Inputar.dart';
import 'package:manipulacao/models/api.dart';
import 'package:manipulacao/models/autoGenerate.dart';

class CatalogoEdicao extends StatefulWidget {
  @override
  _CatalogoEdicaoState createState() => _CatalogoEdicaoState();
}

class _CatalogoEdicaoState extends State<CatalogoEdicao> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeMais(),
    );
  }
}

class HomeMais extends StatefulWidget {
  @override
  _HomeMaisState createState() => _HomeMaisState();
}

class _HomeMaisState extends State<HomeMais> {
  //feita a chamada do obeto dart passando ele para uma lista para ser possivel exibir
  var produtos = new List<AutoGenerated>();

  _getProdutos() {
    Api.getProdutos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        produtos = lista.map((model) => AutoGenerated.fromJson(model)).toList();
      });
    });
  }

  _HomeMaisState() {
    _getProdutos();
  }

//colocação do botão(+) e o navigator, que o leva para a pagina para adicionar um produto
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Manipulação'),
        ),
        body: catalogoProdutos(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            print('cliquei no mais');
            Navigator.push(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) => new Inputar()));
          },
        ));
  }

  //metodo feito para listar os produtos da api e passa-los para o widget que os exibe, atraves de um listTile
  catalogoProdutos() {
    return ListView.builder(
      itemCount: produtos.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.terrain),
          title: Text(produtos[index].item),
          subtitle: Text(produtos[index].tipoItem),
          onTap: () => print("precionei o card"),
        );
      },
    );
  }
}
