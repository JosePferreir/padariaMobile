import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/Usuario.dart';


class AuthService {
  final String baseUrl = 'http://192.168.0.175:8080'; // Substitua pelo URL da sua API
  final storage = FlutterSecureStorage();

  Future<Usuario?> getStoredUser() async {
    final email = await storage.read(key: 'email');
    final senha = await storage.read(key: 'senha');
    if (email != null && senha != null) {
      return Usuario(email: email, senha: senha);
    }
    return null;
  }

  Future<String> login(Usuario usuario) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(usuario.toJson()),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];
      await storage.write(key: 'token', value: token);
      // Armazenar email e senha
      await storage.write(key: 'email', value: usuario.email);
      await storage.write(key: 'senha', value: usuario.senha);
      return token;
    } else {
      throw Exception('Falha no login');
    }
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'email');
    await storage.delete(key: 'senha');
  }
}