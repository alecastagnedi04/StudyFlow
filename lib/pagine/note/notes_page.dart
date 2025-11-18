import 'package:flutter/material.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final notes = [
      'Idea progetto Ricerca Operativa',
      'Riassunto capitolo Reti di Calcolatori',
      'Punti chiave Automatica orale',
    ];

    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.separated(
        itemBuilder: (context, index) {
          final note = notes[index];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text(note),
              subtitle: const Text('Nota veloce'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () {
                // TODO: apri / modifica nota
              },
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemCount: notes.length,
      ),
    );
  }
}
