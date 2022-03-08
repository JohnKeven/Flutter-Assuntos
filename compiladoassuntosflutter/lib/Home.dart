// ignore_for_file: file_names
import 'package:compiladoassuntosflutter/Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /* Listview
  List _itens = [];
  void _carregarItens() {
    _itens = [];
    for (int i = 0; i <= 5; i++) {
      Map<String, dynamic> item = Map();
      item["titulo"] = "Título $i Lorem Ipsum dolor sit amet.";
      item["descricao"] = "Descricao $i Lorem Ipsum dolor sit amet.";
      _itens.add(item);
    }
  }*/

/*
  Future<Map> _recuperarPreco() async {
    var url = Uri.parse('https://blockchain.info/ticker');
    http.Response response = await http.get(url);
    return json.decode(response.body);
  }
*/
  final String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagens() async {
    http.Response response = await http.get(Uri.parse(_urlBase + "/posts"));
    var dadosJson = json.decode(response.body);
    List<Post> postagens = [];
    for (var post in dadosJson) {
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
    return postagens;
  }

  _post() async {
    var postagem = json.encode({
      "userId": 120,
      "id": 3,
      "title": "Titulo Alterado",
      "body": "Postagem Alterada"
    });

    http.Response response = await http.post(
      Uri.parse(_urlBase + "/posts"),
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: postagem,
    );

    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");
  }

  _put() async {
    var postagem = json.encode({
      "userId": 120,
      "id": null,
      "title": "Titulo Alterado",
      "body": "Postagem Alterada"
    });
    http.Response response = await http.put(
      Uri.parse(_urlBase + "/posts/2"),
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: postagem,
    );
    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");
  }

  _patch() async {
    var postagem = json.encode(
      {
        "userId": 130,
        "body": "Postagem Alterada",
      },
    );
    http.Response response = await http.patch(
      Uri.parse(_urlBase + "/posts/2"),
      headers: {"Content-type": "application/json; charset=UTF-8"},
      body: postagem,
    );
    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");
  }

  _delete() async {
    http.Response response =
        await http.delete(Uri.parse(_urlBase + "/posts/2"));
    if (response.statusCode.toString() == "200") {
      print("Deletado com Sucesso");
    } else {
      print("Erro ao deletar");
    }
    print("Resposta: ${response.statusCode}");
    print("Resposta: ${response.body}");
  }

  @override
  Widget build(BuildContext context) {
    // _carregarItens();

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton(
                  onPressed: _post,
                  child: const Text("Salvar"),
                ),
                ElevatedButton(
                  onPressed: _patch,
                  child: const Text("Atualizar"),
                ),
                ElevatedButton(
                  onPressed: _delete,
                  child: const Text("Deletar"),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                  future: _recuperarPostagens(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        break;
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.active:
                        break;
                      case ConnectionState.done:
                        if (snapshot.hasError) {
                          print("Erro ao Carregar");
                        } else {
                          return ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              List<Post> lista = snapshot.data!;
                              Post post = lista[index];
                              return ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.id.toString()),
                              );
                            },
                          );
                        }
                        break;
                    }
                    return const Center(child: Text(" "));
                  }),
            ),
          ],
        ),
      ),
    );

    /* FutureBuilder<Map>(
        future: _recuperarPreco(),
        builder: (context, snapshot) {
          String resultado = "";

          switch (snapshot.connectionState) {
            case ConnectionState.none:
              break;
            case ConnectionState.waiting:
              print("Conexão waiting");
              resultado = "Carregando...";
              break;
            case ConnectionState.active:
              break;
            case ConnectionState.done:
              print("Conexão done");
              if (snapshot.hasError) {
                resultado = "Erro ao carregar os dados";
              } else {
                var valor = snapshot.data!["BRL"]["buy"];
                resultado = "Preço do bitcoin: ${valor.toString()}";
              }
              break;
          }
          return Center(
            child: Text(resultado),
          );
        }); */

    /* LIST VIEW, EVENTOS DE CLIQUE E DIALOG (ALERTDIALOG)
      Container(
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
      ), */
  }
}
