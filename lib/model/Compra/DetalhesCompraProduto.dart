import 'package:json_annotation/json_annotation.dart';

part 'DetalhesCompraProduto.g.dart';

@JsonSerializable()
class DetalhesCompraProduto {
  final String produto;
  final String unidade;
  final double quantidade;
  final double valor;
  final DateTime validade;

  DetalhesCompraProduto({
    required this.produto,
    required this.unidade,
    required this.quantidade,
    required this.valor,
    required this.validade,
  });

  factory DetalhesCompraProduto.fromJson(Map<String, dynamic> json) => _$DetalhesCompraProdutoFromJson(json);
  Map<String, dynamic> toJson() => _$DetalhesCompraProdutoToJson(this);
}
