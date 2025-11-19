import 'package:flutter/material.dart';
import 'pagine/login.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    const Color primaryOrange = Color.fromARGB(255, 216, 141, 71);

    return MaterialApp(
      title: 'StudyFlow',
      debugShowCheckedModeBanner: false, // Rimuove il banner di debug
      theme: ThemeData(
        // Tema Material 3
        useMaterial3: true,
        // Colori principali dell'app
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryOrange, 
          primary: const Color.fromARGB(255, 239, 138, 43),
          secondary: const Color.fromARGB(255, 122, 190, 255), 
        ),
        
        textTheme: const TextTheme(
          
        ),
      ),
      // L'app inizia dalla schermata di Login
      home: const LoginPage(),
    );
  }
}
