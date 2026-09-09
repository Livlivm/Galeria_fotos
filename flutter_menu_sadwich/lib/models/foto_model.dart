class FotoModel {
  String caminho;
  String nome;
  String anotacao;
  String dataHora;

  FotoModel({
    required this.caminho,
    required this.nome,
    required this.anotacao,
    required this.dataHora,
  });

  Map<String, dynamic> toMap() {
    return {
      'caminho': caminho,
      'nome': nome,
      'anotacao': anotacao,
      'dataHora': dataHora,
    };
  }

  factory FotoModel.fromMap(Map<String, dynamic> map) {
    return FotoModel(
      caminho: map['caminho'] ?? '',
      nome: map['nome'] ?? '',
      anotacao: map['anotacao'] ?? '',
      dataHora: map['dataHora'] ?? '',
    );
  }
}
