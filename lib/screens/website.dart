import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Website extends StatelessWidget {
  const Website({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: Column(
        children: [
          Image.asset('assets/logo123.jpeg'),
          Center(
              child: Container(
            padding: const EdgeInsets.all(16),
            child: const Text('Sitio Web',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          )),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                  'Si quieres poder ver las películas de Lions Film ve a nuestra página web y no te pierdas ninguno de los próximos estrenos'),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: const Text(
                  'En nuestra página web podrás encontrar todo tipo de películas para visualizar, si necesitas mas información accede en Inicio>menu_lateral>Página web de empresas en Inicio'
                  'Nuestros inicios de sesión estan conectados, es decir, no tendras que crearte nada mas que una cuenta, accede con una cuenta a todos nuestros servicios'),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: TextButton(
                  onPressed: () {
                    launch(
                        'https://codea.app/blog/cargar-url-flutter#:~:text=Cargar%20una%20url%20en%20Flutter&text=Para%20ello%20usamos%20el%20paquete,evento%20click%20en%20la%20app.');
                  },
                  child: const Text('Página web')),
            ),
          )
        ],
      ),
    );
  }
}
