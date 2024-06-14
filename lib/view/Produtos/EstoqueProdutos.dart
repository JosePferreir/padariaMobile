import 'package:flutter/material.dart';
import 'package:padaria_mobile/view/Produtos/AdicionarProduto.dart';
import 'package:padaria_mobile/view/Produtos/DarBaixaProduto.dart';
import 'package:padaria_mobile/view/Produtos/EditarEstoqueProduto.dart';

class EstoqueProduto extends StatefulWidget {
  const EstoqueProduto({super.key});

  @override
  State<EstoqueProduto> createState() => _EstoqueProdutoState();
}

class _EstoqueProdutoState extends State<EstoqueProduto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque Produtos', style: TextStyle(color: Color(0xFFEBEBEB))),
        backgroundColor: Color(0xFFDB6D12), // Fundo laranja
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
                    color: Color(0xFFED9F5F), // Fundo laranja claro
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text('Pão'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('N° itens: 200  Uni:Kg'),
                          Text('Fabricado:22/04  Validade:05/05/2023'),
                        ],
                      ),
                      trailing: FloatingActionButton(
                        backgroundColor: Color(0xFFEBEBEB),
                        mini: true,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditarEstoqueProduto(),
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
            backgroundColor: Color(0xFFDB6D12), // Fundo laranja
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AdicionarProduto(),
                ),
              );
            },
            child: Icon(Icons.add, color: Color(0xFFEBEBEB)),
            heroTag: null,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Color(0xFFDB6D12), // Fundo laranja
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DarBaixaProduto(),
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