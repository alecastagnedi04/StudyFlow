import 'package:flutter/material.dart';
import 'dart:math'; // Necessario per la generazione di colori randomici

// ✅ MODIFICA 1: Aggiungi i parametri del genitore (TimerPage)
class SubjectList extends StatefulWidget {
  final String? selectedSubject; // Lo stato di selezione dal padre
  final ValueChanged<String> onSubjectSelected; // La funzione di callback
  
  const SubjectList({
    super.key,
    required this.selectedSubject,
    required this.onSubjectSelected,
  });

  @override
  State<SubjectList> createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  // Colore principale (per il pulsante Aggiungi)
  static const Color primaryOrange = Color.fromARGB(255, 255, 186, 122); 
  
  // STATO INTERNO
  List<String> _materie = ['Matematica', 'Storia', 'Inglese'];  // lista base di materie per la scelta
  Map<String, Color> _coloriMateria = {}; // Mappa materia -> Colore unico

  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    // Inizializza i colori per le materie predefinite all'avvio
    for (var materia in _materie) {
      _assegnaColore(materia);
    }
  }

  // logica colore randomico selezione

  void _assegnaColore(String materia) {
    Color newColor;
    do {
      newColor = Color.fromARGB(
        255, 
        _random.nextInt(200),
        _random.nextInt(200), 
        _random.nextInt(200),
      );
    } while (newColor.computeLuminance() > 0.7);

    _coloriMateria[materia] = newColor;
  }

  void _aggiungiMateria(String nuovaMateria) {
    setState(() {
      _materie.add(nuovaMateria);
      _assegnaColore(nuovaMateria); 
    });
  }




  // colore/bordo
  Widget _buildMateriaButton(String materia) {

    final bool isSelected = widget.selectedSubject == materia; 
    final Color materiaColor = _coloriMateria[materia] ?? Colors.blueGrey;
    
    // Definisce i colori del testo e dello sfondo in base allo stato
    final Color textColor = isSelected ? materiaColor : Colors.black87; 
    final Color backgroundColor = isSelected ? materiaColor.withOpacity(0.1) : Colors.white;

    return OutlinedButton(
      // Chiama il callback del padre invece di modificare lo stato interno
      onPressed: () => widget.onSubjectSelected(materia), 
      
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        backgroundColor: backgroundColor,
        foregroundColor: textColor,
        
        // Bordo arrotondato
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        // il bordo usa il colore randomico della materia quando selezionata
        side: BorderSide(
          color: isSelected ? materiaColor : Colors.grey.shade300, 
          width: isSelected ? 2.0 : 1.0, 
        ),
      ),
      child: Text(
        materia, 
        style: TextStyle(
          color: textColor, 
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildAddButton(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: () => _showAddMateriaDialog(context),
      icon: const Icon(Icons.add, size: 18),
      label: const Text('Aggiungi'),
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.grey,
        side: const BorderSide(color: Colors.grey, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
  
  void _showAddMateriaDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

//aggiunta materie nuove
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Aggiungi Materia'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(labelText: 'Nome della materia'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: const Text('Annulla'),
          ),
          TextButton(
            onPressed: () {
              final String nuovaMateria = controller.text.trim();
              if (nuovaMateria.isNotEmpty) {
                _aggiungiMateria(nuovaMateria);
              }
              Navigator.of(ctx).pop();
            },
            child: const Text('Aggiungi'),
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    
    return Container(
      width: MediaQuery.of(context).size.width * 0.85, 
      padding: const EdgeInsets.all(20), 
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(15), 
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, 
        children: [
          const Text(
            'Seleziona una materia:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 15),
          
          Wrap(
            spacing: 10, 
            runSpacing: 10, 
            children: [
              _buildAddButton(context), 
              
              
              ..._materie.map((materia) => _buildMateriaButton(materia)).toList(),
            ],
          ),
        ],
      ),
    );
  }
}