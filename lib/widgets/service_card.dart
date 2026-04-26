import 'package:flutter/material.dart';
import '../models/service_model.dart';
import '../screens/service_details_screen.dart';

class ServiceCard extends StatelessWidget {
  final ServiceModel service;
  const ServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Navigation vers les détails quand on clique sur la carte
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ServiceDetailsScreen(service: service),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          children: [
            // Barre décorative supérieure
            Container(
              height: 5,
              decoration: const BoxDecoration(
                color: Colors.indigoAccent,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
            
            // Partie 1 : Informations sur le Service
            ListTile(
              contentPadding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              title: Text(
                service.titre,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              subtitle: Text(
                service.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Text(
                "${service.prix} MRU",
                style: const TextStyle(
                  color: Colors.green, 
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),

            // Séparateur discret
            const Divider(height: 1, indent: 20, endIndent: 20),

            // Partie 2 : Infos du Freelancer (L'aspect "Humain")
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                children: [
                  // Photo de profil circulaire
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(service.photoFreelancer),
                    backgroundColor: Colors.grey[200],
                  ),
                  const SizedBox(width: 10),
                  // Nom du Freelancer
                  Expanded(
                    child: Text(
                      service.nomFreelancer,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  // Note avec étoile
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.amber.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          service.note.toString(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}