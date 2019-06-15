import 'dart:io';

import 'package:agenda_de_contatos/helpers/contato_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContatoHelper helper = ContatoHelper();

  List<Contato> contato =  List();

  @override
  void initState() {
    super.initState();

    /*Contato contato = Contato();
    contato.nome = "Iago Oliveira";
    contato.email = "iago@teste.com";
    contato.telefone = "32121004";
    contato.img = "imagenTeste";
    helper.saveContato(contato);*/

    helper.getAllContatos().then((list){
      setState(() {
        contato = list;
      });
    });
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
        onPressed: (){},
        child: Icon(Icons.add),
        backgroundColor: Colors.red,
        ),
      body: ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: contato.length,
        itemBuilder: (context, index){
          return _contatoCard(context, index);
        },
      ),
    );
  }

  Widget _contatoCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: contato[index].img != null ?
                    FileImage(File(contato[index].img)):
                        AssetImage("images/images.png"),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(contato[index].nome ?? "",
                    style: TextStyle(fontSize: 22.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  Text(contato[index].email ?? "",
                    style: TextStyle(fontSize: 18.0
                    ),
                  ),
                  Text(contato[index].telefone ?? "",
                    style: TextStyle(fontSize: 18.0
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      ),
    );
  }
}
