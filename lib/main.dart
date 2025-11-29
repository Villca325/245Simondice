import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simondice_proy/view/switch.dart';

// Importamos las vistas
import 'controller/simon_controller.dart';
import 'view/simon_view.dart';
import 'view/devs_view.dart'; // Importamos

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => Controlador()),
      ChangeNotifierProvider(create: (_) => ControladorPalanca())],
      child: MaterialApp(
        title: 'Juegos Mentales',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.deepPurple,
          brightness: Brightness.dark,
        ),

        // --- SISTEMA DE RUTAS ---

        // 1. Ruta Inicial: ¿Qué pantalla se abre primero?
        initialRoute: '/',

        // 2. Tabla de Rutas: Nombres -> Pantallas
        routes: {
          '/': (context) => const SimonView(),
          '/devs': (context) => const DevsView(), // <--- NUEVA RUTA REGISTRADA
        },
      ),
    );
  }
}
