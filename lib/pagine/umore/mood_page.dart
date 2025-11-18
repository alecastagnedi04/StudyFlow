import 'package:flutter/material.dart';

class MoodPage extends StatelessWidget {
  const MoodPage({super.key});

  @override
  Widget build(BuildContext context) {
    final moods = [
      {'label': '😊 Felice', 'icon': Icons.sentiment_satisfied},
      {'label': '😐 Neutra', 'icon': Icons.sentiment_neutral},
      {'label': '😣 Stressata', 'icon': Icons.sentiment_dissatisfied},
      {'label': '😴 Stanca', 'icon': Icons.bedtime},
    ];

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tracking dell\'umore',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Come ti senti oggi rispetto allo studio?',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: moods.map((mood) {
              return Chip(
                avatar: Icon(mood['icon'] as IconData, size: 18),
                label: Text(mood['label'] as String),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          const Text(
            'In futuro potrai salvare l\'umore giornaliero\n'
            'e vedere le statistiche nel tempo.',
            style: TextStyle(fontSize: 14),
          ),
        ],
      ),
    );
  }
}
