import 'package:flutter/material.dart';

class CalendarioPage extends StatelessWidget {
  const CalendarioPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Qui in futuro potrai mettere un vero calendario
    return const Center(
      child: Text(
        'Calendario di studio\n(da collegare a esami / sessioni)',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}
