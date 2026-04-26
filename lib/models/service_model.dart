class ServiceModel {
  final String id;
  final String titre;
  final String description;
  final double prix;
  final String categorie;
  final String image;
  final String nomFreelancer;
  final String photoFreelancer;
  final double note;
  bool estFavoris;

  ServiceModel({
    required this.id,
    required this.titre,
    required this.description,
    required this.prix,
    required this.categorie,
    required this.image,
    required this.nomFreelancer,
    required this.photoFreelancer,
    required this.note,
    this.estFavoris = false,
  });

  // Conversion JSON pour la future connexion avec Django
  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'].toString(),
      titre: json['titre'],
      description: json['description'],
      prix: (json['prix'] as num).toDouble(),
      categorie: json['categorie'],
      image: json['image'] ?? 'https://images.unsplash.com/photo-1626785774573-4b799315345d?q=80&w=1000',
      nomFreelancer: json['nom_freelancer'] ?? 'Freelancer',
      photoFreelancer: json['photo_freelancer'] ?? 'https://randomuser.me/api/portraits/men/1.jpg',
      note: (json['note'] as num? ?? 0.0).toDouble(),
    );
  }
}