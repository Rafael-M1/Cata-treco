import 'package:cata_treco/models/coleta/coleta.dart';
import 'package:cata_treco/models/user/usuario.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
    return _firestore
        .collection('Usuarios')
        .doc(id)
        .collection("Coletas")
        .where("statusColeta", isNotEqualTo: "f")
        .snapshots();
  }

  Stream<QuerySnapshot> getColetaFinalizadaList(String id) {
    //definimos que tipo de dados pode conter a listagem vindo do firebase
    return _firestore
        .collection('Usuarios')
        .doc(id)
        .collection("Coletas")
        .where("statusColeta", isEqualTo: "f")
        .snapshots();
  }
  // Stream<QuerySnapshot> getUsuarioColetaFinalizadaList(String id) {
  //   //definimos que tipo de dados pode conter a listagem vindo do firebase
  //   return _firestore.collection('Usuarios').
        
  //       .get()
  //       .then((querySnapshot) => querySnapshot.docs.map((doc) => doc.reference.collection('Coletas')));
  // }
}
