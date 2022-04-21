import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MenaInfo extends StatelessWidget {
  const MenaInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/mena.jpg',
                  height: 595,
                )
              ],
            ),
            const SizedBox(height: 20),
            const Center(
                child: Text(
              'Javier Mena-Bernal Carranza',
              style: TextStyle(fontSize: 24),
            )),
            const SizedBox(height: 8),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text('Nacido el 14 de Mayo de 2002')),
            const SizedBox(height: 8),
            const Text(
              'Tecnico Superior de DAM',
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                    'Experiencia en Desarrollo de aplicaciones móviles con Dart en Android e IOS')),
            const SizedBox(height: 8),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                  'Practicas hechas en Procisa Sevilla (Mairena del Aljarafe Poligono Pizza)',
                )),
            const SizedBox(height: 8),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                    'Estudios de Desarrollo de Aplicaciones Multiplataforma en vedruna Sevilla')),
            const SizedBox(height: 8),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text(
                    'Actual CEO y creador de la empresa y aplicación Lions Film')),
            const SizedBox(height: 8),
            Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Text('Para contactar conmigo:'
                    'Correo: menajavier2002@gmail.com')),
            const SizedBox(height: 16)
          ],
        ),
      ),
    );
  }
}
