class UserModel {
  final String id;
  final String nomComplet;
  final String email;
  final String role; // 'Client' ou 'Freelancer' 
  final String photoProfil;

  UserModel({
    required this.id,
    required this.nomComplet,
    required this.email,
    required this.role,
    required this.photoProfil,
  });

  // Pour transformer les données venant du Backend (Django)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nomComplet: json['nomComplet'],
      email: json['email'],
      role: json['role'],
      photoProfil: json['photoProfil'],
    );
  }
}  