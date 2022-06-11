import 'package:flutter/material.dart';
import 'package:lions_film/screens/shorts_screen.dart';

class ShortUploadedScreen extends StatelessWidget {
  const ShortUploadedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
            padding: const EdgeInsets.only(bottom: 16),
            child: Image.asset("assets/logo123.jpeg")),
        buildContainer(
            text:
                'Su Corto se ha subido correctamente, muchas gracias por contribuir a la comunidad de Lions Film'),
        buildContainer(
            text: 'Para salir pulse abajo en el boton que pone "exit"'),
        Container(
          padding: const EdgeInsets.all(16),
          child: TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ShortsScreen()));
              },
              child: const Text('Exit')),
        )
      ]),
    );
  }

  Container buildContainer({required String text}) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Align(alignment:Alignment.topLeft,child: Text(text)),
    );
  }
}
