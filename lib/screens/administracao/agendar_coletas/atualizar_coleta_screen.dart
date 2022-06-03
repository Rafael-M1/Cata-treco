// ignore_for_file: camel_case_types

import 'package:cata_treco/models/coleta/coleta.dart';
import 'package:cata_treco/models/coleta/coleta_services.dart';
import 'package:flutter/material.dart';

class atualizarColetaScreen extends StatefulWidget {
  atualizarColetaScreen({
    Key? key,
    required this.preferenciaColeta,
    required this.statusColeta,
    required this.dataColeta,
    required this.descricaoColeta,
    required this.usuarioId,
    required this.coletaId,
  }) : super(key: key);
  String preferenciaColeta;
  String statusColeta;
  String descricaoColeta;
  String dataColeta;
  String usuarioId;
  String coletaId;

  @override
  State<atualizarColetaScreen> createState() => _atualizarColetaScreenState();
}

class _atualizarColetaScreenState extends State<atualizarColetaScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Coleta coleta = Coleta();
    
  @override
  void initState() {
    coleta.preferenciaColeta = widget.preferenciaColeta;
    coleta.dataColeta = widget.dataColeta;
    coleta.descricaoColeta = widget.descricaoColeta;
    coleta.statusColeta = widget.statusColeta;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(title: const Text("Atualizar Dados"),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Column(
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children:  [
                        _campoDescricaoColeta(coleta),
                        const SizedBox(height: 10),
                        _campoPreferenciaColeta(coleta),
                        const SizedBox(height: 10),
                        _campoStatusColeta(coleta),
                        const SizedBox(height: 10),
                        _campoDataColeta(coleta),
                        const SizedBox(height: 10),
                        _btnSalvarDados(context, coleta, widget.usuarioId.toString(), widget.coletaId.toString()),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _campoDescricaoColeta(Coleta coleta) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Descrição do Objeto da Coleta',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: coleta.descricaoColeta,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (descricaoColeta) {
            if (descricaoColeta == null || descricaoColeta.isEmpty) {
              return 'Por favor, entre com um nome.';
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
          onSaved: (descricaoColeta) => coleta.descricaoColeta = descricaoColeta,
        ),
      ],
    );
  }

  _campoPreferenciaColeta(Coleta coleta) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Preferência do período para Coleta:',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        RadioListTile(
          title: const Text("Período Matutino"),
          value: "m",
          groupValue: coleta.preferenciaColeta,
          onChanged: (value) { 
            setState(() {
              coleta.preferenciaColeta = (value ?? '') as String;
            });
          },
        ),
        RadioListTile(
          title: const Text("Período Vespertino"),
          value: "t",
          groupValue: coleta.preferenciaColeta,
          onChanged: (value) {
            setState(() {
              coleta.preferenciaColeta = (value ?? '') as String;
            });
          },
        ),
        RadioListTile(
          title: const Text("Ambos"),
          value: "a",
          groupValue: coleta.preferenciaColeta,
          onChanged: (value) {
            setState(() {
              coleta.preferenciaColeta = (value ?? '') as String;
            });
          },
        )
      ],
    );
  }
  _campoStatusColeta(Coleta coleta) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Status da Coleta:',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        RadioListTile(
          title: const Text("Aguardando"),
          value: "a",
          groupValue: coleta.statusColeta,
          onChanged: (value) { 
            setState(() {
              coleta.statusColeta = (value ?? '') as String;
            });
          },
        ),
        RadioListTile(
          title: const Text("Agendado"),
          value: "g",
          groupValue: coleta.statusColeta,
          onChanged: (value) {
            setState(() {
              coleta.statusColeta = (value ?? '') as String;
            });
          },
        ),
        RadioListTile(
          title: const Text("Finalizado"),
          value: "f",
          groupValue: coleta.statusColeta,
          onChanged: (value) {
            setState(() {
              coleta.statusColeta = (value ?? '') as String;
            });
          },
        )
      ],
    );
  }
  Column _campoDataColeta(Coleta coleta) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Data da Coleta',
          style: TextStyle(
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          initialValue: coleta.dataColeta.toString() == "null" ? "" : coleta.dataColeta.toString(),
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 18.0),
          validator: (dataColeta) {
            if (dataColeta == null || dataColeta.isEmpty) {
              return 'Por favor, entre com uma Data de Coleta';
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
          onSaved: (dataColeta) => coleta.dataColeta = dataColeta,
        ),
      ],
    );
  }
  _btnSalvarDados(context, Coleta coleta, String usuarioId, String coletaId){
    return ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      ColetaServices coletaServices = ColetaServices();
                      coletaServices.updateColeta(usuarioId, coleta, coletaId);
                      showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text("Coleta alterada com sucesso."),
                          actions: <Widget>[
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: const Text("Fechar"),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: const Text("Salvar Dados"),
                );
  }
}
