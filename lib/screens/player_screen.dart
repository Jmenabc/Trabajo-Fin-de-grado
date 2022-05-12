import 'package:flutter/material.dart';
import 'package:lions_film/models/firebase_file.dart';
import 'package:lions_film/providers/firebase_info.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  VideoPlayerController? _controller;
  late Future<List<FirebaseFile>> futureFiles;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureFiles = FireBaseInfo().listAll('files/');
  }

  @override
  Widget build(BuildContext context) {
    _controller = VideoPlayerController.network('')
      ..initialize().then((_) {
        setState(() {});
      });
    return Scaffold(
      body: FutureBuilder<List<FirebaseFile>>(
          future: futureFiles,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                final files = snapshot.data!;
                return Container(
                  padding: const EdgeInsets.all(8),
                  child: _controller?.value.isInitialized ?? false
                      ? AspectRatio(
                          aspectRatio: _controller!.value.aspectRatio,
                          child: VideoPlayer(_controller!),
                        )
                      : Container(),
                );
            }
          }),
    );
  }
}
