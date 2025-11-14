import 'package:flutter/material.dart';
import 'pagine/MainPage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // 1. Contiene la pagina iniziale da mostrare
      home: const Mainpage(), // è la classe di timer_page.dart

      // 2. Contiene il TEMA (stile) di tutta l'app
      theme: ThemeData(
        // D'ora in poi, ogni AppBar sarà viola
        appBarTheme: AppBarTheme(
          backgroundColor: const Color.fromARGB(255, 255, 186, 122),
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold), 
        ),
        // D'ora in poi, ogni pulsante sarà arancione
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
          ),
        ),
      ),

      // 3. Contiene il titolo (che vede il sistema operativo)
      title: 'StudyFlow',

      // 4. Contiene l'impostazione per togliere la striscia "Debug"
      debugShowCheckedModeBanner: false,
    );
  }
}