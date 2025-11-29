
import 'package:flutter/cupertino.dart';

class ControladorPalanca extends ChangeNotifier {
  bool _modoOscuro = false;

  bool get modoOscuro => _modoOscuro;

  set modoOscuro(bool value) {
    _modoOscuro = value;
  }

  void palanca(bool value) {
    _modoOscuro = value;
    notifyListeners();
  }
}