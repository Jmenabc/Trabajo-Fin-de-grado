import 'package:fab_circular_menu/fab_circular_menu.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/tiles/add_short_formulary.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ShortsScreen extends StatelessWidget {
  const ShortsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: FabCircularMenu(
        ringColor: Colors.grey,
        children: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const AddShortFormulary()));
          }),
          IconButton(icon: const Icon(Icons.remove_red_eye), onPressed: () {
            print('Ver mis cortos');
          })
        ],
      ),
    );
  }
}

class FireStorageServices extends ChangeNotifier {
  FireStorageServices();
  static Future<dynamic> loadVideo(BuildContext context, String video) async {
    return await FirebaseStorage.instance.ref().child(video).getDownloadURL();
  }
}