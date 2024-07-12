// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'EstoqueProduto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EstoqueProduto _$EstoqueProdutoFromJson(Map<String, dynamic> json) =>
    EstoqueProduto(
      id: (json['id'] as num?)?.toInt(),
      produto: json['produto'] == null
          ? null
          : Produto.fromJson(json['produto'] as Map<String, dynamic>),
      validade: DateTime.parse(json['validade'] as String),
      quantidade: (json['quantidade'] as num).toDouble(),
      dataCriacao: DateTime.parse(json['dataCriacao'] as String),
      idCompra: (json['idCompra'] as num?)?.toInt(),
      valor: (json['valor'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$EstoqueProdutoToJson(EstoqueProduto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'produto': instance.produto,
      'validade': instance.validade.toIso8601String(),
      'dataCriacao': instance.dataCriacao.toIso8601String(),
      'quantidade': instance.quantidade,
      'idCompra': instance.idCompra,
      'valor': instance.valor,
    };
