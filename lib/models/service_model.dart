class ServiceModel {
  final String id;
  final String titre;
  final String description;
  final double prix;
  final String categorie;
  bool estFavoris;

  ServiceModel({
    required this.id,
    required this.titre,
    required this.description,
    required this.prix,
    required this.categorie,
    this.estFavoris = false,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'],
      titre: json['titre'],
      description: json['description'],
      prix: json['prix'].toDouble(),
      categorie: json['categorie'],
    );
  }
}