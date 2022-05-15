import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';
import 'package:cata_treco/screens/home/home_screen.dart';
import 'package:cata_treco/screens/utils/first_page_screen.dart';
import 'package:cata_treco/screens/utils/second_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeAfterLoginScreen extends StatefulWidget {
  const HomeAfterLoginScreen({Key? key}) : super(key: key);

  @override
  State<HomeAfterLoginScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeAfterLoginScreen> {
  int _selectedPage = 0;
  List<Widget> listPage = [];
  User? usuarioLogado = FirebaseAuth.instance.currentUser;

  _HomeScreenState();

  @override
  void initState() {
    listPage.add(const FirstPageScreen());
    listPage.add(SecondPageScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cata-Treco'),
        actions: [
          PopupMenuButton<int>(
            onSelected: (index) => onSelected(context, index),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text(
                  "Olá, " + usuarioLogado!.email.toString().split('@')[0],
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                enabled: false,
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
      body: IndexedStack(
        index: _selectedPage,
        children: listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Coleta',
          ),
        ],
        currentIndex: _selectedPage,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
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
    }
  }
}
