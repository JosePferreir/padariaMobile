

import 'package:flutter/material.dart';
import 'package:padaria_mobile/view/Login.dart';
import 'package:padaria_mobile/view/MP/EstoqueMP.dart';
import 'package:padaria_mobile/view/Home.dart';

import 'Services/AuthService.dart';
import 'model/Usuario.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  Future<void> _checkAuthentication() async {
    Usuario? usuario = await _authService.getStoredUser();
    if (usuario != null) {
      try {
        await _authService.login(usuario);
        setState(() {
          _isAuthenticated = true;
        });
      } catch (e) {
        print('Falha no login automático: $e');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return _isAuthenticated ? Home() : Login(onLoginSuccess: _checkAuthentication);
  }
}