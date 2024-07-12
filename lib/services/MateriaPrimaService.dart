import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../model/MP/EstoqueMP.dart';
import '../model/MP/MateriaPrima.dart';

class MateriaPrimaService {
  final String baseUrl = 'http://192.168.0.175:8080'; // Para emulador Android
  final storage = FlutterSecureStorage();

  Future<List<EstoqueMP>> getEstoqueMP() async {
    final token = await storage.read(key: 'token');
    final response = await http.get(
      Uri.parse('$baseUrl/estoque_mp/all'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => EstoqueMP.fromJson(json)).toList();
    } else {
      throw Exception('Falha ao buscar estoque de matéria prima');
    }
  }

  Future<EstoqueMP> getEstoqueByCodigoBarras(String codigoBarras) async {
    final token = await storage.read(key: 'token');
    final longCodigoBarras = int.parse(codigoBarras);
    final response = await http.get(
      Uri.parse('$baseUrl/estoque_mp/codigo/$longCodigoBarras'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return EstoqueMP.fromJson(data);
    } else {
      throw Exception('Falha ao buscar estoque por código de barras');
    }
  }

  Future<void> editarEstoqueMP(EstoqueMP item) async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token não encontrado');
    }
    final response = await http.put(
      Uri.parse('$baseUrl/estoque_mp/update/${item.id}'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(item.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao editar item');
    }
  }

  Future<List<MateriaPrima>> getMateriasPrimasAtivas() async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token não encontrado');
    }

    final response = await http.get(
      Uri.parse('$baseUrl/materia_prima/all/ativos'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => MateriaPrima.fromJson(json)).toList();
    } else {
      print('Erro: ${response.statusCode}, ${response.body}');
      throw Exception('Falha ao buscar matérias-primas ativas');
    }
  }

  Future<void> saveEstoqueMP(List<EstoqueMP> compraList) async {
    final token = await storage.read(key: 'token');
    if (token == null) {
      throw Exception('Token não encontrado');
    }

    final response = await http.post(
      Uri.parse('$baseUrl/estoque_mp/save'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(compraList.map((e) => e.toJson()).toList()),
    );

    if (response.statusCode != 200) {
      throw Exception('Falha ao confirmar compra');
    }
  }
}