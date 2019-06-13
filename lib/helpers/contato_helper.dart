import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String tabelaContato = "tabelaContato";
final String idColumn = "idColumn";
final String nomeColumn = "nomeColumn";
final String emailColumn = "emailColumn";
final String telefoneColumn = "telefoneColumn";
final String imgColumn = "imgColumn";


class ContatoHelper{

  static final ContatoHelper _instance = ContatoHelper.internal();

  factory ContatoHelper() => _instance;

  ContatoHelper.internal();

  Database _database;
  Future<Database> get database async{
    if(_database != null){
      return _database;
    }else{
      _database = await initDb();
      return _database;
    }
  }

  Future <Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath,"contato.db");

    return await openDatabase(path, version:1, onCreate: (Database db, int newerVersion) async{
      await db.execute(
        "CREATE TABLE $tabelaContato($idColumn INTEGER PRIMARY KEY,"
            "                        $nomeColumn TEXT,"
            "                        $emailColumn TEXT,"
            "                        $telefoneColumn TEXT,"
            "                        $imgColumn TEXT)"
      );
    });
  }

}

//Classe Beans
class Contato{

  int id;
  String nome;
  String email;
  String telefone;
  String img;

  //Construtor da classe contato
  Contato.fromMap(Map map){

    id = map[idColumn];
    nome = map[nomeColumn];
    email = map[emailColumn];
    telefone = map[telefoneColumn];
    img = map[imgColumn];

  }

  //Função que retorna o mapa dos contatos
  Map toMap(){
    Map<String, dynamic> map = {

      nomeColumn:nome,
      emailColumn:email,
      telefoneColumn:telefone,
      imgColumn:img

    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Contato(id:$id,nome:$nome,email:$email,telefone:$telefone,img:$img)";
  }


}