import 'package:json_annotation/json_annotation.dart';

part 'MateriaPrima.g.dart';

@JsonSerializable()
class MateriaPrima {
  final int? id;
  final bool ativo;
  final String descricao;
  final String unidadeUtilizada;
  final String unidadeComprada;

  MateriaPrima({
    this.id,
    required this.ativo,
    required this.descricao,
    required this.unidadeUtilizada,
    required this.unidadeComprada,
  });

  factory MateriaPrima.fromJson(Map<String, dynamic> json) =>
      _$MateriaPrimaFromJson(json);

  Map<String, dynamic> toJson() => _$MateriaPrimaToJson(this);


}