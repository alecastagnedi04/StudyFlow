import 'package:flutter/material.dart';

// Definizione del widget StatelessWidget
class DurationButtonsBox extends StatelessWidget {
  // 1. Variabili di stato necessarie dal genitore
  final int minutiSelezionati;
  final void Function(int) onDurationSelected;
  
  // 2. Colore per l'UI
  static const Color primaryOrange = Color.fromARGB(255, 255, 186, 122); 

  const DurationButtonsBox({
    super.key,
    required this.minutiSelezionati,
    required this.onDurationSelected,
  });

  // Funzione helper per costruire il singolo pulsante
  Widget _buildDurationButton(int minuti) {
    final bool isSelected = minutiSelezionati == minuti;

    return ElevatedButton(
      onPressed: () => onDurationSelected(minuti), // Chiama il callback del genitore
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? primaryOrange : Colors.grey.shade200, 
        foregroundColor: isSelected ? Colors.white : Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: isSelected ? BorderSide.none : BorderSide(color: Colors.grey.shade400)
        ),
        elevation: isSelected ? 4 : 0,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      ),
      child: Text('${minuti}m'),
    );
  }
  
  // Funzione helper per costruire la Box
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: primaryOrange.withOpacity(0.2), 
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildDurationButton(25),
          const SizedBox(width: 6),
          _buildDurationButton(60),
          const SizedBox(width: 6),
          _buildDurationButton(90),
        ],
      ),
    );
  }
}