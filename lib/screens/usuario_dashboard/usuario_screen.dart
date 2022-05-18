import 'package:flutter/material.dart';
import 'package:cata_treco/screens/usuario_dashboard/items_dashboard.dart';

class UsuarioCardScreen extends StatelessWidget {
  const UsuarioCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemDashboard item1 = ItemDashboard("Cadastro", "icone-login.png");
    ItemDashboard item2 = ItemDashboard("Login", "icone-login.png");

    List<ItemDashboard> myList = [
      item1,
      item2,
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cata-Treco'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: ListView.builder(
          itemCount: myList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () => callUnit(context, index),
              child: Card(
                elevation: 20,
                color: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(5.0),
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: Text(
                        myList.elementAt(index).title,
                        style: const TextStyle(
                          fontSize: 38.0,
                          color: Colors.white,
                          backgroundColor: Colors.teal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  callUnit(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed("/usuario");
    }
    if (index == 1) {
      Navigator.of(context).pushNamed("/login");
    }
  }
}
