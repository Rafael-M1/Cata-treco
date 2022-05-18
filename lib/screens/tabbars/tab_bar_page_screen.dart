import 'package:cata_treco/models/coleta/coleta.dart';
import 'package:cata_treco/models/coleta/coleta_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> listTabBar = [
    'Adicionar Coleta',
    'Minhas Coletas',
    //'Coletas Finalizadas'
  ];

  @override
  Widget build(BuildContext context) {
    User? userLogado = FirebaseAuth.instance.currentUser;
    UsuarioServices usuarioServices = UsuarioServices();
    Usuario usuarioLogado = Usuario();
    usuarioLogado =
        usuarioServices.getUsuarioLogado(userLogado!.uid, usuarioLogado);
    ColetaServices coletaServices = ColetaServices();

    final Coleta coleta = Coleta();
    return DefaultTabController(
      length: listTabBar.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Coletas"),
          bottom: TabBar(
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
            tabAdicionarColeta(usuarioLogado, coleta),
            tabMinhasColetas(usuarioLogado, coletaServices),
            //const Center(child: Text('TABBAR3')),
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

  Widget tabAdicionarColeta(Usuario usuarioLogado, Coleta coleta) {
    //dataColeta descricaoColeta statusColeta;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
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
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();

                    ColetaServices coletaServices = ColetaServices();
                    coleta.statusColeta = "A";
                    coletaServices.addColeta(usuarioLogado, coleta);
                  }
                },
                child: const Text("Salvar Dados"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  tabMinhasColetas(Usuario usuarioLogado, ColetaServices coletaServices) {
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        //O stream é a propriedade que vai receber o fluxo de dados vindo do Firebase
        stream: coletaServices.getColetaList(usuarioLogado),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            //precisamos obter uma referencia da listagem
            final List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return Scaffold(
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title:
                          Text(docSnap[index].get('descricaoColeta') + "teste"),
                      subtitle: Text(docSnap[index].get('statusColeta')),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    );
                  }, //Propriedade para construir o widget que vai apresentar os dados
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ), //separador, mostra uma separação na listagem
                  itemCount: docSnap
                      .length //informa quantos items tem na listagem do stream
                  ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return Center(
              child: ListView(
                children: const [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text("Não há dados disponíveis"),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
