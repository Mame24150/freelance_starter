import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/service_provider.dart';
import '../widgets/service_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Écoute des changements dans le ServiceProvider
    final provider = context.watch<ServiceProvider>();
    
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text("Freelance Pro", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Barre de recherche stylisée
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: (val) => provider.filtrer(val),
              decoration: InputDecoration(
                hintText: "Rechercher un service...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          // Liste dynamique des services
          Expanded(
            child: ListView.builder(
              itemCount: provider.servicesFiltres.length,
              itemBuilder: (context, index) {
                return ServiceCard(service: provider.servicesFiltres[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}