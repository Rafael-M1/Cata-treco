import 'package:cata_treco/models/coleta/coleta.dart';
import 'package:cata_treco/models/user/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class ColetaServices {
  Coleta? coleta;

  addColeta(Usuario usuario, Coleta coleta) async {
    await _firestore
        .collection("Usuarios")
        .doc(usuario.id)
        .collection("Coletas")
        .add(coleta.toMap());
  }

  Stream<QuerySnapshot> getColetaList(String id) {
    //definimos que tipo de dados pode conter a listagem vindo do firebase
    CollectionReference coletasCollection =
        _firestore.collection('Usuarios').doc(id).collection("Coletas");
    return coletasCollection.snapshots();
  }
}
