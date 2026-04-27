import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/service_provider.dart';
import '../widgets/service_card.dart';
import 'add_service_screen.dart'; // Assure-toi d'avoir créé ce fichier

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Utilisation de watch pour écouter les changements du Provider
    final provider = context.watch<ServiceProvider>();
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          "Freelance Pro", 
          style: TextStyle(fontWeight: FontWeight.bold)
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Barre de recherche
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) => provider.filtrer(val),
              decoration: InputDecoration(
                hintText: "Rechercher un service...",
                prefixIcon: const Icon(Icons.search, color: Colors.blueAccent),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          
          // Liste des services ou indicateur de chargement
          Expanded(
            child: provider.isLoading 
              ? const Center(child: CircularProgressIndicator()) 
              : provider.servicesFiltres.isEmpty
                  ? const Center(
                      child: Text(
                        "Aucun service trouvé dans la base",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: provider.servicesFiltres.length,
                      itemBuilder: (context, index) {
                        return ServiceCard(service: provider.servicesFiltres[index]);
                      },
                    ),
          ),
        ],
      ),
      
      // Bouton flottant pour ajouter un service (Condition n°2 du projet)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddServiceScreen()),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white, size: 30),
        tooltip: "Ajouter un nouveau service",
      ),
    );
  }
}