import 'package:flutter/material.dart';

import 'CompraProduto.dart';
import 'FabricacaoProduto.dart';

class AdicionarProduto extends StatefulWidget {
  final VoidCallback onProdutoAdicionado;

  const AdicionarProduto({super.key, required this.onProdutoAdicionado});

  @override
  State<AdicionarProduto> createState() => _AdicionarProdutoState();
}

class _AdicionarProdutoState extends State<AdicionarProduto> {
  void _handleFabricacao() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FabricacaoProduto(onFabricacaoSuccess: () {
          widget.onProdutoAdicionado();
          Navigator.pop(context);
        }),
      ),
    );
  }

  void _handleCompra() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CompraProduto(onCompraSuccess: () {
          widget.onProdutoAdicionado();
          Navigator.pop(context);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Produto'),
        backgroundColor: Color(0xFFDB6D12), // Fundo laranja
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: _handleCompra,
              child: Card(
                color: Color(0xFFED9F5F), // Fundo laranja claro
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Center(
                    child: Text(
                      'Compra',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: _handleFabricacao,
              child: Card(
                color: Color(0xFFED9F5F), // Fundo laranja claro
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                  child: Center(
                    child: Text(
                      'Fabricação',
                      style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancelar', style: TextStyle(color: Colors.white)),
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