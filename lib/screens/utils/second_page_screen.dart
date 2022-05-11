import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class SecondPageScreen extends StatelessWidget {
  const SecondPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            // _returnImage(context, "homeScreen/Img-second-page.jpg"),
            Text("Página Coleta"),
          ],
        ),
      ),
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

  _returnImage(BuildContext context, String imgString) {
    return FutureBuilder<Widget>(
      //future: _getImage(context, "homeScreen/Img-second-page.jpg"),
      future: _getImage(context, imgString),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: snapshot.data,
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            child: const CircularProgressIndicator(),
          );
        }
        return Container();
      },
    );
  }
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
