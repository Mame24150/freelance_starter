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

  // Correction pour correspondre aux clés Firebase et éviter les erreurs de type
  factory ServiceModel.fromJson(Map<dynamic, dynamic> json, String key) {
    return ServiceModel(
      id: key, // On utilise la clé unique de Firebase comme ID
      titre: json['titre'] ?? '',
      description: json['description'] ?? '',
      prix: (json['prix'] as num? ?? 0.0).toDouble(),
      categorie: json['categorie'] ?? '',
      image: json['image'] ?? 'https://images.unsplash.com/photo-1626785774573-4b799315345d?q=80&w=1000',
      nomFreelancer: json['nomFreelancer'] ?? 'Freelancer', // Changé nom_freelancer -> nomFreelancer
      photoFreelancer: json['photoFreelancer'] ?? 'https://randomuser.me/api/portraits/men/1.jpg', // Changé photo_freelancer -> photoFreelancer
      note: (json['note'] as num? ?? 0.0).toDouble(),
    );
  } 
}