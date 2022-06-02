import 'package:flutter/material.dart';
import 'package:lions_film/models/firebase_file.dart';
import 'package:lions_film/providers/firebase_info.dart';
import 'package:video_player/video_player.dart';

class ShortInformationScreen extends StatefulWidget {
  const ShortInformationScreen({Key? key}) : super(key: key);

  @override
  State<ShortInformationScreen> createState() => _ShortInformationScreenState();
}

class _ShortInformationScreenState extends State<ShortInformationScreen> {
  VideoPlayerController? _controller;
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    super.initState();
    futureFiles = FireBaseInfo().listAll('files/');
  }

  @override
  void dispose() {
    super.dispose();
    _controller!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: const Text('Nombre del Corto'),
        ),
        body: Column(
          children: [
            Image.asset("assets/logo123.jpeg"),
            Container(
              padding: const EdgeInsets.all(16),
              child: const Align(
                  alignment: Alignment.topLeft,
                  child: Text("Descripción del corto")),
            ),
            Container(
                padding: const EdgeInsets.all(16),
                child: Text(
                    "dnmfoudnfondaslfnsdljfgnldsnfjgkdnfnfnfnfnfnfnfnfnfnfnfnnffnljdfnhokdfgjdiuofndubfdhfndeufbuidsfuisdufolsafesailhfgesoufgnosdebngfiouewhgfonewuogbewupofnoiuewhbgnfouewngfoupewnguoewngfouewnoufgnewopfeiwufboueqbfuiewbfuoewbfuibqefoueqoubfoeuqfoupebnfoiewnfgoipewmipfgnewuoghew9ugfnoewgnbuwerohgnoujewrgouewjngoewrgouewrngoewrhbngouewngfouewhngfouewngouewougfewuoigbnewougbnowg")),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: const Text("Autor"),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: const Text("Grupo"),
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: const EdgeInsets.all(16),
                child: const Text("Visualizar"),
              ),
            ),

          ],
        ));
  }
}
