class Employee {
  final String email;
  final String phoneNumber;
  final String fullName;
  final int id;

  const Employee({
    required this.email,
    required this.phoneNumber,
    required this.fullName,
    required this.id,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        email: json['email'],
        phoneNumber: json['phone'],
        fullName: json['nom_complet'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'email': email,
        'phone': phoneNumber,
        'nom_complet': fullName,
        'id': id,
      };
}
