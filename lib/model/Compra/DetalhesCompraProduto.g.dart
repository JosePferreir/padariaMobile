// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DetalhesCompraProduto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetalhesCompraProduto _$DetalhesCompraProdutoFromJson(
        Map<String, dynamic> json) =>
    DetalhesCompraProduto(
      produto: json['produto'] as String,
      unidade: json['unidade'] as String,
      quantidade: (json['quantidade'] as num).toDouble(),
      valor: (json['valor'] as num).toDouble(),
      validade: DateTime.parse(json['validade'] as String),
    );

Map<String, dynamic> _$DetalhesCompraProdutoToJson(
        DetalhesCompraProduto instance) =>
    <String, dynamic>{
      'produto': instance.produto,
      'unidade': instance.unidade,
      'quantidade': instance.quantidade,
      'valor': instance.valor,
      'validade': instance.validade.toIso8601String(),
    };
