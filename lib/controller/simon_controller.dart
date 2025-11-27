import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

enum GameState { idle, showingSequence, input, gameOver }

class SimonController extends ChangeNotifier {
  // --- ESTADO DEL JUEGO ---
  GameState _state = GameState.idle;

  // LA "PILA" DE MEMORIA (Stack)
  // Almacena la secuencia correcta. Dart usa List, que funciona como Stack.
  // Métodos: .add() es como PUSH.
  List<int> _sequenceStack = [];

  // Puntero para saber en qué paso de la pila va el usuario
  int _userCurrentStep = 0;

  int _score = 0;

  // Controla qué botón brilla (-1 significa ninguno)
  int _activeLightIndex = -1;

  // --- GETTERS (Para que la Vista lea) ---
  GameState get state => _state;
  List<int> get sequence => _sequenceStack; // Opcional, para debug
  int get score => _score;
  int get activeLightIndex => _activeLightIndex;

  // --- LÓGICA ---

  // 1. Iniciar Juego: Limpiamos la pila
  void startGame() {
    _sequenceStack.clear();
    _score = 0;
    _state = GameState.idle;
    notifyListeners();
    _nextRound();
  }

  // 2. Nueva Ronda: Apilamos (Push) un nuevo color
  Future<void> _nextRound() async {
    _state = GameState.showingSequence;
    _userCurrentStep = 0; // Reseteamos el puntero del usuario
    notifyListeners();

    // LÓGICA DE PILA: Hacemos PUSH de un nuevo color aleatorio (0 al 3)
    // 0: Rojo, 1: Verde, 2: Azul, 3: Amarillo
    _sequenceStack.add(Random().nextInt(4));

    // Pequeña pausa antes de mostrar
    await Future.delayed(const Duration(seconds: 1));

    // Reproducimos toda la pila actual
    await _playSequence();

    // Habilitamos al usuario
    _state = GameState.input;
    notifyListeners();
  }

  // 3. Reproducir Secuencia: Recorre la pila y enciende luces
  Future<void> _playSequence() async {
    for (int colorIndex in _sequenceStack) {
      // Encender
      _activeLightIndex = colorIndex;
      notifyListeners();

      // Esperar encendido
      await Future.delayed(const Duration(milliseconds: 500));

      // Apagar
      _activeLightIndex = -1;
      notifyListeners();

      // Pausa entre luces
      await Future.delayed(const Duration(milliseconds: 250));
    }
  }

  // 4. Input del Usuario: Validar contra la pila

  //error al tocar mas veces de la cuenta
  void handleInput(int buttonIndex) async {
    // Si no es turno del usuario, ignoramos
    if (_state != GameState.input) return;

    // Feedback visual (Flash rápido al tocar)
    _flashButton(buttonIndex);

    // VALIDACIÓN:
    // Comparamos el botón tocado con el valor en la pila en la posición actual
    if (buttonIndex == _sequenceStack[_userCurrentStep]) {
      // ¡Correcto! Avanzamos el puntero
      _userCurrentStep++;

      // ¿Llegamos al final de la pila?
      if (_userCurrentStep == _sequenceStack.length) {
        _score++;
        notifyListeners();
        // Siguiente ronda después de un respiro
        await Future.delayed(const Duration(milliseconds: 1000));
        _nextRound();
      }
    } else {
      // ¡Incorrecto! Game Over
      _state = GameState.gameOver;
      notifyListeners();
    }
  }

  // Helper para efecto visual al tocar
  Future<void> _flashButton(int index) async {
    _activeLightIndex = index;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 150));
    _activeLightIndex = -1;
    notifyListeners();
  }
}
