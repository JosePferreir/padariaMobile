import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:padaria_mobile/view/MP/CompraMP.dart';
import 'package:padaria_mobile/view/MP/DarBaixaMP.dart';
import 'package:padaria_mobile/view/MP/EditarEstoqueMP.dart';

import '../../Services/AuthService.dart';
import '../../model/MP/EstoqueMP.dart';
import '../../services/MateriaPrimaService.dart';
import '../Login.dart';

class EstoqueMPview extends StatefulWidget {
  final VoidCallback onLogout;

  const EstoqueMPview({super.key, required this.onLogout});

  @override
  State<EstoqueMPview> createState() => _EstoqueMPviewState();
}

class _EstoqueMPviewState extends State<EstoqueMPview> {
  final MateriaPrimaService _materiaPrimaService = MateriaPrimaService();
  final TextEditingController _searchController = TextEditingController();
  late Future<List<EstoqueMP>> _estoqueFuture;
  List<EstoqueMP> _estoqueList = [];
  List<EstoqueMP> _filteredEstoqueList = [];

  @override
  void initState() {
    super.initState();
    _fetchEstoque();
  }

  void _fetchEstoque() {
    setState(() {
      _estoqueFuture = _materiaPrimaService.getEstoqueMP();
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
          return item.materiaPrima?.descricao
              ?.toLowerCase()
              .contains(query.toLowerCase()) ??
              false;
        }).toList();
      });
    }
  }

  Future<void> scanBarcode() async {
    String barcodeScanRes = "11";

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DarBaixaMP(codigoBarras: barcodeScanRes),
      ),
    ).then((_) => _fetchEstoque());
    /*
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);

      if (barcodeScanRes != '-1') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DarBaixaMP(codigoBarras: barcodeScanRes),
          ),
        );
      }
    } catch (e) {
      print('Erro ao escanear código de barras: $e');
      barcodeScanRes = 'Falha ao escanear';
    }*/
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Estoque Matéria Prima',
          style: TextStyle(color: Color(0xFFEBEBEB)),
        ),
        backgroundColor: Color(0xFF118383),
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
              child: FutureBuilder<List<EstoqueMP>>(
                future: _estoqueFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Erro ao buscar estoque: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nenhum item encontrado'));
                  }

                  return ListView.builder(
                    itemCount: _filteredEstoqueList.length,
                    itemBuilder: (context, index) {
                      final item = _filteredEstoqueList[index];
                      return Card(
                        color: Color(0xFF9AD0D0),
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(item.materiaPrima?.descricao ?? 'Sem descrição'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('N° itens: ${item.quantidade}  Uni:${item.materiaPrima?.unidadeUtilizada ?? 'Kg'}'),
                              Text("Qtd/item: ${item.quantidadeUnidade}"),
                              Text('Validade: ${item.validade.toLocal().toString().split(' ')[0]} \nTotal: ${item.totalUnidadeUtilizada} ${item.materiaPrima?.unidadeUtilizada ?? 'Kg'}'),
                            ],
                          ),
                          trailing: FloatingActionButton(
                            backgroundColor: Color(0xFFEBEBEB),
                            mini: true,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditarEstoqueMP(item: item),
                                ),
                              ).then((_) => _fetchEstoque());
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
            backgroundColor: Color(0xFF118383),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompraMP(),
                ),
              );
            },
            child: Icon(Icons.add, color: Color(0xFFEBEBEB)),
            heroTag: null,
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            backgroundColor: Color(0xFF118383),
            onPressed: scanBarcode,
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