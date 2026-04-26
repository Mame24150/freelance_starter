import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/service_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(
    // Liaison de l'application avec le Provider pour la gestion des données
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ServiceProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Supprime la bannière "Debug"
      title: 'Freelance Pro',
      theme: ThemeData(
        useMaterial3: true, // Active le design moderne (Material 3)
        colorSchemeSeed: Colors.indigo, // Définit la couleur principale
      ),
      // Définit l'écran d'accueil sur notre HomeScreen
      home: const HomeScreen(), 
    );
  }
}