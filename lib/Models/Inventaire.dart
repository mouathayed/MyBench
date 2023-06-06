class Inventaire {
  final String codeEAN;
  final String libelle;
  final String quantite;
  final String prix;

  const Inventaire({
    required this.codeEAN,
    required this.libelle,
    required this.quantite,
    required this.prix,
  });

  factory Inventaire.fromJson(Map<String, dynamic> json) => Inventaire(
        codeEAN: json['codeean'],
        quantite: json['quantite'],
        prix: json['prix'],
        libelle: json['labelle'],
      );

  Map<String, dynamic> toJson() => {
        'codeean': codeEAN,
        'quantite': quantite,
        'prix': prix,
        'labelle': libelle
      };
}
