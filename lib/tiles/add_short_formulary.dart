import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddShortFormulary extends StatefulWidget {
  const AddShortFormulary({Key? key}) : super(key: key);

  @override
  State<AddShortFormulary> createState() => _AddShortFormularyState();
}

class _AddShortFormularyState extends State<AddShortFormulary> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
          child: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text(
                "Título del corto",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
            cursorRadius: const Radius.circular(16),
          ),
          ElevatedButton(
              onPressed: () async {
                final video = await FilePicker.platform.pickFiles();

              },
              child: const Icon(Icons.add)),
          ElevatedButton(onPressed: () {}, child: Text('Subir Archivo'))
        ],
      )),
    );
  }
}
