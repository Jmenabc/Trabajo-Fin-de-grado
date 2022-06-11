import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/models/firebase_file.dart';
import 'package:lions_film/providers/firebase_info.dart';
import 'package:lions_film/tiles/add_short_formulary.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class ShortsScreen extends StatefulWidget {
  const ShortsScreen({Key? key}) : super(key: key);

  @override
  State<ShortsScreen> createState() => _ShortsScreenState();
}

class _ShortsScreenState extends State<ShortsScreen> {
  VideoPlayerController? _controller;
  late Future<List<FirebaseFile>> futureFiles;
  final uid = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    futureFiles = FireBaseInfo().listAll('files/');
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose() ?? _controller!.pause();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text('Cortos'),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddShortFormulary()));
          },
        ),
        body: FutureBuilder<List<FirebaseFile>>(
            future: futureFiles,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(32),
                            child: const Text(
                                'Limite de espacio en App\nalcanzado intentelo mas tarde'),
                          ),
                          const CircularProgressIndicator(),
                          const Spacer()
                        ],
                      ),
                    );
                  } else {
                    final files = snapshot.data!;
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('$uid')
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        return buildList(context, snapshot, files);
                      },
                    );
                  }
              }
            }));
  }

  ListView buildList(BuildContext context,
      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot, List files) {
    return ListView.builder(
        itemCount: snapshot.data?.docs.length,
        itemBuilder: (BuildContext context, int index) {
          final file = files[index];
          DocumentSnapshot ds = snapshot.data!.docs[index];
          return buildCard(ds, file);
        });
  }

  Card buildCard(DocumentSnapshot<Object?> ds, FirebaseFile file) {
    return Card(
      child: ExpansionTile(
        title: Text('${ds['name'] ?? 'Desconocido'}'),
        subtitle: Text('${ds['artist'] ?? 'Desconocido'}'),
        children: [
          const Divider(),
          titleData(text: 'Correo'),
          titleInfo(
              text: '${ds['email'] ?? 'Desconocido'}',
              icon: Icons.email_outlined),
          const Divider(),
          titleData(text: 'Número de Teléfono'),
          titleInfo(
              text: '${ds['phoneNumber'] ?? 'Desconocido'}',
              icon: Icons.phone_outlined),
          const Divider(),
          titleData(text: 'Descripción'),
          titleInfo(
              text: '${ds['description'] ?? 'Desconocido'}',
              icon: Icons.text_fields_outlined),
          const Divider(),
          buildFile(context, file)
        ],
      ),
    );
  }

  Align titleData({required String text}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(padding: const EdgeInsets.all(8), child: Text(text)),
    );
  }

  Align titleInfo({required String text, required IconData icon}) {
    return Align(
      alignment: Alignment.topLeft,
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(8), child: Icon(icon)),
          Container(padding: const EdgeInsets.all(8), child: Text(text)),
        ],
      ),
    );
  }

  Widget buildFile(BuildContext context2, FirebaseFile file) {
    final videoPlayerController = VideoPlayerController.network(file.url);
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      allowMuting: true,
      allowedScreenSleep: true,
      allowPlaybackSpeedChanging: false,
      looping: false,
      autoInitialize: false,
    );
    final playerWidget = Chewie(
      controller: chewieController,
    );

    return TextButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return Card(child: playerWidget);
            });
      },
      child: const Text('Reproducir Corto'),
    );
  }
}
