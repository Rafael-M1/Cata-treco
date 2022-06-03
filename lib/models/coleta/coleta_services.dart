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
  updateColeta(String usuarioId, Coleta coleta, String coletaId) async {
    await _firestore
        .collection("Usuarios")
        .doc(usuarioId)
        .collection("Coletas")
        .doc(coletaId)
        .set(coleta.toMap());
  }

  removeColeta(String usuarioId, String coletaId) async {
    await _firestore
        .collection("Usuarios")
        .doc(usuarioId)
        .collection("Coletas")
        .doc(coletaId).delete();
  }

  Stream<QuerySnapshot> getColetaList(String id) {
    return _firestore
        .collection('Usuarios')
        .doc(id)
        .collection("Coletas")
        //.where("statusColeta", isNotEqualTo: "f")
        .snapshots();
  }

  Stream<QuerySnapshot> getColetaFinalizadaList(String id) {
    return _firestore
        .collection('Usuarios')
        .doc(id)
        .collection("Coletas")
        .where("statusColeta", isEqualTo: "f")
        .snapshots();
  }

  Stream<QuerySnapshot> getUsuarioColetaNaoFinalizadaList() {
    return _firestore
        .collection('Usuarios')
        .doc()
        .collection('Coletas')
        .where("statusColeta", isNotEqualTo: "f")
        .snapshots();
  }
}
