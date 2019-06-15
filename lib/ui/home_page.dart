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

        },
      ),
    );
  }
}
