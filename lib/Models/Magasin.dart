class Magasin {
  final String name;
  final String place;
  final int adminId;
  final int id;

  const Magasin({
    required this.name,
    required this.place,
    required this.adminId,
    required this.id,
  });

  factory Magasin.fromJson(Map<String, dynamic> json) => Magasin(
        name: json['nom_magasin'],
        place: json['lieu_magasin'],
        id: json['id'],
        adminId: json['admin_id'],
      );

  Map<String, dynamic> toJson() => {
        'nom_magasin': name,
        'lieu_magasin': place,
        'id': id,
        'admin_id': adminId,
      };
}
