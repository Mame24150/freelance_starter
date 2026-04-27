import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'providers/service_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  // 1. Assure l'initialisation des widgets Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialisation spécifique pour le Web (indispensable pour Chrome)
  // Remplace les valeurs ci-dessous par celles de ton projet Firebase
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "TON_API_KEY_ICI", // Trouve-la dans Paramètres du projet > Général
      appId: "TON_APP_ID_ICI",   // Trouve-le dans Paramètres du projet > Général
      messagingSenderId: "TON_SENDER_ID",
      projectId: "freelanceapp-e4364",
      databaseURL: "https://freelanceapp-e4364-default-rtdb.firebaseio.com/",
    ),
  );

  runApp(
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
      debugShowCheckedModeBanner: false,
      title: 'Freelance Pro',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
      ),
      // L'écran qui s'affiche au démarrage
      home: const HomeScreen(), 
    );
  }
}