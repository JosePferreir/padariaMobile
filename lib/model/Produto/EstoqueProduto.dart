
import 'package:json_annotation/json_annotation.dart';
import 'package:padaria_mobile/model/Produto/Produto.dart';

part 'EstoqueProduto.g.dart';

@JsonSerializable()
class EstoqueProduto {
  final int? id;
  final Produto? produto;
  final DateTime validade;
  final DateTime dataCriacao;
  late final double quantidade;
  final int? idCompra;
  final double? valor;

  EstoqueProduto({
    this.id,
    required this.produto,
    required this.validade,
    required this.quantidade,
    required this.dataCriacao,
    this.idCompra,
    this.valor,
  });

  factory EstoqueProduto.fromJson(Map<String, dynamic> json) => _$EstoqueProdutoFromJson(json);
  Map<String, dynamic> toJson() => _$EstoqueProdutoToJson(this);
}