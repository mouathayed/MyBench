class Produit {
  final String codeEAN;
  final String libelle;

  const Produit({
    required this.codeEAN,
    required this.libelle,
  });

  factory Produit.fromJson(Map<String, dynamic> json) => Produit(
        codeEAN: json['codeean'],
        libelle: json['labelle'],
      );

  Map<String, dynamic> toJson() => {
        'codeean': codeEAN,
        'labelle': libelle,
      };
}
