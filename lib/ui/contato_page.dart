import 'package:agenda_de_contatos/helpers/contato_helper.dart';
import 'package:flutter/material.dart';

class ContatoPage extends StatefulWidget {

  final Contato contato; //Declaração do contato na página

  ContatoPage({this.contato});// Construtor que recebe o contato, opcional por isso está em chaves.

  @override
  _ContatoPageState createState() => _ContatoPageState();
}

class _ContatoPageState extends State<ContatoPage> {

  Contato _editeContato;

  @override
  void initState() {
    super.initState();

    if(widget.contato == null){
      _editeContato = Contato();
    }
    else{
      _editeContato = Contato.fromMap(widget.contato.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(_editeContato.nome ?? "Novo Contato"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){},
          child: Icon(Icons.save),
        backgroundColor: Colors.red,
      ),


    );
  }
}


