import 'package:flutter/material.dart';

class SecondPageScreen extends StatelessWidget {
  const SecondPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            Text("Página Coleta"),
          ],
        ),
      ),
    );
  }
}
