import 'package:flutter/material.dart';

// Per ora, è un widget "stupido" che mostra
// una lista fissa di materie.
class SubjectList extends StatelessWidget {
  const SubjectList({super.key});

  @override
  Widget build(BuildContext context) {
    // Usiamo una Column per impilare le materie
    return Column(
      children: [
        const Text(
          'Seleziona una materia:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pulsante finto per una materia
            ElevatedButton(
              onPressed: () {
                // In futuro, questo selezionerà "Matematica"
              },
              child: const Text(
                'Matematica',
                style:TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10),
            // Pulsante finto per un'altra materia
            ElevatedButton(
              onPressed: () {
                // In futuro, questo selezionerà "Storia"
              },
              child: const Text(
                'Storia',
                style:TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}