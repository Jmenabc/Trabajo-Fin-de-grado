import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/tiles/add_short_formulary.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShortsScreen extends StatefulWidget {

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final storageRef = FirebaseStorage.instance.ref('/file_picker');

  }
  @override
  Widget build(BuildContext context) {
    // final storageRef = FirebaseStorage.instance.ref('/file_picker');
    // final path = storageRef.fullPath;
    // final name = storageRef.name;
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
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  print('Ver mis cortos');
                })
          ],
        ),
        body: FutureBuilder(
          future: getShort(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              final file = snapshot.data.items;
              return GridView.count(crossAxisCount: 2,children: [
                Card(
                  child: Text(file.),
                )
              ],);
            }
          },

        ));
  }
}

Future<Widget> getShort() async {
  final storageRef = FirebaseStorage.instance.ref();
  final spaceRef = storageRef.child("files/");
  //propiedades
  final path = spaceRef.fullPath;
  final name = spaceRef.name;
  return Column(
    children: [
       const Card(
        color: Colors.red,
      ),
      Text(name)
    ],
  );
}
