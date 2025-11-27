import 'dart:async'; // Necesario para los retrasos (Future.delayed)
import 'dart:math'; // Necesario para el generador de números aleatorios (Random)
import 'package:flutter/material.dart';

// ESTADOS DEL JUEGO
enum GameState {
  idle, // El juego está quieto esperando "Iniciar"
  showingSequence, // La CPU está mostrando las luces
  input, // Es el turno del jugador
  gameOver, // El jugador perdió
}

class SimonController extends ChangeNotifier {
  // --- VARIABLES DE MEMORIA

  // 1. La lista maestra de colores que Simón ha inventado hasta ahora.
  // Es como una pila de platos: cada ronda agregamos uno encima.
  List<int> _listaDeColoresCorrectos = [];

  // 2. ¿En qué paso va el usuario actualmente?
  // Si la lista tiene 5 colores, el usuario empieza en el paso 0, luego 1, etc.
  int _pasoActualDelUsuario = 0;

  // 3. Puntaje y Estado general
  int _puntaje = 0;
  GameState _estado = GameState.idle;

  // 4. ¿Qué luz está encendida AHORA MISMO? (-1 significa "todas apagadas")
  // Esto es lo único que la Vista necesita mirar para saber qué dibujar.
  int _luzEncendida = -1;

  // --- GETTERS (La Ventanilla de Información) ---
  // La Vista usa esto para leer los datos sin poder modificarlos directamente.
  GameState get state => _estado;
  int get score => _puntaje;
  int get activeLightIndex =>
      _luzEncendida; // La vista pregunta: "¿Quién brilla?"

  // --- FUNCIONES DEL JUEGO (La Lógica) ---

  // PASO 1: Empezar desde cero
  void startGame() {
    _listaDeColoresCorrectos.clear(); // Borramos la memoria
    _puntaje = 0;
    _estado = GameState.idle;
    notifyListeners(); // ¡Avisar a la vista!

    // Arrancamos la primera ronda
    _siguienteRonda();
  }

  // PASO 2: Preparar la nueva ronda (Agregar un color más)
  Future<void> _siguienteRonda() async {
    _estado = GameState.showingSequence; // Estado de mostrar secuencia
    _pasoActualDelUsuario = 0; // Reiniciamos el contador del usuario
    notifyListeners();

    // LÓGICA DE PILA (STACK): Agregamos un nuevo color aleatorio a la cima.
    // Genera un número entre 0 y 3 (0:Verde, 1:Rojo, 2:Azul, 3:Amarillo)
    int nuevoColor = Random().nextInt(4);
    _listaDeColoresCorrectos.add(nuevoColor);

    // Esperamos 1 segundo antes de empezar a mostrar para que no sea brusco
    await Future.delayed(const Duration(seconds: 1));

    // Reproducimos toda la lista de memoria para que el usuario la vea
    await _reproducirSecuencia();

    // ¡Listo! Ahora es turno del humano
    _estado = GameState.input;
    notifyListeners();
  }

  // PASO 3: El Show de Luces (Recorre la lista y enciende bombillas)
  Future<void> _reproducirSecuencia() async {
    // Recorremos cada color guardado en la memoria
    for (int color in _listaDeColoresCorrectos) {
      // A) Encender luz
      _luzEncendida = color;
      notifyListeners(); // ¡Vista, dibuja el color brillante!

      // B) Esperar medio segundo con la luz prendida
      await Future.delayed(const Duration(milliseconds: 500));

      // C) Apagar luz
      _luzEncendida = -1;
      notifyListeners(); // ¡Vista, apaga todo!

      // D) Pequeña pausa antes del siguiente color
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  // PASO 4: El usuario toca un botón
  void handleInput(int botonTocado) async {
    // Si no es el turno del usuario, ignoramos el toque (protección)
    if (_estado != GameState.input) return;

    // Efecto visual: Hacemos parpadear el botón que tocó el usuario
    _parpadearBoton(botonTocado);

    // --- VALIDACIÓN CENTRAL ---

    // Pregunta: ¿El botón que tocó es IGUAL al que dice la memoria en este paso?
    int colorCorrecto = _listaDeColoresCorrectos[_pasoActualDelUsuario];

    if (botonTocado == colorCorrecto) {
      // ¡BIEN! El usuario acertó este color.
      _pasoActualDelUsuario++; // Avanzamos al siguiente escalón

      // Pregunta: ¿Ya terminó toda la secuencia de esta ronda?
      if (_pasoActualDelUsuario == _listaDeColoresCorrectos.length) {
        // ¡Ronda completada!
        _puntaje++;
        notifyListeners();

        // Esperamos un momento y lanzamos la siguiente ronda más difícil
        await Future.delayed(const Duration(milliseconds: 1000));
        _siguienteRonda();
      }
    } else {
      // ¡MAL! Se equivocó.
      _estado = GameState.gameOver;
      notifyListeners();
      // Aquí el juego se detiene hasta que presionen "Iniciar Juego" de nuevo.
    }
  }

  // Función auxiliar solo para efectos visuales rápidos
  Future<void> _parpadearBoton(int indice) async {
    _luzEncendida = indice;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 150));
    _luzEncendida = -1;
    notifyListeners();
  }
}
