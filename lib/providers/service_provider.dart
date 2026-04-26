import 'package:flutter/material.dart';
import '../models/service_model.dart';

class ServiceProvider with ChangeNotifier {
  // Liste privée des services (Base de données locale)
  final List<ServiceModel> _services = [];
  String _texteRecherche = "";

  // Getter pour récupérer les services (avec filtrage par recherche)
  List<ServiceModel> get tousLesServices {
    if (_texteRecherche.isEmpty) {
      return _services;
    }
    return _services
        .where((s) => s.titre.toLowerCase().contains(_texteRecherche.toLowerCase()))
        .toList();
  }

  // --- ACTIONS DU CMS ---

  // 1. Ajouter un service
  void ajouterService(ServiceModel service) {
    _services.add(service);
    notifyListeners(); // Actualise l'interface utilisateur
  }

  // 2. Supprimer un service
  void supprimerService(String id) {
    _services.removeWhere((s) => s.id == id);
    notifyListeners();
  }

  // 3. Mettre à jour la recherche
  void mettreAJourRecherche(String valeur) {
    _texteRecherche = valeur;
    notifyListeners();
  }

  // 4. Trier par prix (du moins cher au plus cher)
  void trierParPrix() {
    _services.sort((a, b) => a.prix.compareTo(b.prix));
    notifyListeners();
  }

  // 5. Inverser l'état favoris
  void toggleFavoris(String id) {
    final index = _services.indexWhere((s) => s.id == id);
    if (index != -1) {
      _services[index].estFavoris = !_services[index].estFavoris;
      notifyListeners();
    }
  }
}