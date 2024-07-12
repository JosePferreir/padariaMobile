// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MateriaPrima.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MateriaPrima _$MateriaPrimaFromJson(Map<String, dynamic> json) => MateriaPrima(
      id: (json['id'] as num?)?.toInt(),
      ativo: json['ativo'] as bool,
      descricao: json['descricao'] as String,
      unidadeUtilizada: json['unidadeUtilizada'] as String,
      unidadeComprada: json['unidadeComprada'] as String,
    );

Map<String, dynamic> _$MateriaPrimaToJson(MateriaPrima instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ativo': instance.ativo,
      'descricao': instance.descricao,
      'unidadeUtilizada': instance.unidadeUtilizada,
      'unidadeComprada': instance.unidadeComprada,
    };
