import 'package:flutter/material.dart';
import 'item.dart';

class ListPage extends StatelessWidget {
  final List<Item> itens;

  ListPage({required this.itens});

  @override
  Widget build(BuildContext context) {
    double totalPedido = itens.fold(0, (total, item) => total + item.valorTotal);

    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Itens'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                itemCount: itens.length,
                itemBuilder: (context, index) {
                  Item item = itens[index];
                  return ListTile(
                    title: Text('${item.nome} (${item.quantidade}x)'),
                    subtitle: Text('Valor unitário: R\$ ${item.valorUnitario.toStringAsFixed(2)}'),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 24,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Item "${item.nome}" excluído.'),
                            duration: Duration(seconds: 3),
                          ),
                        );
                        Navigator.pop(context, index);
                      },
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 30),
            Text(
              'Valor total: R\$ ${totalPedido.toStringAsFixed(2)}',
              style: TextStyle(
                fontSize: 28, // Tamanho da fonte
                fontWeight: FontWeight.bold, // Negrito
                color: Colors.blue, // Cor do texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}
