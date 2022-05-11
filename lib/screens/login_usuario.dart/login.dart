import 'package:cata_treco/models/user/usuario.dart';
import 'package:cata_treco/models/user/usuario_services.dart';
import 'package:cata_treco/screens/lista_usuario/lista_usuario.dart';
import 'package:cata_treco/screens/utils/second_page_screen.dart';
import 'package:flutter/material.dart';

class UsuarioLoginScreen extends StatefulWidget {
  const UsuarioLoginScreen({Key? key}) : super(key: key);

  @override
  State<UsuarioLoginScreen> createState() => _UnitScreenState();
}

class _UnitScreenState extends State<UsuarioLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  Usuario usuario = Usuario();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'E-mail',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          onSaved: (value) => usuario.email = value,
                          initialValue: usuario.email,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 18.0),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, entre com um e-mail.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.blueGrey,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Senha',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                        const SizedBox(height: 5),
                        TextFormField(
                          onSaved: (value) => usuario.password = value,
                          initialValue: usuario.password,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(fontSize: 18.0),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, entre com uma senha.';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                width: 2,
                                color: Colors.blueGrey,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      UsuarioServices _usuarioServices = UsuarioServices();
                      _usuarioServices.signIn(
                        usuario,
                        onSuccess: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const SecondPageScreen(),
                            ),
                          );
                        },
                        onFail: (e) {
                          Text('$e');
                        },
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
