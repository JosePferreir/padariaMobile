import 'package:flutter/material.dart';

import '../../model/MP/EstoqueMP.dart';
import '../../services/MateriaPrimaService.dart';

class DarBaixaMP extends StatefulWidget {
  final String codigoBarras;

  const DarBaixaMP({super.key, required this.codigoBarras});

  @override
  State<DarBaixaMP> createState() => _DarBaixaMPState();
}

class _DarBaixaMPState extends State<DarBaixaMP> {
  final MateriaPrimaService _materiaPrimaService = MateriaPrimaService();
  EstoqueMP? _estoqueMP;
  final TextEditingController _quantidadeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchEstoque();
  }

  Future<void> _fetchEstoque() async {
    try {
      EstoqueMP estoque = await _materiaPrimaService.getEstoqueByCodigoBarras(widget.codigoBarras);
      setState(() {
        _estoqueMP = estoque;
        _quantidadeController.text = estoque.quantidade.toString();
      });
    } catch (error) {
      print('Erro ao buscar estoque: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao buscar estoque: $error')),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _confirmarEdicao() async {
    if (_estoqueMP != null) {
      _estoqueMP!.quantidade = double.parse(_quantidadeController.text);
      try {
        await _materiaPrimaService.editarEstoqueMP(_estoqueMP!);
        Navigator.pop(context);
      } catch (error) {
        print('Erro ao editar estoque: $error');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao editar estoque: $error')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dar baixa ${_estoqueMP?.materiaPrima?.descricao ?? ''}'),
        backgroundColor: Color(0xFF118383),
      ),
      body: Padding(
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
                  onPressed: _confirmarEdicao,
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