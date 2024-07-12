import 'package:flutter/material.dart';
import 'package:padaria_mobile/model/Produto/EstoqueProduto.dart';
import 'package:padaria_mobile/services/ProdutoService.dart';
import 'package:padaria_mobile/view/Produtos/EstoqueProdutos.dart';

class ResumoCompraProduto extends StatefulWidget {
  final List<EstoqueProduto> compraList;
  final VoidCallback onCompraSuccess;

  const ResumoCompraProduto({super.key, required this.compraList, required this.onCompraSuccess});

  @override
  State<ResumoCompraProduto> createState() => _ResumoCompraProdutoState();
}

class _ResumoCompraProdutoState extends State<ResumoCompraProduto> {
  final ProdutoService _produtoService = ProdutoService();

  Future<void> _confirmarCompra() async {
    try {
      await _produtoService.cadastrarCompra(widget.compraList);
      widget.onCompraSuccess();
      Navigator.pop(context);
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
        backgroundColor: Color(0xFFDB6D12),
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
                    color: Color(0xFFED9F5F),
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(item.produto?.nome ?? 'Sem descrição'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('N° itens: ${item.quantidade}  Uni:${item.produto?.unidadeUtilizada ?? 'Kg'}'),
                          Text("Validade: ${item.validade.toLocal().toString().split(' ')[0]}"),
                          Text('Valor: R\$${item.valor}'),
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
              spacing: 10,
              runSpacing: 10,
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