class Magasinier {
  final String fullName;
  final String phoneNumber;
  final String email;
  final String magasinName;
  final String magasinPlace;
  final int adminId;
  final int id;

  const Magasinier({
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.magasinName,
    required this.magasinPlace,
    required this.adminId,
    required this.id,
  });

  factory Magasinier.fromJson(Map<String, dynamic> json) => Magasinier(
        fullName: json['nom_complet'],
        phoneNumber: json['phone'],
        email: json['email'],
        magasinName: json['nom_magasin'],
        magasinPlace: json['lieu_magasin'],
        id: json['id'],
        adminId: json['admin_id'],
      );

  Map<String, dynamic> toJson() => {
        'nom_complet': fullName,
        'phone': phoneNumber,
        'nom_magasin': magasinName,
        'lieu_magasin': magasinPlace,
        'id': id,
        'admin_id': adminId,
      };
}
