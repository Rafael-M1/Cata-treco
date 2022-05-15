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
        .doc(usuario.email)
        .collection("Coletas")
        .add(coleta.toMap());
    // .document().add(
    //       usuario
    //           .toMap(), //toMap faz a conversão do objeto em um MAP para ser persistido no Firebase, enviamos dados em formato Json
    //     );
  }

  // //Criar método para obter os dados do FIREBASE
  // //Devemos definir o tipo de retorno de acordo com quem vai receber o resultado
  // Stream<QuerySnapshot> getUsuarioList() {
  //   //definimos que tipo de dados pode conter a listagem vindo do firebase
  //   CollectionReference unitCollection = _firestore.collection('Usuarios');
  //   return unitCollection.snapshots();
  // }
}
