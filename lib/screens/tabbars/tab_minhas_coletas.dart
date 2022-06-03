// ignore_for_file: camel_case_types

import 'package:cata_treco/models/coleta/coleta_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class tabMinhasColetasScreen extends StatefulWidget {
  const tabMinhasColetasScreen({Key? key}) : super(key: key);

  @override
  State<tabMinhasColetasScreen> createState() => _tabMinhasColetasScreenState();
}

class _tabMinhasColetasScreenState extends State<tabMinhasColetasScreen> {
  User? userLogado = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    ColetaServices coletaServices = ColetaServices();
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        //O stream é a propriedade que vai receber o fluxo de dados vindo do Firebase
        stream: coletaServices.getColetaList(userLogado!.uid),
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
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          "Objeto: " + docSnap[index].get('descricaoColeta')),
                      subtitle: Text(
                        (docSnap[index].get('statusColeta') == "a"
                                ? "Aguardando Agendamento"
                                : (docSnap[index].get('statusColeta') == "g")
                                    ? "Agendado"
                                    : "Coleta Finalizada") +
                            " --- " +
                            (docSnap[index].get('preferenciaColeta') == "m"
                                ? "Preferência: Manhã"
                                : (docSnap[index].get('preferenciaColeta') ==
                                        "t")
                                    ? "Preferência: Tarde"
                                    : "Preferência: Ambos") +
                            " --- " +
                            (docSnap[index].get('dataColeta') == null
                                ? "Coleta ainda não agendada"
                                : "teste"),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    );
                  }, //Propriedade para construir o widget que vai apresentar os dados
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ), //separador, mostra uma separação na listagem
                  itemCount: docSnap.length
                  //informa quantos items tem na listagem do stream
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
