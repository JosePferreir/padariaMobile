import 'package:json_annotation/json_annotation.dart';

part 'Compra.g.dart';

@JsonSerializable()
class Compra {
  final int? id;
  final double valorTotal;
  final String tipoCompra;
  final DateTime data;

  Compra({
    this.id,
    required this.valorTotal,
    required this.tipoCompra,
    required this.data,
  });

  factory Compra.fromJson(Map<String, dynamic> json) => _$CompraFromJson(json);
  Map<String, dynamic> toJson() => _$CompraToJson(this);
}