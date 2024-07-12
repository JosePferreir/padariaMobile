import 'package:padaria_mobile/model/Produto/ProdutoMP.dart';
import 'package:json_annotation/json_annotation.dart';

part 'Produto.g.dart';

@JsonSerializable()
class Produto {
  final int? id;
  final String nome;
  final String unidadeUtilizada;
  final bool ativo;

  @JsonKey(defaultValue: [])
  final List<ProdutoMP>? produtoMp;

  Produto({
    this.id,
    required this.nome,
    required this.unidadeUtilizada,
    required this.ativo,
    this.produtoMp,
  });

  factory Produto.fromJson(Map<String, dynamic> json) => _$ProdutoFromJson(json);
  Map<String, dynamic> toJson() => _$ProdutoToJson(this);
}