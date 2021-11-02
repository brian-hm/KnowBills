//Aqui ficará todo o serviço com Cloud Firestore(database)
import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/fiscalDocument.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/nota.dart';
import 'package:appTCC/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  // ignore: non_constant_identifier_names
  final CollectionReference UsuariosCollection =
      FirebaseFirestore.instance.collection('usuarios');

  final CollectionReference notasCollection =
      FirebaseFirestore.instance.collection('notas');

  final CollectionReference produtosCollection =
      FirebaseFirestore.instance.collection('produtos');

  final CollectionReference categoriasCollection =
      FirebaseFirestore.instance.collection('categorias');

  //tanto para inserir, quanto para alterar dados do Usuário
  //a chave do documento de cada usuário será o UID gerado pela Autenticaçao
  Future updateUserData(String name, String uid, String email) async {
    return await UsuariosCollection.doc(uid).set({
      //doc(uid) vai ser criado
      'uid': uid,
      'nome': name,
      'email': email,
    });
  }

  //tanto para inserir, quanto para alterar dados do Item
  Future updateItemData(String key, String idNota, String descricao,
      String local, double valor, String categoria) async {
    return await produtosCollection.doc(key).set({
      'key': key,
      'uid': uid,
      'idNota': idNota,
      'descricao': descricao,
      'local': local,
      'valor': valor,
      'categoria': categoria
    });
  }

  Future insertItemData(String idNota, String descricao, double valor,
      String categoria, String local) async {
    String key = produtosCollection.doc().id;
   
    return await produtosCollection.doc(key).set({
      'key': key,
      'uid': uid,
      'idNota': idNota,
      'descricao': descricao,
      'valor': valor,
      'categoria': categoria,
      'local': local
    });
  }


//Inserir valor na Categoria
  Future insertValueCategoria (String descricaoCategoria, double valor) async{

    double total;
    var document = await categoriasCollection.doc(descricaoCategoria).get();
    total = valor + document.data()['total'];

    return await categoriasCollection.doc(descricaoCategoria).set({
      'descricao' : document.data()['descricao'],
      'cor': document.data()['cor'],
      'total' : total
    });

  }

//Remover Valor da Categoria
  Future removeValueCategoria (String descricaoCategoria, double valor) async{
    double total;
    var document = await categoriasCollection.doc(descricaoCategoria).get();
    total = document.data()['total'] - valor;

    return await categoriasCollection.doc(descricaoCategoria).set({
      'descricao' : document.data()['descricao'],
      'cor': document.data()['cor'],
      'total' : total
    });

  }


  Future insertNota(String chave, String local, double valor, String link,
      String data) async {
    return await notasCollection.doc(chave).set({
      'uid': uid,
      'chave': chave,
      'local': local,
      'valor': valor,
      'link': link,
      'data': data,
    });
  }

  Future updateCategoria(String descricao, double total, String cor) async {
    return await categoriasCollection.doc(descricao).set({
      'descricao': descricao,
      'cor': cor,
      'total': total,
    });
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
    );
  }

  Nota _notaDataFromSnapshot(DocumentSnapshot snapshot) {
    return Nota(
      uid: uid,
      chave: snapshot.data()['chave'],
      local: snapshot.data()['local'],
      valor: snapshot.data()['valor'],
      link: snapshot.data()['link'],
      data: snapshot.data()['data'],
    );
  }

  List<Nota> _notaListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Nota(
          chave: doc.id,
          uid: doc.data()['uid'],
          local: doc.data()['local'] ?? "",
          valor: doc.data()['valor'].toDouble() ?? 0.0,
          link: doc.data()['link'] ?? "",
          data: doc.data()['data'] ?? "");
    }).toList();
  }

  //item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Item(
        key: doc.id,
        uid: doc.data()['uid'],
        idNota: doc.data()['idNota'] ?? '',
        descricao: doc.data()['descricao'] ?? '',
        valor: doc.data()['valor'].toDouble() ?? 0.0,
        categoria: doc.data()['categoria'] ?? "",
        local: doc.data()['local'] ?? "",
      );
    }).toList();
  }

  //categoria list from snapshot
  List<Categoria> _categoriaListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Categoria(
          cor: doc.data()['cor'],
          descricao: doc.data()['descricao'],
          total: doc.data()['total'].toDouble());
    }).toList();
  }

  Categoria _categoriaFromSnapshot(DocumentSnapshot snapshot) {
    print('Cheguei from Snapshot');

      return Categoria(
        descricao: snapshot.data()['descricao'],
        cor: snapshot.data()['cor'],
        total: snapshot.data()['total']
      );
   
  }

  Stream<UserData> get userData {
    return UsuariosCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<Nota> get nota {
    return notasCollection.doc(uid).snapshots().map(_notaDataFromSnapshot);
  }

  Stream<List<Item>> getItensNota(String idNota) {
    return produtosCollection
        .where("idNota", isEqualTo: idNota)
        .snapshots()
        .map(_itemListFromSnapshot);
  }

  Stream<List<Item>> getItems(String uid, String categoria) {
    if (categoria == "Todos") {
      categoria = null;
    }
    return produtosCollection
        .where("uid", isEqualTo: uid)
        .where("categoria", isEqualTo: categoria)
        .snapshots()
        .map(_itemListFromSnapshot);
  }

  Stream<List<Categoria>> get getCategorias {
    return categoriasCollection.snapshots().map((_categoriaListFromSnapshot));
  }

  Stream<Categoria> getCategoria(String descricao) {
    
    print(categoriasCollection.doc(descricao).snapshots());   
    return categoriasCollection
        .doc(descricao)
        .snapshots()
        .map((_categoriaFromSnapshot));
  }

  Stream<List<Nota>> getNotas(String uid) {
    return notasCollection
        .where("uid", isEqualTo: uid)
        .snapshots()
        .map((_notaListFromSnapshot));
  }
}
