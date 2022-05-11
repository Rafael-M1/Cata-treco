import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirstPageScreen extends StatelessWidget {
  const FirstPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: FutureBuilder<Widget>(
                future: _getImage(context, "homeScreen/Icone-home-screen.png"),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.hasData) {
                    return Container(
                      child: snapshot.data,
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
              ),
            ),
            const Padding(
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
            // const Text("O serviço de Cata Treco, realizado pela Secretaria de Serviços Urbanos da Prefeitura de Bertioga, agora" +
            //     " conta com agendamento e pode ser solicitado pelo telefone: (13) 3319-8035, o atendimento funciona de segunda a " +
            //     "sexta-feira, das 8 às 17 horas, e as solicitações são atendidas conforme agenda."),
            // const Text(
            //     "Na data da retirada, é necessário que o munícipe coloque em frente à sua residência o material a ser recolhido, " +
            //         "ou em pontos de coleta estabelecidos, sempre de acordo com o horário em que o caminhão irá passar."),
            // const Text("As equipes de zeladoria percorrem, de segunda a sexta-feira, em horários determinados, em todos os" +
            //     " bairros de Bertioga fazendo a retirada dos materiais conforme a agenda. O serviço tem por " +
            //     "objetivo manter a cidade limpa e organizada, além de auxiliar na limpeza das residências dos " +
            //     "munícipes, a fim de evitar a obstrução de calçadas e vias públicas, e o acúmulo e " +
            //     "descarte indevido de lixo."),
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
}

class FireStorageService extends ChangeNotifier {
  FireStorageService();

  static Future<dynamic> loadImage(BuildContext context, String image) async {
    return await FirebaseStorage.instance.ref().child(image).getDownloadURL();
  }
}
