import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';
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
  late bool isAdmin;
  List<BottomNavigationBarItem> items = <BottomNavigationBarItem>[
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Início',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: 'Coleta',
    ),
    // const BottomNavigationBarItem(
    //   icon: Icon(Icons.category),
    //   label: 'Administração',
    // ),
  ];

  @override
  void initState() {
    // _isUserAdminMethod();
    listPage.add(const FirstPageALScreen());
    listPage.add(const UserTabPageScreen());
    // if (isAdmin) {
    //   listPage.add(const FirstPageALScreen());
    // } else {
    //   items.removeLast();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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

  void _isUserAdminMethod() async {
    User? userLogado = FirebaseAuth.instance.currentUser;
    UsuarioServices usuarioServices = UsuarioServices();
    Usuario usuario = await usuarioServices.getUsuarioLogado2(userLogado!.uid);
    if (usuario.role == "n") {
      setState(() {
        // items.removeLast();
        print("Usuario não é admin");
        isAdmin = false;
      });
    } else if (usuario.role == "a") {
      setState(() {
        // listPage.add(const FirstPageALScreen());
        print("Usuario é admin");
        isAdmin = true;
      });
    }
  }
}
