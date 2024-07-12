import 'package:flutter/material.dart';
import 'package:padaria_mobile/view/MP/ResumoCompraMP.dart';

import '../../model/MP/EstoqueMP.dart';
import '../../model/MP/MateriaPrima.dart';
import '../../services/MateriaPrimaService.dart';

class CompraMP extends StatefulWidget {
  const CompraMP({super.key});

  @override
  State<CompraMP> createState() => _CompraMPState();
}

class _CompraMPState extends State<CompraMP> {
  final MateriaPrimaService _materiaPrimaService = MateriaPrimaService();
  List<MateriaPrima> _materiaPrimaList = [];
  List<EstoqueMP> _compraList = [];
  MateriaPrima? _selectedMateriaPrima;
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _quantidadeUnidadeController = TextEditingController();
  final TextEditingController _validadeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchMateriaPrima();
  }

  Future<void> _fetchMateriaPrima() async {
    try {
      List<MateriaPrima> materiaPrimaList = await _materiaPrimaService.getMateriasPrimasAtivas();
      setState(() {
        _materiaPrimaList = materiaPrimaList;
      });
    } catch (error) {
      print('Erro ao buscar matérias-primas: $error');
    }
  }

  void _selectDate(BuildContext context) async {
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

  void _addItem() {
    if (_selectedMateriaPrima != null &&
        _quantidadeController.text.isNotEmpty &&
        _quantidadeUnidadeController.text.isNotEmpty &&
        _validadeController.text.isNotEmpty &&
        _valorController.text.isNotEmpty) {
      final newItem = EstoqueMP(
        materiaPrima: _selectedMateriaPrima,
        quantidade: double.parse(_quantidadeController.text),
        quantidadeUnidade: int.parse(_quantidadeUnidadeController.text),
        validade: DateTime.parse(_validadeController.text),
        valor: double.parse(_valorController.text),
        totalUnidadeUtilizada: double.parse(_quantidadeController.text),
      );

      setState(() {
        _compraList.add(newItem);
        _selectedMateriaPrima = null;
        _quantidadeController.clear();
        _quantidadeUnidadeController.clear();
        _validadeController.clear();
        _valorController.clear();
      });
    }
  }

  @override
  void dispose() {
    _quantidadeController.dispose();
    _quantidadeUnidadeController.dispose();
    _validadeController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Compra Matéria-prima'),
        backgroundColor: Color(0xFF118383),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButtonFormField<MateriaPrima>(
              decoration: InputDecoration(
                labelText: 'Matéria-prima',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              items: _materiaPrimaList.map((MateriaPrima value) {
                return DropdownMenuItem<MateriaPrima>(
                  value: value,
                  child: Text(value.descricao),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedMateriaPrima = newValue;
                });
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
            SizedBox(height: 20),
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
                  onPressed: _addItem,
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
                        builder: (context) => ResumoCompraMP(compraList: _compraList),
                      ),
                    );
                  },
                  child: Text('Confirmar', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Itens adicionados: ${_compraList.length}'),
          ],
        ),
      ),
    );
  }
}