import 'package:flutter/material.dart';

class DarBaixaProduto extends StatefulWidget {
  const DarBaixaProduto({super.key});

  @override
  State<DarBaixaProduto> createState() => _DarBaixaProdutoState();
}

class _DarBaixaProdutoState extends State<DarBaixaProduto> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dar baixa Pão'),
        backgroundColor: Color(0xFFDB6D12), // Fundo laranja
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
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