import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/service_model.dart';

class ServiceProvider with ChangeNotifier {
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref("services");

  List<ServiceModel> _services = [];
  String _texteRecherche = "";
  bool _isLoading = true;

  ServiceProvider() {
    fetchServicesFromFirebase();
  }

  bool get isLoading => _isLoading;

  List<ServiceModel> get servicesFiltres {
    if (_texteRecherche.isEmpty) return _services;
    return _services
        .where((s) => s.titre.toLowerCase().contains(_texteRecherche.toLowerCase()))
        .toList();
  }

  void fetchServicesFromFirebase() {
    _dbRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;
      if (data != null) {
        _services = data.entries.map((entry) {
          return ServiceModel.fromJson(entry.value as Map, entry.key);
        }).toList();
      } else {
        _services = [];
      }
      _isLoading = false;
      notifyListeners();
    });
  }

  // Fonction pour AJOUTER un service
  Future<void> addService(Map<String, dynamic> serviceData) async {
    try {
      await _dbRef.push().set(serviceData);
    } catch (e) {
      print("Erreur lors de l'ajout: $e");
    }
  }

  // Fonction pour SUPPRIMER un service
  Future<void> deleteService(String id) async {
    try {
      await _dbRef.child(id).remove();
    } catch (e) {
      print("Erreur lors de la suppression: $e");
    }
  }

  void filtrer(String valeur) {
    _texteRecherche = valeur;
    notifyListeners();
  }
}