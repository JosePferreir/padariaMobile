import 'package:flutter/material.dart';

class DetalhesCompra extends StatefulWidget {
  const DetalhesCompra({super.key});

  @override
  State<DetalhesCompra> createState() => _DetalhesCompraState();
}

class _DetalhesCompraState extends State<DetalhesCompra> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes Compra'),
        backgroundColor: Color(0xFF467919), // Fundo verde
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Buscar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Número fictício de itens
                itemBuilder: (context, index) {
                  return Card(
                    color: Color(0xFFAACE8A), // Fundo verde claro
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text('Farinha'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('N° itens: 50  Uni:Kg  Qtd/item:5'),
                          Text('Validade:05/05/2023  Valor:R\$13,00'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}