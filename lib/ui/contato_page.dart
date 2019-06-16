import 'dart:io';

import 'package:agenda_de_contatos/helpers/contato_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class ContatoPage extends StatefulWidget {
  final Contato contato; //Declaração do contato na página

  ContatoPage(
      {this.contato}); // Construtor que recebe o contato, opcional por isso está em chaves.

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();

  //final _telefoneController = TextEditingController();

  final _nameFocus = FocusNode();

  final _telefoneMask = MaskedTextController(mask: "(00) 00000-0000");

  bool _userEdited = false;
  Contato _editeContato;

  @override
  void initState() {
    super.initState();

    if (widget.contato == null) {
      _editeContato = Contato();
    } else {
      _editeContato = Contato.fromMap(widget.contato.toMap());

      _nomeController.text = _editeContato.nome;
      _emailController.text = _editeContato.email;
      _telefoneMask.text = _editeContato.telefone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text(_editeContato.nome ?? "Novo Contato"),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (_editeContato.nome != null && _editeContato.nome.isNotEmpty) {
              Navigator.pop(context, _editeContato);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          child: Icon(Icons.save),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              GestureDetector(
                child: Container(
                  width: 140.0,
                  height: 140.0,
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: _editeContato.img != null
                          ? FileImage(File(_editeContato.img))
                          : AssetImage("images/images.png"),
                    ),
                  ),
                ),
              ),
              TextField(
                  controller: _nomeController,
                  focusNode: _nameFocus,
                  decoration: InputDecoration(labelText: "Nome"),
                  onChanged: (text) {
                    _userEdited = true;
                    setState(() {
                      _editeContato.nome = text;
                    });
                  }),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
                onChanged: (text) {
                  _userEdited = true;
                  _editeContato.email = text;
                },
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _telefoneMask,
                decoration: InputDecoration(labelText: "Telefone"),
                onChanged: (text) {
                  _userEdited = true;
                  _editeContato.telefone = text;
                },
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _requestPop(){
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações ?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                )
              ],
            );
          });
      return Future.value(false);
    }else{
      return Future.value(true);
    }
  }
}
