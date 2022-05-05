import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/providers/firebase_api.dart';

class AddShortFormulary extends StatefulWidget {
  const AddShortFormulary({Key? key}) : super(key: key);

  @override
  State<AddShortFormulary> createState() => _AddShortFormularyState();
}

class _AddShortFormularyState extends State<AddShortFormulary> {
  File? file;
  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? (file!.path) : "no file selected";
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(24),
            child: Text(fileName),
          ),
          ElevatedButton(
              onPressed: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();
                if (result == null) return;
                final path = result.files.single.path;
                setState(() {
                  file = File(path!);
                });
              },
              child: const Icon(Icons.add)),
          ElevatedButton(onPressed: () {
            uploadData();
          }, child: Text('Subir Archivo'))
        ],
      )),
    );
  }

  Future uploadData() async {
    if (file == null) return "error";

    final fileName = (file!.uri.pathSegments.last);
    final destination = 'files/$fileName';

    FirebaseApi.uploadFile(destination,file!);
  }
}
