import 'package:flutter/material.dart';
import 'package:padaria_mobile/view/Compras/Compras.dart';
import 'package:padaria_mobile/view/Produtos/EstoqueProdutos.dart';

import '../Services/AuthService.dart';
import 'Login.dart';
import 'MP/EstoqueMP.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _authService = AuthService();
  int _indiceAtual = 0;

  Future<void> _logout() async {
    await _authService.logout();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => Login(onLoginSuccess: _checkAuthentication)),
          (route) => false,
    );
  }

  Future<void> _checkAuthentication() async {
    String? token = await _authService.getToken();
    if (mounted) {
      setState(() {
        _indiceAtual = token != null ? _indiceAtual : 0;
      });
    }
  }

  void handleLogout() {
    _logout();
  }

  @override
  Widget build(BuildContext context) {
    print('Home - buildou');

    List<Widget> telas = [
      EstoqueMPview(onLogout: handleLogout),
      EstoqueProdutoView(onLogout: handleLogout),
      Compras(onLogout: handleLogout),
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