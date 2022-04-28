import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return GridView.count(crossAxisCount: 2, children: [
              Container(
                color: Colors.red, // child: Text(snapshot.toString()),
              )
            ]);
          },
        ));
  }
}

Future<void> listExample() async {
  final storageRef = FirebaseStorage.instance.ref().child("files/uid");
  final listResult = await storageRef.listAll();
}
