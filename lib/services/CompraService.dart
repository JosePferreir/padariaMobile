import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../model/Compra/Compra.dart';
import 'dart:convert';

import '../model/Compra/DetalhesCompraMP.dart';
import '../model/Compra/DetalhesCompraProduto.dart';

class CompraService {
  final String baseUrl = 'http://192.168.0.175:8080';
  final storage = FlutterSecureStorage();

  Future<List<Compra>> getCompras() async {
    final token = await storage.read(key: 'token');

    if (token == null) {
      throw Exception('Token não encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/compra/all'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List;
      return data.map((json) => Compra.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar compras');
    }
  }

  Future<List<DetalhesCompraMP>> getDetalhesMP(int id) async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/compra/mp/detalhes/$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List;
      return data.map((json) => DetalhesCompraMP.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar compras de matéria-prima');
    }
  }

  Future<List<DetalhesCompraProduto>> getDetalhesProduto(int compraId) async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/compra/produto/detalhes/$compraId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List;
      return data.map((json) => DetalhesCompraProduto.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar detalhes da compra de produtos');
    }
  }
}