class Usuario {
  String? id;
  String? nome;
  String? email;
  String? password;
  String? confirmPassword;
  String? telefone;

  Usuario({
    this.id,
    this.nome,
    this.email,
    this.password,
    this.confirmPassword,
    this.telefone,
  });
  //Método para converter formato json em objetos
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
        id: map['id'],
        nome: map['nome'],
        email: map['email'],
        password: map['password'],
        confirmPassword: map['confirmPassword'],
        telefone: map['telefone']);
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
    };
  }
}
