import 'package:cata_treco/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';

class FirstPageALScreen extends StatelessWidget {
  const FirstPageALScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? userLogado = FirebaseAuth.instance.currentUser;
    UsuarioServices usuarioServices = UsuarioServices();
    Usuario usuarioLogado = usuarioServices.getUsuarioLogado(userLogado!.uid);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cata-Treco'),
        actions: [
          PopupMenuButton<int>(
            onSelected: (index) => onSelected(context, index),
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
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Padding(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Image(
                image: AssetImage('assets/images/Icone-home-screen.png'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "O Cata Treco é um serviço gratuito de coleta de materiais inservíveis, tais como: janelas, portas, " +
                    "móveis velhos, eletrodomesticos, madeiras, entre outros objetos descartáveis de grande porte que não " +
                    "podem ser recolhidos pela coleta seletiva. É importante lembrar que o serviço não contempla retirada de " +
                    "resíduos de construção civil (entulhos).",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 19.0,
                ),
              ),
            ),
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
