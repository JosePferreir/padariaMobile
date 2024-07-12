import 'package:flutter/material.dart';
import 'package:padaria_mobile/model/Produto/EstoqueProduto.dart';
import 'package:padaria_mobile/model/Produto/Produto.dart';
import 'package:padaria_mobile/services/ProdutoService.dart';

import 'ResumoCompraProduto.dart';

class CompraProduto extends StatefulWidget {
  final VoidCallback onCompraSuccess;

  const CompraProduto({super.key, required this.onCompraSuccess});

  @override
  State<CompraProduto> createState() => _CompraProdutoState();
}

class _CompraProdutoState extends State<CompraProduto> {
  final ProdutoService _produtoService = ProdutoService();
  late Future<List<Produto>> _produtosFuture;
  List<EstoqueProduto> _estoqueProdutos = [];

  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _validadeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();

  Produto? _produtoSelecionado;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _produtosFuture = _produtoService.getProdutosAtivos();
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _validadeController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _addProduto() {
    if (_produtoSelecionado != null && _quantidadeController.text.isNotEmpty && _validadeController.text.isNotEmpty) {
      final produto = EstoqueProduto(
        produto: _produtoSelecionado!,
        quantidade: double.parse(_quantidadeController.text),
        validade: _selectedDate,
        dataCriacao: DateTime.now(),
        valor: double.parse(_valorController.text),
      );
      setState(() {
        _estoqueProdutos.add(produto);
        _quantidadeController.clear();
        _validadeController.clear();
        _valorController.clear();
        _produtoSelecionado = null;
      });
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _validadeController.text = _selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compra Produto'),
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
                  return Center(child: Text('Nenhum produto ativo encontrado'));
                }

                final produtos = snapshot.data!;
                return DropdownButtonFormField<Produto>(
                  decoration: InputDecoration(
                    labelText: 'Produto',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  items: produtos.map((Produto produto) {
                    return DropdownMenuItem<Produto>(
                      value: produto,
                      child: Text(produto.nome),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      _produtoSelecionado = newValue;
                    });
                  },
                  value: _produtoSelecionado,
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
              controller: _validadeController,
              decoration: InputDecoration(
                labelText: 'Validade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              readOnly: true,
              onTap: () => _selectDate(context),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _valorController,
              decoration: InputDecoration(
                labelText: 'Valor',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            Text('Produtos adicionados: ${_estoqueProdutos.length}'),
            SizedBox(height: 10),
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
                  child: Text('Cancelar', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: _addProduto,
                  child: Text('Adicionar', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResumoCompraProduto(compraList: _estoqueProdutos, onCompraSuccess: (){
                          widget.onCompraSuccess();
                          Navigator.pop(context);
                        }),
                      ),
                    );
                  },
                  child: Text('Confirmar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}