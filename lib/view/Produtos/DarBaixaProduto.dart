import 'package:flutter/material.dart';

import '../../model/Produto/EstoqueProduto.dart';
import '../../services/ProdutoService.dart';

class DarBaixaProduto extends StatefulWidget {
  final String codigoBarras;

  const DarBaixaProduto({super.key, required this.codigoBarras});

  @override
  State<DarBaixaProduto> createState() => _DarBaixaProdutoState();
}

class _DarBaixaProdutoState extends State<DarBaixaProduto> {
  late Future<EstoqueProduto> _estoqueFuture;
  final ProdutoService _produtoService = ProdutoService();
  late TextEditingController _quantidadeController;

  @override
  void initState() {
    super.initState();
    _estoqueFuture = _produtoService.getEstoqueByCodigoBarras(widget.codigoBarras);
    _quantidadeController = TextEditingController();
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    super.dispose();
  }

  Future<void> _editarEstoque(EstoqueProduto estoqueProduto) async {
    estoqueProduto.quantidade = double.parse(_quantidadeController.text);
    try {
      await _produtoService.editarEstoqueProduto(estoqueProduto);
      Navigator.pop(context);
    } catch (error) {
      print('Erro ao editar estoque: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao editar estoque')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder<EstoqueProduto>(
          future: _estoqueFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text('Carregando...');
            } else if (snapshot.hasError) {
              return Text('Erro');
            } else if (snapshot.hasData) {
              return Text('Dar baixa ${snapshot.data?.produto?.nome ?? 'Produto'}');
            } else {
              return Text('Produto não encontrado');
            }
          },
        ),
        backgroundColor: Color(0xFFDB6D12),
      ),
      body: FutureBuilder<EstoqueProduto>(
        future: _estoqueFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro ao buscar dados: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('Produto não encontrado'));
          }

          final estoqueProduto = snapshot.data!;
          _quantidadeController.text = estoqueProduto.quantidade.toString();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _quantidadeController,
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
                      onPressed: () => _editarEstoque(estoqueProduto),
                      child: Text('Confirmar', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          );
        },
      ),
    );
  }
}