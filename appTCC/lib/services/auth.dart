import 'package:appTCC/models/user.dart';
import 'package:appTCC/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Aqui ficará todo "serviço" de autenticação

class AuthService {
  
  final FirebaseAuth _auth = FirebaseAuth.instance; //"_ indica que é privado"

  //cria o objeto User a partir do userCrendetial
  Usuario _userFromUserCrendetial(User user) {
    return user != null ? Usuario(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<Usuario> get user {
    return _auth
        .authStateChanges()
        //.map((User user) => _userFromUserCrendetial(user));
        .map(_userFromUserCrendetial);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      return _userFromUserCrendetial(userCredential.user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in com email e senha
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return _userFromUserCrendetial(userCredential.user);
    } catch (e) {
      print(e.toString());
    }
  }

  //registrar com email e senha
  Future registerWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      //cria um novo documento para o usuario com a uid
      await DatabaseService(uid: userCredential.user.uid).updateUserData(name);

      return _userFromUserCrendetial(userCredential.user);
    } catch (e) {
      print(e.toString());
    }
  }

  //sing out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toStrin());
    }
  }
}
