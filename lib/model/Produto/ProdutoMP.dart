
import 'package:json_annotation/json_annotation.dart';

import '../MP/MateriaPrima.dart';

part 'ProdutoMP.g.dart';

@JsonSerializable()
class ProdutoMP {
  final int? id;
  final MateriaPrima materiaPrima;
  final double quantidade;

  ProdutoMP({
    this.id,
    required this.materiaPrima,
    required this.quantidade,
  });

  factory ProdutoMP.fromJson(Map<String, dynamic> json) => _$ProdutoMPFromJson(json);
  Map<String, dynamic> toJson() => _$ProdutoMPToJson(this);
}