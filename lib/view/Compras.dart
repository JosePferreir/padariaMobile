import 'package:flutter/material.dart';

import 'DetalhesCompra.dart';

class Compras extends StatefulWidget {
  const Compras({super.key});

  @override
  State<Compras> createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compras', style: TextStyle(color: Color(0xFFEBEBEB))),
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
                      title: Text('Mataria-Prima'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Data:05/05/2023'),
                          Text('Valor Total: R\$1.800,00'),
                        ],
                      ),
                      trailing: FloatingActionButton(
                        backgroundColor: Color(0xFFEBEBEB),
                        mini: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetalhesCompra(),
                            ),
                          );
                        },
                        child: Icon(
                          Icons.add_circle_outline,
                          color: Colors.black,
                        ),
                        heroTag: null,
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