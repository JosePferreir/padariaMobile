import 'package:flutter/material.dart';

import '../../Services/AuthService.dart';
import '../../model/Compra/Compra.dart';
import '../../services/CompraService.dart';
import '../Login.dart';
import 'DetalhesCompra.dart';

class Compras extends StatefulWidget {
  final VoidCallback onLogout;

  const Compras({super.key, required this.onLogout});

  @override
  State<Compras> createState() => _ComprasState();
}

class _ComprasState extends State<Compras> {
  final CompraService _compraService = CompraService();
  late Future<List<Compra>> _comprasFuture;
  List<Compra> _comprasList = [];
  List<Compra> _filteredComprasList = [];

  @override
  void initState() {
    super.initState();
    _fetchCompras();
  }

  Future<void> _fetchCompras() async {
    setState(() {
      _comprasFuture = _compraService.getCompras();
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
          return compra.tipoCompra.toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Compras', style: TextStyle(color: Color(0xFFEBEBEB))),
        backgroundColor: Color(0xFF467919),
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
              child: FutureBuilder<List<Compra>>(
                future: _comprasFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erro ao buscar compras: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Nenhuma compra encontrada'));
                  }

                  return ListView.builder(
                    itemCount: _filteredComprasList.length,
                    itemBuilder: (context, index) {
                      final compra = _filteredComprasList[index];
                      return Card(
                        color: Color(0xFFAACE8A), // Fundo verde claro
                        margin: const EdgeInsets.symmetric(vertical: 5),
                        child: ListTile(
                          title: Text(compra.tipoCompra),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Data: ${compra.data.toLocal().toString().split(' ')[0]}'),
                              Text('Valor Total: R\$${compra.valorTotal.toStringAsFixed(2)}'),
                            ],
                          ),
                          trailing: FloatingActionButton(
                            backgroundColor: Color(0xFFEBEBEB),
                            mini: true,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetalhesCompra(compra: compra),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.add_circle_outline,
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
    );
  }
}