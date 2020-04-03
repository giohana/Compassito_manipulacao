import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:manipulacao/models/api.dart';
import 'package:manipulacao/models/apiTipoItens.dart';
//import 'package:manipulacao/http/webclient.dart';
import 'package:manipulacao/models/autoGenerate.dart';

class Inputar extends StatefulWidget {
  @override
  _InputarState createState() => _InputarState();
}

class _InputarState extends State<Inputar> {
  TextEditingController _controladorItem = TextEditingController();

  TextEditingController _controladorTipoItem = TextEditingController();

  TextEditingController _controladorQuantidadeReservado =
      TextEditingController();

  TextEditingController _controladorQuantidadeDisponivel =
      TextEditingController();

  TextEditingController _controladorValor = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Manipulação'),
        ),
        body: Column(
          children: <Widget>[
            Input(
              rotulo: 'Nome do produto',
              ctrl: _controladorItem,
            ),
            Input(
              rotulo: 'Quantidade Reservada',
              ctrl: _controladorQuantidadeReservado,
            ),
            Input(
              rotulo: 'Quantidade Disponível',
              ctrl: _controladorQuantidadeDisponivel,
            ),
            Input(
              rotulo: 'Preço',
              ctrl: _controladorValor,
            ),
            Box(),
            RaisedButton(
                child: Text('Confirmar'),
                onPressed: () {
                  debugPrint('pressionei o botão confirmar');

                  final String item = _controladorItem.text;
                  final String tipoItem = _controladorTipoItem.text;
                  final int quantidadeReservado =
                      int.tryParse(_controladorQuantidadeReservado.text);
                  final int quantidadeDisponivel =
                      int.tryParse(_controladorQuantidadeDisponivel.text);
                  final int valor = int.tryParse(_controladorValor.text);
                  //final bool ativo = ativacao;

                  AutoGenerated(
                    item: item,
                    tipoItem: tipoItem,
                    quantidadeReservado: quantidadeReservado,
                    quantidadeDisponivel: quantidadeDisponivel,
                    valor: valor,
                    ativo: true,
                  );

                  print(item);
                  print(tipoItem);
                  print(quantidadeReservado);
                  print(quantidadeDisponivel);
                  print(valor);
                }),
          ],
        ),
      ),
    );
  }
}

class TipoDoItem extends StatefulWidget {
  @override
  _TipoDoItemState createState() => _TipoDoItemState();
}

class _TipoDoItemState extends State<TipoDoItem> {
  var tipoProdutos = new List<TipoItem>();

  _getTipoProdutos() {
    ApiTipoItens.getTipos().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        tipoProdutos = lista.map((model) => TipoItem.fromJson(model)).toList();
      });
    });
  }

  _TipoDoItemState() {
    _getTipoProdutos();
  }

  @override
  Widget build(BuildContext context) {
    return tiposdositens();
  }

  String newValue = 'selelcione';

  tiposdositens() {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: tipoProdutos.length,
        itemBuilder: (context, index) {
          return MaterialApp();
        });
  }
}

class Box extends StatefulWidget {
  @override
  _BoxState createState() => _BoxState();
}

class _BoxState extends State<Box> {
  bool ativacao = false;
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('Ativar: '),
      value: ativacao,
      onChanged: (bool newValue) {
        setState(() {
          ativacao = newValue;
        });
        return ativacao;
      },
    );
  }
}

class Input extends StatelessWidget {
  final TextEditingController ctrl;
  final String rotulo;

  Input({this.rotulo, this.ctrl});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          controller: ctrl,
          style: TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            labelText: rotulo,
          ),
        ));
  }
}

/*

FutureBuilder<List<AutoGenerated>>(
          future: findAll(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                break;
              case ConnectionState.waiting:
                break;
              case ConnectionState.active:
                break;
              case ConnectionState.done:
                break;
            }
            final List<AutoGenerated> autoGenerated = snapshot.data;
*/
