// ignore_for_file: camel_case_types

import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class tabMeusDadosScreen extends StatefulWidget {
  const tabMeusDadosScreen({Key? key}) : super(key: key);

  @override
  State<tabMeusDadosScreen> createState() => _tabMeusDadosScreenState();
}

class _tabMeusDadosScreenState extends State<tabMeusDadosScreen> {
  User? userLogado = FirebaseAuth.instance.currentUser;
  UsuarioServices usuarioServices = UsuarioServices();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usuario>(
      future: usuarioServices.getUsuarioLogado2(userLogado!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Meus dados",
                        style: TextStyle(
                            fontSize: 27, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Nome: " + snapshot.data!.nome.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Email: " + snapshot.data!.email.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Telefone: " + snapshot.data!.telefone.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          const Divider(thickness: 2),
                          const Text(
                            "Endereço",
                            style: TextStyle(fontSize: 22),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            snapshot.data!.endereco.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Número: " + snapshot.data!.numero.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Complemento: " +
                                snapshot.data!.complemento.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Bairro: " + snapshot.data!.bairro.toString(),
                            style: const TextStyle(fontSize: 20),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "CEP: " + snapshot.data!.cep.toString(),
                            style: const TextStyle(fontSize: 20),
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
}
