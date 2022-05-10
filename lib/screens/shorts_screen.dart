import 'dart:typed_data';

import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:firebase_storage/firebase_storage.dart' as fire_storage;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/models/firebase_file.dart';
import 'package:lions_film/providers/firebase_info.dart';
import 'package:lions_film/tiles/add_short_formulary.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({Key? key}) : super(key: key);

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureFiles = FireBaseInfo().listAll('files/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Cortos'),
        ),
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
        body: FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(
                        child: Text(
                            'Se ha producido un error \n intentelo mas tarde'));
                  } else {
                    final files = snapshot.data!;
                    return ListView.separated(
                         separatorBuilder: (context,index) => const Divider(),
                        itemCount: files.length,
                        itemBuilder: (context, index) {
                          final file = files[index];
                          return buildFile(context, file);
                        });
                  }
              }
            }));
  }

  Widget buildFile(BuildContext context, FirebaseFile file) {
    double height = MediaQuery.of(context).size.height;
    return ListTile(
      leading: Image(image: NetworkImage(file.url)),
      title: Text(file.name),
    );
  }
}
