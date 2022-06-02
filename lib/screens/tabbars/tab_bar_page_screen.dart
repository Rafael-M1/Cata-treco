import 'package:cata_treco/screens/tabbars/tab_adicionar_coleta_screen.dart';
import 'package:cata_treco/screens/tabbars/tab_minhas_coletas.dart';
import 'package:cata_treco/screens/tabbars/tab_minhas_coletas_finalizadas.dart';

import 'package:flutter/material.dart';

import 'package:cata_treco/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';

class UserTabPageScreen extends StatefulWidget {
  const UserTabPageScreen({Key? key}) : super(key: key);

  @override
  State<UserTabPageScreen> createState() => _UserTabPageScreenState();
}

class _UserTabPageScreenState extends State<UserTabPageScreen> {
  List<String> listTabBar = [
    'Registrar Coleta',
    'Minhas Coletas',
    'Coletas Finalizadas'
  ];
  User? userLogado = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    UsuarioServices usuarioServices = UsuarioServices();
    Usuario usuarioLogado = usuarioServices.getUsuarioLogado(userLogado!.uid);

    return DefaultTabController(
      length: listTabBar.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Coletas"),
          bottom: TabBar(
            isScrollable: true,
            tabs: listTabBar.map(
              (e) {
                return Tab(
                  text: e.toString(),
                );
              },
            ).toList(),
          ),
          actions: [
            PopupMenuButton<int>(
              onSelected: (index) => onSelected(context, index),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: const [
                    Text("Menu"),
                    Icon(Icons.more_vert),
                  ],
                ),
              ),
              itemBuilder: (context) => [
                PopupMenuItem(
                  child: Text(
                    "Olá, " + usuarioLogado.nome!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  enabled: false,
                ),
                PopupMenuItem(
                  value: 1,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.settings,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8.0),
                      Text("Perfil"),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: const [
                      Icon(
                        Icons.logout,
                        color: Colors.black,
                      ),
                      SizedBox(width: 8.0),
                      Text("Desconectar"),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        body: TabBarView(
          children: [
            tabAdicionarColetaScreen(),
            const tabMinhasColetasScreen(),
            const tabMinhasColetasFinalizadasScreen(),
          ],
        ),
      ),
    );
  }

  void onSelected(BuildContext context, int index) {
    UsuarioServices _usuarioServices = UsuarioServices();
    switch (index) {
      case 0:
        _usuarioServices.signOut();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
            (route) => false);
        break;
      case 1:
        Navigator.of(context).pushNamed("/profile");
        break;
    }
  }
}
