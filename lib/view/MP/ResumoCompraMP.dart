import 'package:flutter/material.dart';

class ResumoCompraMP extends StatefulWidget {
  const ResumoCompraMP({super.key});

  @override
  State<ResumoCompraMP> createState() => _ResumoCompraMPState();
}

class _ResumoCompraMPState extends State<ResumoCompraMP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo Compra'),
        backgroundColor: Color(0xFF118383),
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
                    color: Color(0xFF9AD0D0),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text('Farinha'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('N° itens: 50  Uni:Kg'),
                          Text('Qtd/item:5'),
                          Text('Validade:05/05/2023  Valor:R\$13,00'),
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