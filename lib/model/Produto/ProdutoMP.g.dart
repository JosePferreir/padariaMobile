// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ProdutoMP.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProdutoMP _$ProdutoMPFromJson(Map<String, dynamic> json) => ProdutoMP(
      id: (json['id'] as num?)?.toInt(),
      materiaPrima:
          MateriaPrima.fromJson(json['materiaPrima'] as Map<String, dynamic>),
      quantidade: (json['quantidade'] as num).toDouble(),
    );

Map<String, dynamic> _$ProdutoMPToJson(ProdutoMP instance) => <String, dynamic>{
      'id': instance.id,
      'materiaPrima': instance.materiaPrima,
      'quantidade': instance.quantidade,
    };
