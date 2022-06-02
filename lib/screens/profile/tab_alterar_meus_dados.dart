// ignore_for_file: camel_case_types

import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class tabAlterarMeusDadosScreen extends StatefulWidget {
  const tabAlterarMeusDadosScreen({Key? key}) : super(key: key);

  @override
  State<tabAlterarMeusDadosScreen> createState() =>
      _tabAlterarMeusDadosScreenState();
}

class _tabAlterarMeusDadosScreenState extends State<tabAlterarMeusDadosScreen> {
  User? userLogado = FirebaseAuth.instance.currentUser;
  UsuarioServices usuarioServices = UsuarioServices();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usuario>(
      future: usuarioServices.getUsuarioLogado2(userLogado!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Usuario? usuarioLogado = snapshot.data;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Alterar dados",
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Column(
                            //crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _campoNome(usuarioLogado!),
                              const SizedBox(height: 10),
                              _campoTelefone(usuarioLogado),
                              const SizedBox(height: 10),
                              const Divider(thickness: 2),
                              _campoEndereco(usuarioLogado),
                              const SizedBox(height: 10),
                              _campoNumero(usuarioLogado),
                              const SizedBox(height: 10),
                              _campoComplemento(usuarioLogado),
                              const SizedBox(height: 10),
                              _campoBairro(usuarioLogado),
                              const SizedBox(height: 10),
                              _campoCEP(usuarioLogado),
                              const SizedBox(height: 10),
                              _btnSalvarDados(context, usuarioLogado),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return const Center(
          heightFactor: 14,
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Column _campoNome(Usuario usuario) {
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
          initialValue: usuario.nome,
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

  Column _campoTelefone(Usuario usuario) {
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
          initialValue: usuario.telefone,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (telefone) {
            if (telefone == null || telefone.isEmpty) {
              return 'Por favor, entre com um telefone.';
            } else if (telefone.trim().length <= 8) {
              return 'Preencha seu telefone completo';
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

  Column _campoEndereco(Usuario usuario) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Endereço',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: usuario.endereco,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (endereco) {
            if (endereco == null || endereco.isEmpty) {
              return 'Por favor, entre com um Endereço.';
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

  Column _campoNumero(Usuario usuario) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Número',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: usuario.numero,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (numero) {
            if (numero == null || numero.isEmpty) {
              return 'Por favor, entre com um Número de Endereço.';
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

  Column _campoComplemento(Usuario usuario) {
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
          initialValue: usuario.complemento,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (complemento) {
            if (complemento == null || complemento.isEmpty) {
              return 'Por favor, entre com um Complemento do Endereço.';
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

  Column _campoBairro(Usuario usuario) {
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
          initialValue: usuario.bairro,
          keyboardType: TextInputType.text,
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

  Column _campoCEP(Usuario usuario) {
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
          initialValue: usuario.cep,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (cep) {
            if (cep == null || cep.isEmpty) {
              return 'Por favor, entre com um CEP.';
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

  _btnSalvarDados(BuildContext context, Usuario usuario) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          _formKey.currentState!.save();
          usuarioServices.addUsuario(usuario, userLogado!.uid);
        }
      },
      child: const Text("Salvar Dados"),
    );
  }
}
