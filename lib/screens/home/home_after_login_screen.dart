import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';
import 'package:cata_treco/screens/administracao/administracao_dashboard/administracao_screen.dart';
import 'package:cata_treco/screens/tabbars/tab_bar_page_screen.dart';
import 'package:cata_treco/screens/utils/first_page_AL_screen.dart';
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
  bool isAdmin = false;
  List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Início',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Coleta',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.admin_panel_settings),
      label: 'Administração',
    )
  ];

  @override
  void initState() {
    listPage.add(const FirstPageALScreen());
    listPage.add(const UserTabPageScreen());
    listPage.add(const AdministracaoCardScreen());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _isUserAdminMethod();
    return Scaffold(
      body: IndexedStack(
        index: _selectedPage,
        children: listPage,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
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

  Future<void> _isUserAdminMethod() async {
    User? userLogado = FirebaseAuth.instance.currentUser;
    UsuarioServices usuarioServices = UsuarioServices();
    Usuario usuario = await usuarioServices.getUsuarioLogado2(userLogado!.uid);
    if (usuario.role == "n") {
      setState(() {
        listPage.removeAt(2);
        items.removeAt(2);
      });
    }
  }
}
