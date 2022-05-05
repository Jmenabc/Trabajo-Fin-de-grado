import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_storage/firebase_storage.dart' as fire_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/tiles/add_short_formulary.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({Key? key}) : super(key: key);

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        floatingActionButton: FabCircularMenu(
          ringColor: Colors.grey,
          children: [
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddShortFormulary()));
                }),
            IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddShortFormulary()));
                }),
          ],
        ),
        body: FutureBuilder(
          future: listExample(),
          builder: (BuildContext context, AsyncSnapshot<ListResult> snapshot) {

            return GridView.count(
                crossAxisCount: 2,
                children:
                    snapshot.data?.items.map((e) => Text(e.name)).toList() ??
                        []);
          },
        ));
  }
}

Future<ListResult> listExample() async {
  final storageRef =
      fire_storage.FirebaseStorage.instance.ref().child("files").listAll();
  return storageRef;
}

//Hacer metodo que devuelva image.memory y le paso el uint8List, que es lo que me viene del getData me da el uint8List

Future<Image> getImage() async {
  final storageRef = fire_storage.FirebaseStorage.instance.ref().child("files").getData();

}
