import 'package:flutter/material.dart';
import 'package:padaria_mobile/model/MP/EstoqueMP.dart';
import 'package:padaria_mobile/view/MP/EstoqueMP.dart';

import '../../services/MateriaPrimaService.dart';
import '../Home.dart';

class ResumoCompraMP extends StatefulWidget {
  final List<EstoqueMP> compraList;

  const ResumoCompraMP({super.key, required this.compraList});

  @override
  State<ResumoCompraMP> createState() => _ResumoCompraMPState();
}

class _ResumoCompraMPState extends State<ResumoCompraMP> {
  final MateriaPrimaService _materiaPrimaService = MateriaPrimaService();

  void _confirmarCompra() async {
    try {
      await _materiaPrimaService.saveEstoqueMP(widget.compraList);
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => Home()),
            (Route<dynamic> route) => false,
      );
    } catch (error) {
      print('Erro ao confirmar compra: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao confirmar compra')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo Compra'),
        backgroundColor: Color(0xFF118383),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: widget.compraList.length,
                itemBuilder: (context, index) {
                  final item = widget.compraList[index];
                  return Card(
                    color: Color(0xFF9AD0D0),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(item.materiaPrima?.descricao ?? 'Sem descrição'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('N° itens: ${item.quantidade}  Uni:${item.materiaPrima?.unidadeUtilizada ?? 'Kg'}'),
                          Text('Qtd/item: ${item.quantidadeUnidade}'),
                          Text('Validade: ${item.validade.toLocal().toString().split(' ')[0]}  Valor: R\$${item.valor}'),
                        ],
                      ),
                      trailing: FloatingActionButton(
                        backgroundColor: Color(0xFFEBEBEB),
                        mini: true,
                        onPressed: () {
                          setState(() {
                            widget.compraList.removeAt(index);
                          });
                        },
                        child: Icon(
                          Icons.cancel_outlined,
                          color: Colors.black,
                        ),
                        heroTag: null,
                      ),
                    ),
                  );
                },
              ),
            ),
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
                  child: Text('Voltar', style: TextStyle(color: Colors.white)),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  onPressed: _confirmarCompra,
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