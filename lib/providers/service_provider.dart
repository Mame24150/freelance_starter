import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceProvider with ChangeNotifier {
  final List<ServiceModel> _services = [
    ServiceModel(
      id: '1',
      titre: 'Design de Logo Professionnel',
      description: 'Création de logos modernes, épurés et uniques pour votre marque avec tous les fichiers sources inclus.',
      prix: 1500.0,  
      categorie: 'Graphisme',
      image: 'https://images.unsplash.com/photo-1626785774573-4b799315345d?q=80&w=1000', 
      nomFreelancer: 'Ahmed Ali',
      photoFreelancer: 'https://randomuser.me/api/portraits/men/32.jpg',
      note: 4.8,
    ),
    ServiceModel(
      id: '2',
      titre: 'Développement Web Mobile',
      description: 'Conception de sites vitrines et applications web performantes avec Flutter et une interface intuitive.',
      prix: 8500.0,  
      categorie: 'Programmation',
      image: 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=1000',
      nomFreelancer: 'Sarah Mansour',
      photoFreelancer: 'https://randomuser.me/api/portraits/women/44.jpg',
      note: 4.9,
    ),
  ];

  String _texteRecherche = "";

  List<ServiceModel> get servicesFiltres {
    if (_texteRecherche.isEmpty) return _services;
    return _services
        .where((s) => s.titre.toLowerCase().contains(_texteRecherche.toLowerCase()))
        .toList();
  }

  void filtrer(String valeur) {
    _texteRecherche = valeur;
    notifyListeners();
  }
}