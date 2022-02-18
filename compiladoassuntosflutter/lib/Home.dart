// ignore_for_file: file_names

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List _itens = [];
  void _carregarItens() {
    _itens = [];
    for (int i = 0; i <= 5; i++) {
      Map<String, dynamic> item = Map();
      item["titulo"] = "Título $i Lorem Ipsum dolor sit amet.";
      item["descricao"] = "Descricao $i Lorem Ipsum dolor sit amet.";
      _itens.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    _carregarItens();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Compilado de Assuntos Flutter"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (constext, indice) {
              return ListTile(
                onTap: () {
                  print("Clique com onTap ${indice}");
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                            title: Text("${_itens[indice]['titulo']}"),
                            titlePadding: const EdgeInsets.all(20),
                            titleTextStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.orange,
                            ),
                            content: Text("${_itens[indice]['descricao']}"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  print("Selecionado Sim");
                                  Navigator.pop(context);
                                },
                                child: const Text("Sim"),
                              ),
                              TextButton(
                                onPressed: () {
                                  print("Selecionado Não");
                                  Navigator.pop(context);
                                },
                                child: const Text("Não"),
                              ),
                            ]);
                      });
                },
                /*onLongPress: () {
                  print("Clique com longPress");
                },*/
                title: Text("Item ${_itens[indice]['titulo']}"),
                subtitle: Text("${_itens[indice]['descricao']}"),
              );
            }),
      ),
    );
  }
}
