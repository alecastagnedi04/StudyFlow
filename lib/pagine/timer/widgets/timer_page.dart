import 'package:flutter/material.dart';
import 'dart:async'; 
import 'pomodoro_buttons.dart';
import 'pomodoro_shape.dart';
import 'subj_list.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});
  
  @override
  State<TimerPage> createState() => _TimerState();
}

class _TimerState extends State<TimerPage> {
  String? _materiaSelezionata;
  
  final double _maxMinuti = 120.0;
  
  // STATO
  int _minutiSelezionati = 25; 
  int _minutiPausa = 5; 
  
  late int _durataInSecondi;   
  late int _secondiRimanenti;  
  
  bool _attivo = false;
  bool _inPausa = false; 
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _durataInSecondi = _minutiSelezionati * 60;
    _secondiRimanenti = _durataInSecondi;
  }

  void _selezioneMateria(String materia) {
    setState(() {
      _materiaSelezionata = (_materiaSelezionata == materia) ? null : materia;
    });
  }

  // --- GESTIONE TEMPO ---

  void _cambiaDurata(int minuti) {
    if (minuti < 1) minuti = 1;
    if (_inPausa) {
       _resetTimer();
    }
    setState(() {
      _minutiSelezionati = minuti;
      if (!_attivo && !_inPausa) {
        _durataInSecondi = minuti * 60;
        _secondiRimanenti = _durataInSecondi;
      }
    });
  }

  void _cambiaPausa(int minuti) {
    setState(() {
      _minutiPausa = minuti;
    });
  }

  void _cambiaDurataDaSlider(double valoreSlider) {
    _cambiaDurata(valoreSlider.toInt());
  }

  // --- LOGICA TIMER ---

  void _avviaTimerSistema() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondiRimanenti > 0) {
        setState(() {
          _secondiRimanenti--;
        });
      } else {
        _timer?.cancel();
        _gestisciFineTimer();
      }
    });
  }

  void _gestisciFineTimer() {
    if (!_inPausa && _minutiPausa > 0) {
      // Passaggio a PAUSA
      setState(() {
        _inPausa = true; 
        _durataInSecondi = _minutiPausa * 60; 
        _secondiRimanenti = _durataInSecondi;
        _attivo = true; 
      });
      _avviaTimerSistema(); 
    } else {
      // Fine PAUSA o fine sessione senza pausa
      _resetTimer();
    }
  }

  void _toggleAvviaPausa() {
    if (_attivo) {
      _timer?.cancel();
      setState(() {
        _attivo = false;
      });
    } else {
      setState(() {
        _attivo = true;
      });
      _avviaTimerSistema();
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _attivo = false;
      _inPausa = false; 
      _durataInSecondi = _minutiSelezionati * 60;
      _secondiRimanenti = _durataInSecondi;
    });
  }

  // --- UI SETTINGS ---
  
  void _mostraImpostazioni(BuildContext context) {
    const Color primaryOrange = Color.fromARGB(255, 255, 186, 122); 

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
      ),
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 50, height: 5,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  const SizedBox(height: 25),
                  
                  const Text("⏱️ Durata Sessione", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [25, 60, 90, 120].map((durata) {
                        final bool isSelected = _minutiSelezionati == durata;
                        return Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: ChoiceChip(
                            label: Text('${durata} min'),
                            selected: isSelected,
                            selectedColor: primaryOrange,
                            backgroundColor: Colors.grey.shade100,
                            labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                            onSelected: (_) {
                              _cambiaDurata(durata);
                              setModalState(() {}); 
                              Navigator.pop(ctx); 
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),

                  const SizedBox(height: 30),

                  const Text("☕ Durata Pausa", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  Row(
                    children: [0, 5, 10, 15].map((pausa) {
                      final bool isSelected = _minutiPausa == pausa;
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: ChoiceChip(
                          label: Text(pausa == 0 ? 'No' : '${pausa} min'),
                          selected: isSelected,
                          selectedColor: Colors.tealAccent.shade700,
                          backgroundColor: Colors.grey.shade100,
                          labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black87),
                          onSelected: (_) {
                            _cambiaPausa(pausa);
                            setModalState(() {});
                          },
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          }
        );
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color.fromARGB(255, 255, 186, 122); 
    //const Color pauseGreen = Color.fromARGB(255, 100, 200, 180);
    // Usiamo un Teal più acceso per la pausa, si legge meglio sul bianco
    const Color pauseGreen = Color.fromARGB(255, 26, 188, 156);

    // CALCOLO COLORI E STATI
    double valoreSlider;
    double maxValoreSlider;
    String etichettaShape;
    Color coloreCorrente; // Questo colore andrà sia allo Shape che al Bottone

    if (_attivo || _inPausa) {
      // Timer in corso
      valoreSlider = _secondiRimanenti / 60.0;
      maxValoreSlider = _durataInSecondi / 60.0; 
      
      if (_inPausa) {
        etichettaShape = "PAUSA";
        coloreCorrente = pauseGreen;
      } else {
        etichettaShape = "FOCUS";
        coloreCorrente = primaryOrange;
      }
    } else {
      // Timer fermo (Impostazione)
      valoreSlider = _minutiSelezionati.toDouble();
      maxValoreSlider = _maxMinuti;
      etichettaShape = "IMPOSTA";
      coloreCorrente = primaryOrange;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _materiaSelezionata ?? 'Timer Pomodoro',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: coloreCorrente, // Anche l'AppBar cambia colore!
        elevation: 1,
        centerTitle: true,
      ),
      
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: SizedBox(
            height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - 40,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
                const SizedBox(height: 40),

                PomodoroShape(
                  valoreCorrente: valoreSlider,
                  maxValore: maxValoreSlider,
                  interattivo: !_attivo && !_inPausa, 
                  etichetta: etichettaShape,
                  colore: coloreCorrente,
                  onChanged: _cambiaDurataDaSlider,
                ),
                
                const SizedBox(height: 10),

                if (_minutiPausa > 0 && !_inPausa)
                  Text(
                    "Seguirà pausa di $_minutiPausa min",
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
                  ),

                const SizedBox(height: 40),

                PomodoroButtons(
                  attivo: _attivo,
                  coloreAttivo: coloreCorrente, // ✅ Passiamo il colore qui
                  onAvviaPausa: _toggleAvviaPausa,
                  onReset: _resetTimer,
                  onImpostazioni: () => _mostraImpostazioni(context),
                ),
                
                const Spacer(), 

                SubjectList(
                    selectedSubject: _materiaSelezionata, 
                    onSubjectSelected: _selezioneMateria,
                ),
                const SizedBox(height: 20), 
              ],
            ),
          ),
        ),
      ),
    );
  }
}