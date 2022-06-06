import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/models/firebase_file.dart';
import 'package:lions_film/models/short_model.dart';
import 'package:lions_film/providers/firebase_info.dart';
import 'package:video_player/video_player.dart';

class ShorTile extends StatefulWidget {
  @override
  State<ShorTile> createState() => _ShorTileState();
}

class _ShorTileState extends State<ShorTile> {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  ShortModel retrievedShorts = ShortModel();
  //Videpolayer
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
    _controller?.dispose() ?? _controller!.pause();
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(uid!).snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Text('Vuelve a intertarlo mas tarde');
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.docs[0]['name']),
            ),
            body: Column(
              children: [
                buildFile(context, file),
                shortContainer(text: 'Description'),
                shortContainerInfo(text: '${snapshot.data!.docs[0]['description']}')
              ],
            ),
          );
        });
  }

  Container shortContainer({required String text}) {
    return Container(
                    padding: const EdgeInsets.all(16),
                    child:  Text(text),
                  );
  }

  Container shortContainerInfo({required String text}) {
    return Container(
      padding: const EdgeInsets.all(16),
      child:  Text(text),
    );
  }

  Widget buildFile(BuildContext context, FirebaseFile file) {
    final videoPlayerController = VideoPlayerController.network(file.url);
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      allowMuting: true,
      allowedScreenSleep: true,
      allowPlaybackSpeedChanging: false,
      looping: false,
      autoInitialize: true,
    );
    final playerWidget = Chewie(
      controller: chewieController,
    );

    return Container(

      child: playerWidget,
    );
  }
}
