import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  String? id;
  String? nome;
  String? email;
  String? password;
  String? confirmPassword;
  String? telefone;
  String? role;
  //Campos do endereco
  //Endereco, numero, Complemento, Bairro, CEP,
  String? endereco;
  String? numero;
  String? complemento;
  String? bairro;
  String? cep;

  Usuario({
    this.id,
    this.nome,
    this.email,
    this.password,
    this.confirmPassword,
    this.telefone,
    this.role,
    this.endereco,
    this.numero,
    this.complemento,
    this.cep,
    this.bairro,
  });
  //Método para converter formato json em objetos
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
        id: map['id'],
        nome: map['nome'],
        email: map['email'],
        password: map['password'],
        confirmPassword: map['confirmPassword'],
        telefone: map['telefone'],
        role: map['role'],
        endereco: map['endereco'],
        numero: map['numero'],
        complemento: map['complemento'],
        cep: map['cep'],
        bairro: map['bairro']);
  }

  //Método para conversão para MAP, para permitir que possamos enviar informações ao Firebase
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'telefone': telefone,
      'role': role,
      'endereco': endereco,
      'numero': numero,
      'complemento': complemento,
      'cep': cep,
      'bairro': bairro,
    };
  }

  Usuario.fromDocument(DocumentSnapshot doc) {
    id = doc.id;
    nome = doc.get('nome') as String;
    email = doc.get('email') as String;
    password = doc.get('password') as String;
    confirmPassword = doc.get('confirmPassword') as String;
    telefone = doc.get('telefone') as String;
    role = doc.get('role') as String;
    endereco = doc.get('endereco') as String;
    numero = doc.get('numero') as String;
    complemento = doc.get('complemento') as String;
    cep = doc.get('cep') as String;
    bairro = doc.get('bairro') as String;
  }
}
