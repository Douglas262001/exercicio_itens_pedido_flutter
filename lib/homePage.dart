import 'package:flutter/material.dart';
import 'item.dart';
import 'listPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nomeController = TextEditingController();
  TextEditingController quantidadeController = TextEditingController();
  TextEditingController valorController = TextEditingController();
  List<Item> itens = [];

  String? validateNome(String? value) {
    if (value == null || value.isEmpty) {
      return 'O nome do item é obrigatório';
    }
    return null;
  }

  String? validateQuantidade(String? value) {
    if (value == null || value.isEmpty) {
      return 'A quantidade é obrigatória';
    }
    int? quantidade = int.tryParse(value);
    if (quantidade == null || quantidade <= 0) {
      return 'A quantidade deve ser um número inteiro positivo';
    }
    return null;
  }

  String? validateValor(String? value) {
    if (value == null || value.isEmpty) {
      return 'O valor unitário é obrigatório';
    }
    double? valor = double.tryParse(value);
    if (valor == null || valor <= 0.0) {
      return 'O valor unitário deve ser um número positivo com as casas decimais separadas por ponto "."';
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Itens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: nomeController,
                decoration: InputDecoration(labelText: 'Nome do Item'),
                validator: validateNome,
              ),
              TextFormField(
                controller: quantidadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Quantidade'),
                validator: validateQuantidade,
              ),
              TextFormField(
                controller: valorController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Valor Unitário'),
                validator: validateValor,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    String nome = nomeController.text;
                    int quantidade = int.parse(quantidadeController.text);
                    double valor = double.parse(valorController.text);

                    setState(() {
                      itens.add(Item(
                          nome: nome,
                          quantidade: quantidade,
                          valorUnitario: valor));
                      nomeController.clear();
                      quantidadeController.clear();
                      valorController.clear();
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Produto cadastrado com sucesso!'),
                        duration: Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Text('Cadastrar'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListPage(itens: itens),
                    ),
                  );

                  if (result != null) {
                    setState(() {
                      itens.removeAt(result);
                    });
                  }
                },
                child: Text('Visualizar Lista'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
