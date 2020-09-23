//Aqui ficará todo o serviço com Cloud Firestore(database)
import 'package:appTCC/models/fiscalDocument.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  //collection reference
  // ignore: non_constant_identifier_names
  final CollectionReference UsuariosCollection =
      FirebaseFirestore.instance.collection('usuarios');

  final CollectionReference documentoFiscalCollection =
      FirebaseFirestore.instance.collection('documentoFiscal');

  //tanto para inserir, quanto para alterar dados do Usuário
  //a chave do documento de cada usuário será o UID gerado pela Autenticaçao
  Future updateUserData(String name) async {
    return await UsuariosCollection.doc(uid).set({
      //doc(uid) vai ser criado
      'nome': name,
    });
  }

  //lista de documentos do snapshot
  List<FiscalDocument> _fiscalDocumentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return FiscalDocument(
        emitente: doc.data()['emitente'] ?? '',
        local: doc.data()['local'] ?? '',
        data: doc.data()['data'] ?? '',
        total: doc.data()['total'] ?? 0,
      );
    }).toList();
  }

  //get lista de documentos fiscais
  Stream<List<FiscalDocument>> get fiscalDocuments {
    return documentoFiscalCollection
        .snapshots()
        .map(_fiscalDocumentListFromSnapshot);
  }
}
