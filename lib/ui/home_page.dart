import 'package:agenda_de_contatos/helpers/contato_helper.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContatoHelper helper = ContatoHelper();

  @override
  void initState() {
    super.initState();

    /*Contato contato = Contato();
    contato.nome = "Iago Oliveira";
    contato.email = "iago@teste.com";
    contato.telefone = "32121004";
    contato.img = "imagenTeste";

    helper.saveContato(contato);*/

   helper.getAllContatos().then((List){
     print(List);
   });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
