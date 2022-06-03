import 'package:cata_treco/models/user/usuario_services.dart';
import 'package:cata_treco/screens/administracao/agendar_coletas/lista_coleta_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Objeto para apresentação dos dados existentes
class AgendarColetasScreen extends StatelessWidget {
  const AgendarColetasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UsuarioServices usuarioService = UsuarioServices();
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        //O stream é a propriedade que vai receber o fluxo de dados vindo do Firebase
        stream: usuarioService.getUsuarioList(),

        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data != null) {
            //precisamos obter uma referencia da listagem
            final List<DocumentSnapshot> docSnap = snapshot.data!.docs;
            return Scaffold(
              backgroundColor: Colors.grey.shade300,
              appBar: AppBar(
                title: const Text("Agendar Coleta"),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(docSnap[index].get('nome')),
                                Text(docSnap[index].get('email')),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.search),
                              onPressed: () {
                                print("Botao - " + docSnap[index].get('id'));
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        listaColetasAdministracaoScreen(
                                      usuarioId: docSnap[index].get('id'),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        //subtitle: Text(docSnap[index].get('email').toString()),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    );
                  }, //Propriedade para construir o widget que vai apresentar os dados
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ), //separador, mostra uma separação na listagem
                  itemCount: docSnap
                      .length //informa quantos items tem na listagem do stream
                  ),
            );
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.data == null) {
            return Center(
              child: ListView(
                children: const [
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text("Não há dados disponíveis"),
                  )
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
