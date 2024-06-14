import 'package:flutter/material.dart';
import 'package:padaria_mobile/view/MP/CompraMP.dart';
import 'package:padaria_mobile/view/MP/DarBaixaMP.dart';
import 'package:padaria_mobile/view/MP/EditarEstoqueMP.dart';

class EstoqueMP extends StatefulWidget {
  const EstoqueMP({super.key});

  @override
  State<EstoqueMP> createState() => _EstoqueMPState();
}

class _EstoqueMPState extends State<EstoqueMP> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque Matéria Prima', style: TextStyle(color: Color(0xFFEBEBEB))),
        backgroundColor: Color(0xFF118383),
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
                    color: Color(0xFF9AD0D0),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text('Farinha'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('N° itens: 50  Uni:Kg'),
                          Text("Qtd/item:5"),
                          Text('Validade:05/05/2023  Total:250 Kg'),
                        ],
                      ),
                      trailing: FloatingActionButton(
                        backgroundColor: Color(0xFFEBEBEB),
                        mini: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarEstoqueMP(),
                            ),
                          );
                        },
                        child: Icon(
                            Icons.edit_outlined,
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
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
          backgroundColor: Color(0xFF118383),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompraMP(),
                ),
              );
            },
            child: Icon(Icons.add, color: Color(0xFFEBEBEB)),
            heroTag: null,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
          backgroundColor: Color(0xFF118383),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DarBaixaMP(),
                ),
              );
            },
            child: Icon(Icons.filter_list, color: Color(0xFFEBEBEB)),
            heroTag: null,
          ),
        ],
      ),
    );
  }
}