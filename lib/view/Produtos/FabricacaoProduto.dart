import 'package:flutter/material.dart';
import 'package:padaria_mobile/model/Produto/EstoqueProduto.dart';

import '../../model/Produto/Produto.dart';
import '../../services/ProdutoService.dart';

class FabricacaoProduto extends StatefulWidget {
  final VoidCallback onFabricacaoSuccess;

  const FabricacaoProduto({super.key, required this.onFabricacaoSuccess});

  @override
  State<FabricacaoProduto> createState() => _FabricacaoProdutoState();
}

class _FabricacaoProdutoState extends State<FabricacaoProduto> {
  final ProdutoService _produtoService = ProdutoService();
  late Future<List<Produto>> _produtosFuture;
  Produto? _selectedProduto;
  late TextEditingController _quantidadeController;
  late TextEditingController _dataFabricacaoController;
  late TextEditingController _dataValidadeController;

  @override
  void initState() {
    super.initState();
    _quantidadeController = TextEditingController();
    _dataFabricacaoController = TextEditingController();
    _dataValidadeController = TextEditingController();
    _produtosFuture = _produtoService.getProdutosAtivos();
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _dataFabricacaoController.dispose();
    _dataValidadeController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = picked.toLocal().toString().split(' ')[0];
      });
    }
  }

  Future<void> _confirmarFabricacao() async {
    if (_selectedProduto == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Selecione um produto')),
      );
      return;
    }

    final novoEstoque = EstoqueProduto(
      produto: _selectedProduto!,
      quantidade: double.parse(_quantidadeController.text),
      validade: DateTime.parse(_dataValidadeController.text),
      dataCriacao: DateTime.parse(_dataFabricacaoController.text),
    );

    try {
      await _produtoService.cadastrarEstoqueProduto(novoEstoque);
      widget.onFabricacaoSuccess();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto fabricado com sucesso')),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao fabricar produto: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fabricação Produto'),
        backgroundColor: Color(0xFFDB6D12), // Fundo laranja
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            FutureBuilder<List<Produto>>(
              future: _produtosFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro ao buscar produtos: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('Nenhum produto encontrado'));
                }

                return DropdownButtonFormField<Produto>(
                  decoration: InputDecoration(
                    labelText: 'Produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: snapshot.data!.map((Produto produto) {
                    return DropdownMenuItem<Produto>(
                      value: produto,
                      child: Text(produto.nome),
                    );
                  }).toList(),
                  onChanged: (Produto? newValue) {
                    setState(() {
                      _selectedProduto = newValue;
                    });
                  },
                );
              },
            ),
            SizedBox(height: 10),
            TextField(
              controller: _quantidadeController,
              decoration: InputDecoration(
                labelText: 'Quantidade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _dataFabricacaoController,
              decoration: InputDecoration(
                labelText: 'Data Fabricação',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _dataFabricacaoController),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _dataValidadeController,
              decoration: InputDecoration(
                labelText: 'Validade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _dataValidadeController),
            ),
            SizedBox(height: 20),
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
                  onPressed: _confirmarFabricacao,
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