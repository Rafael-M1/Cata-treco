import 'package:flutter/material.dart';
import 'package:cata_treco/screens/usuario_dashboard/items_dashboard.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UsuarioCardScreen extends StatelessWidget {
  const UsuarioCardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ItemDashboard item1 = ItemDashboard("Cadastro", "icone-login.png");
    ItemDashboard item2 = ItemDashboard("Login", "icone-login.png");
    // ItemDashboard item3 = ItemDashboard("Lista Usuários", "icone-login.png");

    List<ItemDashboard> myList = [
      item1,
      item2,
      // item3,
    ];
    return Padding(
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
                  _returnImage(context, "homeScreen/cardItemImg.jpg"),
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
    );
  }

  _returnImage(BuildContext context, String imgName) {
    return FutureBuilder<Widget>(
      future: _getImage(
        context,
        imgName,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 3,
              child: snapshot.data,
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            height: MediaQuery.of(context).size.width / 3,
            child: const CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }

  Future<Widget> _getImage(BuildContext context, String imageName) async {
    late Image image;
    await FireStorageService.loadImage(context, imageName).then((value) {
      image = Image.network(
        value.toString(),
        fit: BoxFit.scaleDown,
      );
    });
    return image;
  }

  callUnit(BuildContext context, int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed("/usuario");
    }
    if (index == 1) {
      Navigator.of(context).pushNamed("/login");
    }
    // if (index == 2) {
    //   Navigator.of(context).pushNamed("/lista_usuarios");
    // }
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
