import 'package:json_annotation/json_annotation.dart';

part 'DetalhesCompraMP.g.dart';

@JsonSerializable()
class DetalhesCompraMP {
  final String materiaPrima;
  final String unidade;
  final int quantidadeUnidade;
  final double quantidade;
  final DateTime validade;
  final double valor;

  DetalhesCompraMP({
    required this.materiaPrima,
    required this.unidade,
    required this.quantidadeUnidade,
    required this.quantidade,
    required this.validade,
    required this.valor,
  });

  factory DetalhesCompraMP.fromJson(Map<String, dynamic> json) => _$DetalhesCompraMPFromJson(json);
  Map<String, dynamic> toJson() => _$DetalhesCompraMPToJson(this);
}