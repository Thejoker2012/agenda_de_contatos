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

  //Função para salvar contatos no banco de dados
  Future<Contato> saveContato(Contato contato) async{
    Database dbContato = await database;
    contato.id = await dbContato.insert(tabelaContato, contato.toMap());
    return contato;
  }

  //Função para buscar dados no banco de dados
  Future<Contato> getContato(int id) async {
    Database dbContato = await database;
    List<Map> maps = await dbContato.query(tabelaContato,
    columns: [idColumn, nomeColumn,emailColumn,telefoneColumn,imgColumn],
    where: "$idColumn = ?",
    whereArgs: [id]);

    if(maps.length > 0){
      return Contato.fromMap(maps.first);
    }
    else{
      return null;
    }
  }

  //Função para deletar um dados do banco de dados
  Future<int> deleteContato(int id) async{
    Database dbContato = await database;
    return await dbContato.delete(tabelaContato,where: "$idColumn = ?", whereArgs: [id]);
  }

  //Função para atualizar dados no banco de dados
  Future<int> updateContato(Contato contato) async{
    Database dbContato = await database; 
    return await dbContato.update(tabelaContato, contato.toMap(),where:"$idColumn = ?", whereArgs: [contato.id] );

  }

  //Função para buscar todos os contatos no banco
  Future<List> getAllContatos() async{
    Database dbContato = await database;
    List listMap = await dbContato.rawQuery("SELECT * FROM $tabelaContato");
    List<Contato> listContatos = List();
    for(Map m in listMap){
      listContatos.add(Contato.fromMap(m));
    }
    return listContatos;
  }

  //Função para pegar um numero no banco
  Future<int> getNumber() async{
    Database dbContato = await database;
    return Sqflite.firstIntValue(await dbContato.rawQuery("SELECT COUNT(*) FROM $tabelaContato"));
  }

  //Função para fechar o banco de dados
  Future close() async{
    Database dbContato = await database;
    dbContato.close();
  }


}

//Classe Beans
class Contato{

  int id;
  String nome;
  String email;
  String telefone;
  String img;

  //Construtor Vazio
  Contato();

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