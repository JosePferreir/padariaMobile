import 'package:flutter/material.dart';

class ResumoCompraProduto extends StatefulWidget {
  const ResumoCompraProduto({super.key});

  @override
  State<ResumoCompraProduto> createState() => _ResumoCompraProdutoState();
}

class _ResumoCompraProdutoState extends State<ResumoCompraProduto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo Compra'),
        backgroundColor: Color(0xFFDB6D12), // Fundo laranja
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Número fictício de itens
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFED9F5F), // Fundo laranja claro
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text('Coca-Cola 600ml'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('N° itens: 200'),
                          Text('Validade:05/05/2023  Valor:R\$120,00'),
                        ],
                      ),
                      trailing: FloatingActionButton(
                        backgroundColor: Color(0xFFEBEBEB),
                        mini: true,
                        onPressed: () {
                          // Função para remover item
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.black,
                        ),
                        heroTag: null,
                      ),
                    ),
                  );
                },
              ),
            ),
            Wrap(
              spacing: 10, // Espaçamento horizontal entre os botões
              runSpacing: 10, // Espaçamento vertical entre as linhas de botões
              alignment: WrapAlignment.center,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Voltar', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    // Função para confirmar
                  },
                  child: Text('Confirmar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}