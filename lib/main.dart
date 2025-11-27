import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'controller/simon_controller.dart';
import 'view/simon_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => SimonController())],
      child: MaterialApp(
        title: 'Juegos Mentales',
        debugShowCheckedModeBanner: false, //  etiqueta "Debug"
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark, // Tema oscuro global
        ),
        home: const SimonView(),
      ),
    );
  }
}
