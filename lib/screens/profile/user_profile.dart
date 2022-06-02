import 'package:cata_treco/screens/profile/tab_alterar_meus_dados.dart';
import 'package:cata_treco/screens/profile/tab_meus_dados.dart';
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
  @override
  Widget build(BuildContext context) {
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
        body: const TabBarView(
          children: [
            tabMeusDadosScreen(),
            tabAlterarMeusDadosScreen(),
          ],
        ),
      ),
    );
  }
}
