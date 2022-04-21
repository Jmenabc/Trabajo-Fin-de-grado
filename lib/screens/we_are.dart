import 'package:flutter/material.dart';
import 'package:lions_film/screens/home_screen.dart';
import 'package:lions_film/tiles/tiles.dart';

class WeAre extends StatelessWidget {
  const WeAre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 22),
            const Center(
                child: Text(
              'Lions Film Team',
              style: TextStyle(fontSize: 32),
            )),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MenaInfo())),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/mena.jpg',
                  width: 300,
                  height: 500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Javier Mena-Bernal',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Divider(),
            const SizedBox(
              height: 16,
            ),
            GestureDetector(
              onTap: () =>  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const MenaInfo())),
                child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  'assets/antonio.png',
                  width: 300,
                  height: 500,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Center(
              child: Text(
                'Antonio Navas Polonio',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
          ]),
        ));
  }
}
