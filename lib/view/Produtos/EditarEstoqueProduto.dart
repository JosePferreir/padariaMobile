import 'package:flutter/material.dart';

import '../../model/Produto/EstoqueProduto.dart';
import '../../services/ProdutoService.dart';

class EditarEstoqueProduto extends StatefulWidget {
  final EstoqueProduto item;

  const EditarEstoqueProduto({super.key, required this.item});

  @override
  State<EditarEstoqueProduto> createState() => _EditarEstoqueProdutoState();
}

class _EditarEstoqueProdutoState extends State<EditarEstoqueProduto> {
  late TextEditingController _quantidadeController;
  late TextEditingController _dataFabricacaoController;
  late TextEditingController _validadeController;
  final ProdutoService _produtoService = ProdutoService();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _quantidadeController = TextEditingController(text: widget.item.quantidade.toString());
    _dataFabricacaoController = TextEditingController(text: widget.item.dataCriacao.toLocal().toString().split(' ')[0]);
    _validadeController = TextEditingController(text: widget.item.validade.toLocal().toString().split(' ')[0]);
    _selectedDate = widget.item.validade;
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _dataFabricacaoController.dispose();
    _validadeController.dispose();
    super.dispose();
  }

  Future<void> _editarItem() async {
    final updatedItem = EstoqueProduto(
      id: widget.item.id,
      produto: widget.item.produto,
      validade: _selectedDate,
      quantidade: double.parse(_quantidadeController.text),
      dataCriacao: DateTime.parse(_dataFabricacaoController.text),
      idCompra: widget.item.idCompra,
    );

    try {
      await _produtoService.editarEstoqueProduto(updatedItem);
      Navigator.pop(context, true);
    } catch (error) {
      print('Erro ao editar item: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao editar item')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        controller.text = _selectedDate.toLocal().toString().split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Editar Estoque ${widget.item.produto?.nome ?? "Item"}'),
        backgroundColor: Color(0xFFDB6D12), // Fundo laranja
      ),
      body: SingleChildScrollView(
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
              controller: _validadeController,
              decoration: InputDecoration(
                labelText: 'Validade',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                suffixIcon: Icon(Icons.calendar_today),
              ),
              readOnly: true,
              onTap: () => _selectDate(context, _validadeController),
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
                  onPressed: _editarItem,
                  child: Text('Editar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}