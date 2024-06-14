import 'package:flutter/material.dart';
import 'package:padaria_mobile/view/Compras.dart';
import 'package:padaria_mobile/view/Produtos/EstoqueProdutos.dart';

import 'MP/EstoqueMP.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "";
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {

    List<Widget> telas = [
      EstoqueMP(),
      EstoqueProduto(),
      Compras(),
    ];

    return Scaffold(
      body: Container(
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _indiceAtual == 0
            ? Color(0xFF118383)
            : _indiceAtual == 1
            ? Color(0xFFDB6D12)
            : Color(0xFF467919),
        currentIndex: _indiceAtual,
        onTap: (index) {
          setState(() {
            _indiceAtual = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        fixedColor: Color(0xFFEBEBEB),
        items: const [
          BottomNavigationBarItem(
            label: "MP",
            icon: Icon(Icons.inventory),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bakery_dining_outlined),
            label: "Produtos",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payments_outlined),
            label: "Compras",
          ),
        ],
      ),
    );
  }
}