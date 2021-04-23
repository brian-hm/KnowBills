//Aqui ficará todo o serviço com Cloud Firestore(database)
import 'package:appTCC/models/categoria.dart';
import 'package:appTCC/models/fiscalDocument.dart';
import 'package:appTCC/models/item.dart';
import 'package:appTCC/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  // ignore: non_constant_identifier_names
  final CollectionReference UsuariosCollection =
      FirebaseFirestore.instance.collection('usuarios');

  final CollectionReference produtosCollection =
      FirebaseFirestore.instance.collection('produtos');

  final CollectionReference categorias =
      FirebaseFirestore.instance.collection('categorias');

  final CollectionReference documentoFiscalCollection =
      FirebaseFirestore.instance.collection('documentoFiscal');

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
  Future updateItemData(
      String key, String descricao, double valor, String categoria) async {
    return await produtosCollection.doc(key).set({
      'key': key,
      'uid': uid,
      'descricao': descricao,
      'valor': valor,
      'categoria': categoria
    });
  }

  Future insertItemData(
      String descricao, double valor, String categoria) async {
    String key = produtosCollection.doc().id;
    return await produtosCollection.doc(key).set({
      'key': key,
      'uid': uid,
      'descricao': descricao,
      'valor': valor,
      'categoria': categoria
    });
  }

  //lista de documentos do snapshot
  List<FiscalDocument> _fiscalDocumentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      //if (uid.compareTo(doc.data()['uidUsuario']) == 1) {
      return FiscalDocument(
        uidUsuario: doc.data()['uidUsuario'] ?? '',
        emitente: doc.data()['emitente'] ?? '',
        local: doc.data()['local'] ?? '',
        data: doc.data()['data'] ?? '',
        total: doc.data()['total'] ?? 0,
      );
      // } else {
      //   return null;
      // }
    }).toList();
  }

  //get lista de documentos fiscais
  Stream<List<FiscalDocument>> get fiscalDocuments {
    return documentoFiscalCollection
        .snapshots()
        .map(_fiscalDocumentListFromSnapshot);
  }

  //userData from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
    );
  }

  //item list from snapshot
  List<Item> _itemListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Item(
        key: doc.id,
        uid: doc.data()['uid'],
        idNota: doc.data()['nota'] ?? '',
        descricao: doc.data()['descricao'] ?? '',
        valor: doc.data()['valor'].toDouble() ?? 0.0,
        categoria: doc.data()['categoria'] ?? "",
      );
    }).toList();
  }

  //categoria list from snapshot
  List<Categoria> _categoriaListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return Categoria(
          cor: doc.data()['cor'], descricao: doc.data()['descricao']);
    }).toList();
  }

  //item data from snapshot
  Item _itemDataFromSnaphot(DocumentSnapshot snapshot) {
    return Item(
        key: snapshot.data()['key'],
        uid: snapshot.data()['uid'],
        idNota: snapshot.data()['nota'],
        descricao: snapshot.data()['descricao'],
        valor: snapshot.data()['valor'],
        categoria: snapshot.data()['categoria']);
  }

  Stream<UserData> get userData {
    return UsuariosCollection.doc(uid).snapshots().map(_userDataFromSnapshot);
  }

  Stream<List<Item>> get getItems {
    return produtosCollection.snapshots().map(_itemListFromSnapshot);
  }

  Stream<List<Categoria>> get getCategorias {
    return categorias.snapshots().map((_categoriaListFromSnapshot));
  }
}
