import 'package:flutter/material.dart';

class DevsView extends StatelessWidget {
  const DevsView({super.key});

  // Lista de datos de tu equipo (Simulando una pequeña base de datos)
  final List<Map<String, String>> _developers = const [
    {'name': 'Randol', 'role': 'Team Leader / Scrum Master', 'initials': 'RL'},
    {'name': 'Estudiante 2', 'role': 'Lógica & Backend', 'initials': 'E2'},
    {'name': 'Estudiante 3', 'role': 'UI/UX Designer', 'initials': 'E3'},
    {'name': 'Estudiante 4', 'role': 'Frontend Developer', 'initials': 'E4'},
    {'name': 'Estudiante 5', 'role': 'QA / Testing', 'initials': 'E5'},
    {'name': 'Estudiante 6', 'role': 'Documentación', 'initials': 'E6'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Equipo de Desarrollo'),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      // Usamos ListView.builder para crear las tarjetas automáticamente
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: _developers.length,
          itemBuilder: (context, index) {
            final dev = _developers[index];

            return Card(
              elevation: 4, // Sombra para efecto 3D
              margin: const EdgeInsets.symmetric(vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                // Ícono circular con iniciales
                leading: CircleAvatar(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  child: Text(dev['initials']!),
                ),
                // Nombre
                title: Text(
                  dev['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                // Rol
                subtitle: Text(dev['role']!),
                // Ícono al final (decorativo)
                trailing: const Icon(Icons.code, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
