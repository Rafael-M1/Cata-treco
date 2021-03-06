import 'package:flutter/material.dart';

import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';

class UsuarioRegisterScreen extends StatelessWidget {
  UsuarioRegisterScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Usuario usuario = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _campoNome(),
                    const SizedBox(height: 10),
                    _campoEmail(),
                    const SizedBox(height: 10),
                    _campoTelefone(),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.black),
                    _campoEndereco(),
                    const SizedBox(height: 10),
                    _campoNumero(),
                    const SizedBox(height: 10),
                    _campoComplemento(),
                    const SizedBox(height: 10),
                    _campoBairro(),
                    const SizedBox(height: 10),
                    _campoCEP(),
                    const SizedBox(height: 10),
                    const Divider(thickness: 2, color: Colors.black),
                    _campoPassword(),
                    const SizedBox(height: 10),
                    _campoConfirmPassword(),
                    const SizedBox(height: 15),
                  ],
                ),
                _btnSalvarDados(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _btnSalvarDados(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          if (usuario.password != usuario.confirmPassword) {
            const ScaffoldMessenger(
              child: SnackBar(
                content: Text(
                  'Senhas n??o coincidem.',
                  style: TextStyle(fontSize: 18.0),
                ),
                backgroundColor: Colors.red,
              ),
            );
            return;
          }
          UsuarioServices usuarioServices = UsuarioServices();
          usuarioServices.signUp(
            usuario,
            onSuccess: () {
              Navigator.of(context).pop();
            },
            onFail: (e) {
              ScaffoldMessenger(
                child: SnackBar(
                  content: Text(
                    'Falha ao registrar Usu??rio: $e',
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
      child: const Text("Salvar Dados"),
    );
  }

  Column _campoNome() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Nome',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (nome) {
            if (nome == null || nome.isEmpty) {
              return 'Por favor, entre com um nome.';
            } else if (nome.trim().split(' ').length <= 1) {
              return 'Preencha seu nome completo';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (nome) => usuario.nome = nome,
        ),
      ],
    );
  }

  Column _campoEmail() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'E-mail',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: const TextStyle(fontSize: 18.0),
          validator: (email) {
            if (email == null || email.isEmpty) {
              return 'Por favor, entre com um e-mail.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (email) => usuario.email = email,
        ),
      ],
    );
  }

  Column _campoTelefone() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Telefone',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (telefone) {
            if (telefone == null || telefone.isEmpty) {
              return 'Por favor, entre com um telefone.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (telefone) => usuario.telefone = telefone,
        ),
      ],
    );
  }

  Column _campoPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Senha',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: true,
          style: const TextStyle(fontSize: 18.0),
          validator: (password) {
            if (password == null || password.isEmpty) {
              return 'Por favor, entre com uma senha.';
            } else if (password.length < 6) {
              return 'Senha deve ter ao menos 6 caracteres.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (password) => usuario.password = password,
        ),
      ],
    );
  }

  Column _campoConfirmPassword() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Repita a Senha',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          obscureText: true,
          style: const TextStyle(fontSize: 18.0),
          validator: (confirmPassword) {
            if (confirmPassword == null || confirmPassword.isEmpty) {
              return 'Por favor, entre com uma senha.';
            } else if (confirmPassword.length < 6) {
              return 'Senha deve ter ao menos 6 caracteres.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (confirmPassword) =>
              usuario.confirmPassword = confirmPassword,
        ),
      ],
    );
  }

  Column _campoEndereco() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Endere??o',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: const TextStyle(fontSize: 18.0),
          validator: (endereco) {
            if (endereco == null || endereco.isEmpty) {
              return 'Por favor, entre com um endere??o.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (endereco) => usuario.endereco = endereco,
        ),
      ],
    );
  }

  Column _campoNumero() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'N??mero',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: const TextStyle(fontSize: 18.0),
          validator: (numero) {
            if (numero == null || numero.isEmpty) {
              return 'Por favor, entre com um n??mero de endere??o.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (numero) => usuario.numero = numero,
        ),
      ],
    );
  }

  Column _campoComplemento() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Complemento',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: const TextStyle(fontSize: 18.0),
          validator: (complemento) {
            if (complemento == null || complemento.isEmpty) {
              return 'Por favor, entre com o complemento.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (complemento) => usuario.complemento = complemento,
        ),
      ],
    );
  }

  Column _campoBairro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Bairro',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: const TextStyle(fontSize: 18.0),
          validator: (bairro) {
            if (bairro == null || bairro.isEmpty) {
              return 'Por favor, entre com o nome do Bairro.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (bairro) => usuario.bairro = bairro,
        ),
      ],
    );
  }

  Column _campoCEP() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'CEP',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          style: const TextStyle(fontSize: 18.0),
          validator: (cep) {
            if (cep == null || cep.isEmpty) {
              return 'Por favor, entre com o n??mero do CEP.';
            }
            return null;
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 2,
                color: Colors.blueGrey,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onSaved: (cep) => usuario.cep = cep,
        ),
      ],
    );
  }
}
