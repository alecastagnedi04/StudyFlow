import 'package:flutter/material.dart';
import 'dart:async'; 
// Assicurati che questi import puntino ai file corretti nel tuo progetto
import 'pomodoro_buttons.dart';
import 'pomodoro_shape.dart';
import 'subj_list.dart';
import 'bottoni_durata.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});
  
  @override
  State<TimerPage> createState() => _TimerState();
}

class _TimerState extends State<TimerPage> {
  String? _materiaSelezionata;
  int _minutiSelezionati = 25;
  late int _durataInSecondi; 
  late int _secondiRimanenti;
  bool _attivo = false;
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

  void _selezionaDurata(int minuti) {
    if (_attivo) return;

    setState(() {
      _minutiSelezionati = minuti;
      _durataInSecondi = minuti * 60;
      _secondiRimanenti = _durataInSecondi;
    });
  }

  void _avviaPausa() {
    if (_attivo) {
      _timer?.cancel();
      setState(() {
        _attivo = false;
      });
    } else {
      setState(() {
        _attivo = true;
      });
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_secondiRimanenti > 0) {
          setState(() {
            _secondiRimanenti--;
          });
        } else {
          _timer?.cancel();
          _resetTimer();
        }
      });
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    setState(() {
      _secondiRimanenti = _durataInSecondi;
      _attivo = false;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formattaTempo(int secondi) {
    final minuti = (secondi ~/ 60).toString().padLeft(2, '0');
    final sec = (secondi % 60).toString().padLeft(2, '0');
    return '$minuti:$sec';
  }

  // Calcola una percentuale da 0.0 a 1.0 per il cerchio
  double _calcolaProgresso() {
    if (_durataInSecondi == 0) return 0.0;
    // Formula per far riempire/svuotare il cerchio
    return (_durataInSecondi - _secondiRimanenti) / _durataInSecondi;
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryOrange = Color.fromARGB(255, 255, 186, 122); 
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _materiaSelezionata ?? 'Timer Pomodoro',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: primaryOrange,
        elevation: 1,
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SizedBox(
            // Altezza dinamica sicura
            height: MediaQuery.of(context).size.height - AppBar().preferredSize.height - MediaQuery.of(context).padding.top - 20,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                
                const SizedBox(height: 30),
                DurationButtonsBox(
                    minutiSelezionati: _minutiSelezionati,
                    onDurationSelected: _selezionaDurata,
                ),
                
                const SizedBox(height: 50),

                // 2. Display del Timer
                // Qui chiamiamo PomodoroShape con i parametri corretti per la versione "stabile"
                PomodoroShape(
                  tempoFormattato: _formattaTempo(_secondiRimanenti),
                  progresso: _calcolaProgresso(),
                ),
                
                const SizedBox(height: 40),

                PomodoroButtons(
                  attivo: _attivo,
                  onAvviaPausa: _avviaPausa,
                  onReset: _resetTimer,
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