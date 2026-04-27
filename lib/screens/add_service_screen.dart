import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/service_provider.dart';

class AddServiceScreen extends StatefulWidget {
  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Contrôleurs pour les champs de texte
  final _titreCtrl = TextEditingController();
  final _prixCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _nomFreelancerCtrl = TextEditingController();

  bool _enCoursDeChargement = false;

  // Fonction de sauvegarde avec liens automatiques
  Future<void> _sauvegarder() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _enCoursDeChargement = true);

      // 1. Image de couverture : Image pro d'informatique (via Unsplash)
      String urlService = 'https://images.unsplash.com/photo-1498050108023-c5249f4df085?q=80&w=800&auto=format&fit=crop'; 
      
      // 2. Photo de profil : Avatar Cartoon unique (via DiceBear)
      // On utilise le nom du freelancer pour générer un avatar différent à chaque fois
      String uniqueSeed = _nomFreelancerCtrl.text.trim().replaceAll(' ', '');
      String urlProfil = 'https://api.dicebear.com/7.x/avataaars/png?seed=$uniqueSeed';

      try {
        final serviceData = {
          'titre': _titreCtrl.text.trim(),
          'prix': double.tryParse(_prixCtrl.text) ?? 0.0,
          'description': _descCtrl.text.trim(),
          'categorie': 'Programmation & Tech',
          'image': urlService, // Lien direct vers l'image de code
          'nomFreelancer': _nomFreelancerCtrl.text.trim(),
          'photoFreelancer': urlProfil, // Lien direct vers le visage cartoon
          'note': 5.0,
        };

        // Envoi des données vers Realtime Database (Gratuit et sans restriction)
        await Provider.of<ServiceProvider>(context, listen: false).addService(serviceData);
        
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Service publié avec succès !"), 
              backgroundColor: Colors.green
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Erreur de connexion à la base de données"), 
              backgroundColor: Colors.red
            ),
          );
        }
      } finally {
        if (mounted) setState(() => _enCoursDeChargement = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nouveau Service Tech", style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 0,
      ),
      body: _enCoursDeChargement 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 15),
                Text("Enregistrement en cours..."),
              ],
            ),
          )
        : SingleChildScrollView(
            padding: EdgeInsets.all(25),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Information sur la génération automatique des images
                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.auto_awesome, color: Colors.blue[800]),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "Les images (votre avatar cartoon et le visuel technique) seront générées automatiquement pour ce service.",
                            style: TextStyle(color: Colors.blue[900], fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  SizedBox(height: 30),
                  
                  // Champs de saisie
                  _buildInputField(_titreCtrl, "Titre du service (ex: Développeur Flutter)", Icons.code),
                  _buildInputField(_prixCtrl, "Prix (en MRU)", Icons.payments, isNumber: true),
                  _buildInputField(_nomFreelancerCtrl, "Votre nom d'expert", Icons.person_outline),
                  _buildInputField(_descCtrl, "Description des prestations", Icons.description_outlined, maxLines: 4),
                  
                  SizedBox(height: 40),
                  
                  ElevatedButton(
                    onPressed: _sauvegarder,
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity, 60),
                      backgroundColor: Colors.blue[800],
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      elevation: 4,
                    ),
                    child: Text(
                      "PUBLIER LE SERVICE",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  // Widget pour créer les champs de texte proprement
  Widget _buildInputField(TextEditingController ctrl, String label, IconData icon, {bool isNumber = false, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: ctrl,
        maxLines: maxLines,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.blue[800]),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.blue, width: 2)),
        ),
        validator: (v) => v!.isEmpty ? "Veuillez remplir ce champ" : null,
      ),
    );
  }
}