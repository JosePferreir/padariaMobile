// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Produto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Produto _$ProdutoFromJson(Map<String, dynamic> json) => Produto(
      id: (json['id'] as num?)?.toInt(),
      nome: json['nome'] as String,
      unidadeUtilizada: json['unidadeUtilizada'] as String,
      ativo: json['ativo'] as bool,
      produtoMp: (json['produtoMp'] as List<dynamic>?)
              ?.map((e) => ProdutoMP.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );

Map<String, dynamic> _$ProdutoToJson(Produto instance) => <String, dynamic>{
      'id': instance.id,
      'nome': instance.nome,
      'unidadeUtilizada': instance.unidadeUtilizada,
      'ativo': instance.ativo,
      'produtoMp': instance.produtoMp,
    };
