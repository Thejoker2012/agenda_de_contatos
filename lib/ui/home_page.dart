import 'dart:io';

import 'package:agenda_de_contatos/helpers/contato_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'contato_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContatoHelper helper = ContatoHelper();

  List<Contato> contatos = List();

  @override
  void initState() {
    super.initState();

    /*Contato contato = Contato();
    contato.nome = "Iago Oliveira";
    contato.email = "iago@teste.com";
    contato.telefone = "32121004";
    contato.img = "imagenTeste";
    helper.saveContato(contato);*/

    _getAllContatos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contatos"),
        backgroundColor: Colors.red,
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showContatoPage();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contatos.length,
        itemBuilder: (context, index) {
          return _contatoCard(context, index);
        },
      ),
    );
  }

  Widget _contatoCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: contatos[index].img != null
                        ? FileImage(File(contatos[index].img))
                        : AssetImage("images/images.png"),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      contatos[index].nome ?? "",
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      contatos[index].email ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(
                      contatos[index].telefone ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Ligar",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                          launch("tel:${contatos[index].telefone}");
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Editar",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          _showContatoPage(contato: contatos[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Excluir",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 20.0,
                          ),
                        ),
                        onPressed: () {
                          helper.deleteContato(contatos[index].id);
                          setState(() {
                            contatos.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  void _showContatoPage({Contato contato}) async {
    final recContato = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => ContatoPage(contato: contato)));
    if (recContato != null) {
      if (contato != null) {
        await helper.updateContato(recContato);
        _getAllContatos();
      } else {
        await helper.saveContato(recContato);
      }
      _getAllContatos();
    }
  }

  void _getAllContatos() {
    helper.getAllContatos().then((list) {
      setState(() {
        contatos = list;
      });
    });
  }
}
