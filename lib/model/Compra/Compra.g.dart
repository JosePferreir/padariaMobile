// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Compra.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Compra _$CompraFromJson(Map<String, dynamic> json) => Compra(
      id: (json['id'] as num?)?.toInt(),
      valorTotal: (json['valorTotal'] as num).toDouble(),
      tipoCompra: json['tipoCompra'] as String,
      data: DateTime.parse(json['data'] as String),
    );

Map<String, dynamic> _$CompraToJson(Compra instance) => <String, dynamic>{
      'id': instance.id,
      'valorTotal': instance.valorTotal,
      'tipoCompra': instance.tipoCompra,
      'data': instance.data.toIso8601String(),
    };
