import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key}) : super(key: key);

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  List<String> listTabBar = [
    'Meus Dados',
    'Alterar Meus Dados',
  ];
  User? userLogado = FirebaseAuth.instance.currentUser;
  UsuarioServices usuarioServices = UsuarioServices();
  @override
  Widget build(BuildContext context) {
    Usuario usuarioLogado = Usuario();
    usuarioLogado =
        usuarioServices.getUsuarioLogado(userLogado!.uid, usuarioLogado);
    return DefaultTabController(
      length: listTabBar.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Meu Perfil"),
          bottom: TabBar(
            tabs: listTabBar.map(
              (e) {
                return Tab(
                  text: e.toString(),
                );
              },
            ).toList(),
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
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
                    enabled: false,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      // hintText: "nome",
                      hintText: usuarioLogado.nome,
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const Text(
                    'E-mail',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  const Text(
                    'Telefone',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    enabled: false,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 18.0),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(
                          width: 2,
                          color: Colors.blueGrey,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // tabMeusDados(usuarioLogadoNome!),
            const Center(child: Text('TABBAR2')),
          ],
        ),
      ),
    );
  }

  Widget tabMeusDados(String usuarioLogadoNome) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
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
            enabled: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 18.0),
            decoration: InputDecoration(
              hintText: "nome",
              // hintText: usuarioLogadoNome,
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.blueGrey,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const Text(
            'E-mail',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            enabled: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 18.0),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.blueGrey,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
          const Text(
            'Telefone',
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            enabled: false,
            keyboardType: TextInputType.text,
            style: const TextStyle(fontSize: 18.0),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderSide: const BorderSide(
                  width: 2,
                  color: Colors.blueGrey,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
