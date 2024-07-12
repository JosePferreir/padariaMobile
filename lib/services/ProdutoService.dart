import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:padaria_mobile/model/Produto/Produto.dart';

import '../model/Produto/EstoqueProduto.dart';


class ProdutoService {
  final String baseUrl = 'http://192.168.0.175:8080';
  final storage = FlutterSecureStorage();

  Future<List<EstoqueProduto>> getEstoqueProduto() async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token não encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/estoque_produto/all'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List<dynamic>;
      final List<EstoqueProduto> estoqueList = data.map((json) => EstoqueProduto.fromJson(json)).toList();
      return estoqueList;
    } else {
      throw Exception('Falha ao buscar estoque de produtos');
    }
  }

  Future<EstoqueProduto> getEstoqueByCodigoBarras(String codigoBarras) async {
    final token = await storage.read(key: 'token');
    final longCodigoBarras = int.parse(codigoBarras);
    final response = await http.get(
      Uri.parse('$baseUrl/estoque_produto/codigo/$longCodigoBarras'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return EstoqueProduto.fromJson(data);
    } else {
      throw Exception('Falha ao buscar estoque por código de barras');
    }
  }

  Future<List<Produto>> getProdutosAtivos() async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token não encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/produto/all/ativos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body) as List<dynamic>;
      final List<Produto> estoqueList = data.map((json) => Produto.fromJson(json)).toList();
      return estoqueList;
    } else {
      throw Exception('Falha ao buscar estoque de produtos');
    }
  }

  Future<void> editarEstoqueProduto(EstoqueProduto item) async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token não encontrado');
    }
    print(item.produto?.toJson());
    final response = await http.put(
      Uri.parse('$baseUrl/estoque_produto/update/${item.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao editar estoque do produto');
    }
  }

  Future<void> cadastrarEstoqueProduto(EstoqueProduto estoqueProduto) async {
    final token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$baseUrl/estoque_produto/save'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(estoqueProduto.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao criar estoque de produto');
    }
  }

  Future<void> cadastrarCompra(List<EstoqueProduto> estoqueProdutos) async {
    final token = await storage.read(key: 'token');
    final response = await http.post(
      Uri.parse('$baseUrl/estoque_produto/save_compra'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(estoqueProdutos.map((e) => e.toJson()).toList()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao criar estoque de produto');
    }
  }
}