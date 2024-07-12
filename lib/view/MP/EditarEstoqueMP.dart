import 'package:flutter/material.dart';

import '../../model/MP/EstoqueMP.dart';
import '../../services/MateriaPrimaService.dart';

class EditarEstoqueMP extends StatefulWidget {
  final EstoqueMP item;

  const EditarEstoqueMP({super.key, required this.item});

  @override
  State<EditarEstoqueMP> createState() => _EditarEstoqueMPState();
}

class _EditarEstoqueMPState extends State<EditarEstoqueMP> {
  late TextEditingController _quantidadeController;
  late TextEditingController _quantidadeUnidadeController;
  late TextEditingController _validadeController;
  late TextEditingController _totalController;
  final MateriaPrimaService _materiaPrimaService = MateriaPrimaService();
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _quantidadeController = TextEditingController(text: widget.item.quantidade.toString());
    _quantidadeUnidadeController = TextEditingController(text: widget.item.quantidadeUnidade.toString());
    _validadeController = TextEditingController(text: widget.item.validade.toLocal().toString().split(' ')[0]);
    _totalController = TextEditingController(text: widget.item.totalUnidadeUtilizada.toString());
    _selectedDate = widget.item.validade;
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _quantidadeUnidadeController.dispose();
    _validadeController.dispose();
    _totalController.dispose();
    super.dispose();
  }

  Future<void> _editarItem() async {
    final updatedItem = EstoqueMP(
      id: widget.item.id,
      materiaPrima: widget.item.materiaPrima,
      validade: _selectedDate,
      quantidade: double.parse(_quantidadeController.text),
      quantidadeUnidade: int.parse(_quantidadeUnidadeController.text),
      totalUnidadeUtilizada: double.parse(_totalController.text),
      valor: widget.item.valor,
    );

    try {
      await _materiaPrimaService.editarEstoqueMP(updatedItem);
      Navigator.pop(context);
    } catch (error) {
      print('Erro ao editar item: $error');
      // Exibir mensagem de erro
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao editar item')),
      );
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
        title: Text('Editar Estoque ${widget.item.materiaPrima?.descricao ?? "Item"}'),
        backgroundColor: Color(0xFF118383),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
                controller: _quantidadeUnidadeController,
                decoration: InputDecoration(
                  labelText: 'Quantidade por item',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              TextField(
                controller: _totalController,
                decoration: InputDecoration(
                  labelText: 'Total',
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
      ),
    );
  }
}