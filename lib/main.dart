import 'package:cata_treco/screens/cadastro_usuario/cadastro_usuario.dart';
import 'package:cata_treco/screens/home/home_after_login_screen.dart';
import 'package:cata_treco/screens/home/home_screen.dart';
import 'package:cata_treco/screens/login_usuario.dart/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cata-treco',
      // theme: ThemeData.dark(),
      theme: ThemeData(
        //primarySwatch: Colors.green,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 45, 92, 13),
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 45, 92, 13),
          elevation: 10,
          selectedLabelStyle: TextStyle(
            fontSize: 14.0,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.0,
          ),
          //selectedItemColor: Color.fromARGB(255, 65, 200, 25),
          selectedItemColor: Color.fromARGB(255, 255, 255, 255),
          unselectedItemColor: Color.fromARGB(255, 65, 134, 19),
          showUnselectedLabels: true,
        ),
      ),
      initialRoute: '/home',
      routes: {
        '/usuario': (context) => UsuarioRegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const UsuarioLoginScreen(),
      },
    );
  }
}
