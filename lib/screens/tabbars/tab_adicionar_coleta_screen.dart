// ignore_for_file: camel_case_types

import 'package:cata_treco/models/coleta/coleta.dart';
import 'package:cata_treco/models/coleta/coleta_services.dart';
import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class tabAdicionarColetaScreen extends StatefulWidget {
  tabAdicionarColetaScreen({Key? key}) : super(key: key);

  @override
  State<tabAdicionarColetaScreen> createState() =>
      _tabAdicionarColetaScreenState();
}

class _tabAdicionarColetaScreenState extends State<tabAdicionarColetaScreen> {
  User? userLogado = FirebaseAuth.instance.currentUser;
  UsuarioServices usuarioServices = UsuarioServices();
  Usuario usuarioLogado = Usuario();
  Coleta coleta = Coleta();
  String preferenciaColeta = 'm';

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    usuarioLogado = usuarioServices.getUsuarioLogado(userLogado!.uid);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Text(
                  'Descrição do Objeto da Coleta',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  keyboardType: TextInputType.text,
                  style: const TextStyle(fontSize: 18.0),
                  validator: (descricao) {
                    if (descricao == null || descricao.isEmpty) {
                      return 'Por favor, entre com uma descrição do Objeto.';
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
                  onSaved: (descricao) => coleta.descricaoColeta = descricao,
                ),
                const SizedBox(height: 5),
                const Text(
                  'Preferência do período para Coleta:',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
                RadioListTile(
                  title: const Text("Período Matutino"),
                  value: "m",
                  groupValue: preferenciaColeta,
                  onChanged: (value) {
                    setState(() {
                      preferenciaColeta = (value ?? '') as String;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Período Vespertino"),
                  value: "t",
                  groupValue: preferenciaColeta,
                  onChanged: (value) {
                    setState(() {
                      preferenciaColeta = (value ?? '') as String;
                    });
                  },
                ),
                RadioListTile(
                  title: const Text("Ambos"),
                  value: "a",
                  groupValue: preferenciaColeta,
                  onChanged: (value) {
                    setState(() {
                      preferenciaColeta = (value ?? '') as String;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      ColetaServices coletaServices = ColetaServices();
                      coleta.preferenciaColeta = preferenciaColeta;
                      coleta.statusColeta = "A";
                      coletaServices.addColeta(usuarioLogado, coleta);
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Coleta registrada com sucesso."),
                          actions: <Widget>[
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Fechar"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text("Salvar Dados"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
