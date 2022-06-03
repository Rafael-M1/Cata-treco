import 'package:cata_treco/models/coleta/coleta.dart';
import 'package:cata_treco/models/coleta/coleta_services.dart';
import 'package:cata_treco/screens/administracao/agendar_coletas/atualizar_coleta_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Objeto para apresentação dos dados existentes
class listaColetasAdministracaoScreen extends StatelessWidget {
  const listaColetasAdministracaoScreen({
    Key? key,
    required this.usuarioId,
  }) : super(key: key);
  final String usuarioId;

  @override
  Widget build(BuildContext context) {
    ColetaServices coletaServices = ColetaServices();
    return Material(
      child: StreamBuilder<QuerySnapshot>(
        //O stream é a propriedade que vai receber o fluxo de dados vindo do Firebase
        stream: coletaServices.getColetaList(usuarioId),
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
                title: const Text("Lista de Coletas do Usuário"),
              ),
              body: ListView.separated(
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Objeto: " +
                                docSnap[index].get('descricaoColeta')),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    Coleta coleta = Coleta();
                                    coleta.descricaoColeta = docSnap[index].get('descricaoColeta');
                                    coleta.preferenciaColeta = docSnap[index].get('preferenciaColeta');
                                    coleta.statusColeta = docSnap[index].get('statusColeta');
                                    coleta.dataColeta = docSnap[index].get('dataColeta');
                                    
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => atualizarColetaScreen(
                                          preferenciaColeta: coleta.preferenciaColeta.toString(),
                                          dataColeta: coleta.dataColeta.toString(),
                                          descricaoColeta: coleta.descricaoColeta.toString(),
                                          statusColeta: coleta.statusColeta.toString(),
                                          usuarioId: usuarioId.toString(),
                                          coletaId: docSnap[index].id,
                                          
                                          //preferenciaColeta: coleta.preferenciaColeta.toString(),
                                        )
                                      ),
                                    );
                                  },
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    size: 30,
                                  ),
                                  onPressed: () {
                                    coletaServices.removeColeta(usuarioId, docSnap[index].id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
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
                              (docSnap[index].get('dataColeta') ?? "Coleta ainda não agendada"),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
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
