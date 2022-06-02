import 'package:cata_treco/models/user/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class UsuarioServices {
  Usuario? usuario;

  //Método para realizar a autenticação no firebase com email e senha
  Future<void> signIn(
    Usuario usuario, {
    Function? onSuccess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.signInWithEmailAndPassword(
              email: usuario.email!, password: usuario.password!))
          .user;
      usuario = usuario;
      usuario.id = user!.uid;
      //Função Callback
      onSuccess!();
    } on PlatformException catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  //Método para registrar o usuário no Firebase
  Future<void> signUp(
    Usuario usuario, {
    Function? onSuccess,
    Function? onFail,
  }) async {
    try {
      User? user = (await _auth.createUserWithEmailAndPassword(
              email: usuario.email!, password: usuario.password!))
          .user;
      usuario = usuario;
      usuario.id = user!.uid;
      usuario.role = "n";
      addUsuario(usuario, user.uid);
      onSuccess!();
    } catch (e) {
      onFail!(debugPrint(e.toString()));
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  addUsuario(Usuario usuario, String id) async {
    await _firestore.collection("Usuarios").doc(id).set(
          usuario.toMap(),
        );
  }

  Usuario getUsuarioLogado(String id) {
    Usuario usuario = Usuario();
    _firestore.collection('Usuarios').doc(id).get().then((data) {
      usuario.id = data['id'];
      usuario.nome = data['nome'];
      usuario.email = data['email'];
      usuario.password = data['password'];
      usuario.telefone = data['telefone'];
      usuario.confirmPassword = data['confirmPassword'];
    });
    return usuario;
  }

  //Criar método para obter os dados do FIREBASE
  //Devemos definir o tipo de retorno de acordo com quem vai receber o resultado
  Stream<QuerySnapshot> getUsuarioList() {
    //definimos que tipo de dados pode conter a listagem vindo do firebase
    CollectionReference unitCollection = _firestore.collection('Usuarios');
    return unitCollection.snapshots();
  }

  Future<Usuario> getUsuarioLogado2(String id) async {
    DocumentSnapshot docUser =
        await _firestore.collection('Usuarios').doc(id).get();
    //Usuario usuario = Usuario.fromDocument(docUser);
    return Usuario.fromDocument(docUser);
  }
}
