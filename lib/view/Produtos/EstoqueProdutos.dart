import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:padaria_mobile/view/Produtos/AdicionarProduto.dart';
import 'package:padaria_mobile/view/Produtos/DarBaixaProduto.dart';
import '../../model/Produto/EstoqueProduto.dart';
import '../../services/ProdutoService.dart';
import 'EditarEstoqueProduto.dart';

class EstoqueProdutoView extends StatefulWidget {
  final VoidCallback onLogout;

  const EstoqueProdutoView({super.key, required this.onLogout});

  @override
  State<EstoqueProdutoView> createState() => _EstoqueProdutoViewState();
}

class _EstoqueProdutoViewState extends State<EstoqueProdutoView> {
  final ProdutoService _produtoService = ProdutoService();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<EstoqueProduto>> _estoqueFuture;
  List<EstoqueProduto> _estoqueList = [];
  List<EstoqueProduto> _filteredEstoqueList = [];

  void _handleAdicionarProduto() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AdicionarProduto(onProdutoAdicionado: _fetchEstoque),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchEstoque();
  }

  void _fetchEstoque() {
    setState(() {
      _estoqueFuture = _produtoService.getEstoqueProduto();
      _estoqueFuture.then((estoqueList) {
        setState(() {
          _estoqueList = estoqueList;
          _filteredEstoqueList = estoqueList;
        });
      }).catchError((error) {
        print('Erro ao buscar estoque: $error');
      });
    });
  }

  void _filterEstoque(String query) {
    if (query.isEmpty) {
      setState(() {
        _filteredEstoqueList = _estoqueList;
      });
    } else {
      setState(() {
        _filteredEstoqueList = _estoqueList.where((item) {
          return item.produto?.nome.toLowerCase().contains(query.toLowerCase()) ?? false;
        }).toList();
      });
    }
  }

  Future<void> scanBarcode() async {
    try {
      String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);

      if (barcodeScanRes != '-1') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DarBaixaProduto(codigoBarras: barcodeScanRes),
          ),
        );
      }
    } catch (e) {
      print('Erro ao escanear código de barras: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque Produtos', style: TextStyle(color: Color(0xFFEBEBEB))),
        backgroundColor: Color(0xFFDB6D12),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Color(0xFFEBEBEB)),
            onPressed: widget.onLogout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Buscar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: _filterEstoque,
            ),
            SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List<EstoqueProduto>>(
                future: _estoqueFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao buscar estoque: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nenhum item encontrado'));
                  }

                  return ListView.builder(
                    itemCount: _filteredEstoqueList.length,
                    itemBuilder: (context, index) {
                      final item = _filteredEstoqueList[index];
                      return Card(
                        color: Color(0xFFED9F5F),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(item.produto?.nome ?? 'Sem descrição'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('N° itens: ${item.quantidade}\nUni:${item.produto?.unidadeUtilizada ?? 'Kg'}'),
                              Text("Validade: ${item.validade.toLocal().toString().split(' ')[0]}"),
                              Text('Fabricado: ${item.dataCriacao.toLocal().toString().split(' ')[0]}'),
                            ],
                          ),
                          trailing: FloatingActionButton(
                            backgroundColor: Color(0xFFEBEBEB),
                            mini: true,
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditarEstoqueProduto(item: item),
                                ),
                              );
                              if (result == true) {
                                _fetchEstoque();
                              }
                            },
                            child: Icon(
                              Icons.edit_outlined,
                              color: Colors.black,
                            ),
                            heroTag: null,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Color(0xFFDB6D12),
            onPressed: _handleAdicionarProduto,
            child: Icon(Icons.add, color: Color(0xFFEBEBEB)),
            heroTag: null,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Color(0xFFDB6D12),
            onPressed: () async {
              await scanBarcode();
            },
            child: Image.asset(
              'assets/icons/barcode_scan.png',
              width: 24,
              height: 24,
            ),
            heroTag: null,
          ),
        ],
      ),
    );
  }
}