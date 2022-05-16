import 'package:fab_circular_menu/fab_circular_menu.dart';
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

  @override
  void initState() {
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
                    return ListView.separated(
                        separatorBuilder: (context, index) => const Divider(),
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
    final videoPlayerController = VideoPlayerController.network(file.url);
    final chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
    final playerWidget = Chewie(
      controller: chewieController,
    );

    return ListTile(
      // leading: Image(image: NetworkImage(file.url)),
      title: Text(file.name),
      trailing: IconButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return Card(child: playerWidget);
                });
          },
          icon: const Icon(Icons.remove_red_eye)),
    );
  }
}
