import 'package:cloud_firestore/cloud_firestore.dart';

class Coleta {
  String? dataColeta;
  String? descricaoColeta;
  String? statusColeta;
  String? preferenciaColeta;

  Coleta({
    this.dataColeta,
    this.descricaoColeta,
    this.statusColeta,
    this.preferenciaColeta,
  });
  //Método para converter formato json em objetos
  factory Coleta.fromMap(Map<String, dynamic> map) {
    return Coleta(
      dataColeta: map['dataColeta'],
      descricaoColeta: map['descricaoColeta'],
      statusColeta: map['statusColeta'],
      preferenciaColeta: map['preferenciaColeta'],
    );
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'dataColeta': dataColeta,
      'descricaoColeta': descricaoColeta,
      'statusColeta': statusColeta,
      'preferenciaColeta': preferenciaColeta,
    };
  }

  Coleta.fromDocument(DocumentSnapshot doc) {
    //id = doc.id;
    dataColeta = doc.get('dataColeta') as String;
    descricaoColeta = doc.get('descricaoColeta') as String;
    statusColeta = doc.get('statusColeta') as String;
    preferenciaColeta = doc.get('preferenciaColeta') as String;
  }
}
