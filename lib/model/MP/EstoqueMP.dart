import 'package:json_annotation/json_annotation.dart';
import 'MateriaPrima.dart';

part 'EstoqueMP.g.dart';

@JsonSerializable()
class EstoqueMP {
  final int? id;
  final MateriaPrima? materiaPrima;
  final DateTime validade;
  late final double quantidade;
  final int quantidadeUnidade;
  final double totalUnidadeUtilizada;
  final double valor;

  EstoqueMP({
    this.id,
    this.materiaPrima,
    required this.validade,
    required this.quantidade,
    required this.quantidadeUnidade,
    required this.totalUnidadeUtilizada,
    required this.valor,
  });

  factory EstoqueMP.fromJson(Map<String, dynamic> json) =>
      _$EstoqueMPFromJson(json);

  Map<String, dynamic> toJson() => _$EstoqueMPToJson(this);
}