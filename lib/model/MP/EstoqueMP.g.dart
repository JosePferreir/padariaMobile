// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EstoqueMP.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstoqueMP _$EstoqueMPFromJson(Map<String, dynamic> json) => EstoqueMP(
      id: (json['id'] as num?)?.toInt(),
      materiaPrima: json['materiaPrima'] == null
          ? null
          : MateriaPrima.fromJson(json['materiaPrima'] as Map<String, dynamic>),
      validade: DateTime.parse(json['validade'] as String),
      quantidade: (json['quantidade'] as num).toDouble(),
      quantidadeUnidade: (json['quantidadeUnidade'] as num).toInt(),
      totalUnidadeUtilizada: (json['totalUnidadeUtilizada'] as num).toDouble(),
      valor: (json['valor'] as num).toDouble(),
    );

Map<String, dynamic> _$EstoqueMPToJson(EstoqueMP instance) => <String, dynamic>{
      'id': instance.id,
      'materiaPrima': instance.materiaPrima,
      'validade': instance.validade.toIso8601String(),
      'quantidade': instance.quantidade,
      'quantidadeUnidade': instance.quantidadeUnidade,
      'totalUnidadeUtilizada': instance.totalUnidadeUtilizada,
      'valor': instance.valor,
    };
