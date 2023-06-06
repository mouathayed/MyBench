class MagasinConcurrent {
  final String name;
  final String place;
  final int id;

  const MagasinConcurrent({
    required this.name,
    required this.place,
    required this.id,
  });

  factory MagasinConcurrent.fromJson(Map<String, dynamic> json) =>
      MagasinConcurrent(
        name: json['nom'],
        place: json['lieu'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'nom': name,
        'lieu': place,
        'id': id,
      };
}
