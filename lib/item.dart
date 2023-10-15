class Item {
  String nome;
  int quantidade;
  double valorUnitario;

  Item({required this.nome, required this.quantidade, required this.valorUnitario});

  double get valorTotal => quantidade * valorUnitario;
}