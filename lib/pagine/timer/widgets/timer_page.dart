import 'package:flutter/material.dart';

class TimerPage extends StatelessWidget {
  const TimerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Timer Pomodoro'),
      ),
      body: const Center(
        child: Text(
          'Qui in futuro metteremo il timer Pomodoro\n'
          '(25 minuti studio / 5 minuti pausa).',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
