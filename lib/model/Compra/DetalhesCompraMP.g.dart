// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DetalhesCompraMP.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetalhesCompraMP _$DetalhesCompraMPFromJson(Map<String, dynamic> json) =>
    DetalhesCompraMP(
      materiaPrima: json['materiaPrima'] as String,
      unidade: json['unidade'] as String,
      quantidadeUnidade: (json['quantidadeUnidade'] as num).toInt(),
      quantidade: (json['quantidade'] as num).toDouble(),
      validade: DateTime.parse(json['validade'] as String),
      valor: (json['valor'] as num).toDouble(),
    );

Map<String, dynamic> _$DetalhesCompraMPToJson(DetalhesCompraMP instance) =>
    <String, dynamic>{
      'materiaPrima': instance.materiaPrima,
      'unidade': instance.unidade,
      'quantidadeUnidade': instance.quantidadeUnidade,
      'quantidade': instance.quantidade,
      'validade': instance.validade.toIso8601String(),
      'valor': instance.valor,
    };
