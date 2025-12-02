import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simondice_proy/view/rules_view.dart';
import 'package:simondice_proy/controller/switch.dart';
import 'controller/simon_controller.dart';
import 'view/simon_view.dart';
import 'view/devs_view.dart';

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


        initialRoute: '/',

        routes: {
          '/': (context) => const SimonView(),
          '/devs': (context) => const DevsView(),
          '/rules': (context) => RulesView(),
        },
      ),
    );
  }
}
