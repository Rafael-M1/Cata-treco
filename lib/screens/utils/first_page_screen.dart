import 'package:flutter/material.dart';

class FirstPageScreen extends StatelessWidget {
  const FirstPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
}
