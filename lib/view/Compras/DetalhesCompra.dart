import 'package:flutter/material.dart';

import '../../model/Compra/Compra.dart';
import '../../model/Compra/DetalhesCompraMP.dart';
import '../../model/Compra/DetalhesCompraProduto.dart';
import '../../services/CompraService.dart';

class DetalhesCompra extends StatefulWidget {
  final Compra compra;

  const DetalhesCompra({super.key, required this.compra});

  @override
  State<DetalhesCompra> createState() => _DetalhesCompraState();
}

class _DetalhesCompraState extends State<DetalhesCompra> {
  final CompraService _compraService = CompraService();
  late Future<List<dynamic>> _comprasFuture;
  List<dynamic> _comprasList = [];
  List<dynamic> _filteredComprasList = [];

  @override
  void initState() {
    super.initState();
    _fetchCompras();
  }

  Future<void> _fetchCompras() async {
    setState(() {
      if (widget.compra.tipoCompra == "MP") {
        _comprasFuture = _compraService.getDetalhesMP(widget.compra.id!);
      } else if (widget.compra.tipoCompra == "Produto") {
        _comprasFuture = _compraService.getDetalhesProduto(widget.compra.id!);
      }

      _comprasFuture.then((comprasList) {
        setState(() {
          _comprasList = comprasList;
          _filteredComprasList = comprasList;
        });
      }).catchError((error) {
        print('Erro ao buscar compras: $error');
      });
    });
  }

  void _filterCompras(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredComprasList = _comprasList;
      } else {
        _filteredComprasList = _comprasList.where((compra) {
          if (widget.compra.tipoCompra == "MP") {
            return (compra as DetalhesCompraMP)
                .materiaPrima
                .toLowerCase()
                .contains(query.toLowerCase());
          } else if (widget.compra.tipoCompra == "Produto") {
            return (compra as DetalhesCompraProduto)
                .produto
                .toLowerCase()
                .contains(query.toLowerCase());
          }
          return false;
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes Compra'),
        backgroundColor: Color(0xFF467919), // Fundo verde
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Buscar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (query) => _filterCompras(query),
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<dynamic>>(
                future: _comprasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao buscar compras: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nenhum item encontrado'));
                  }

                  return ListView.builder(
                    itemCount: _filteredComprasList.length,
                    itemBuilder: (context, index) {
                      final item = _filteredComprasList[index];
                      if (widget.compra.tipoCompra == "MP") {
                        final mpItem = item as DetalhesCompraMP;
                        return Card(
                          color: Color(0xFFAACE8A), // Fundo verde claro
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(mpItem.materiaPrima),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('N° itens: ${mpItem.quantidadeUnidade}  Uni:${mpItem.unidade}  Qtd/item:${mpItem.quantidade}'),
                                Text('Validade: ${mpItem.validade.toLocal().toString().split(' ')[0]}  Valor: R\$${mpItem.valor.toStringAsFixed(2)}'),
                              ],
                            ),
                          ),
                        );
                      } else if (widget.compra.tipoCompra == "Produto") {
                        final produtoItem = item as DetalhesCompraProduto;
                        return Card(
                          color: Color(0xFFAACE8A), // Fundo verde claro
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            title: Text(produtoItem.produto),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Unidade: ${produtoItem.unidade}'),
                                Text('Quantidade: ${produtoItem.quantidade}'),
                                Text('Validade: ${produtoItem.validade.toLocal().toString().split(' ')[0]}'),
                                Text('Valor: R\$${produtoItem.valor.toStringAsFixed(2)}'),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}