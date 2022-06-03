import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  //Datos del modelo
  String description = "";
  String artist = "";
  String email = "";
  String? phoneNumber;

  File? file;
  UploadTask? task;

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? (file!.path) : "no file selected";

    //Referencia a la collección
    // final destination = 'shortInf/$filePath';
    return Scaffold(
      appBar: AppBar(elevation: 0, title: const Text('Subir Cortos')),
      body: Form(
          child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration:
                        const InputDecoration(label: Text('Descripción')),
                    onChanged: (descriptionData) {
                      description = descriptionData;
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(label: Text('Artista')),
                    onChanged: (artistData) {
                      artist = artistData;
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(label: Text('Correo')),
                    onChanged: (emailData) {
                      email = emailData;
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: TextField(
                    decoration: const InputDecoration(
                        label: Text('Número de teléfono')),
                    onChanged: (phoneNumberData) {
                      phoneNumberData == ""
                          ? phoneNumberData = "No disponible"
                          : phoneNumber = phoneNumberData;
                    },
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text('Pulse aqui para añadir su archivo'),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
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
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  child: Text("Nombre: $fileName"),
                ),
              ),
              ElevatedButton(
                  onPressed: () async {
                    uploadData();
                    CollectionReference ref = FirebaseFirestore.instance.collection(fileName);
                    await ref.add({
                      'Description': description, // John Doe
                      'artist': artist, // Stokes and Sons
                      'email': email,
                      'phoneNumber': phoneNumber
                    }).then((value) => Navigator.pop(context));
                  },
                  child: const Text('Subir Archivo')),
              const Divider(height: 24),
              Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        padding: const EdgeInsets.all(16),
                        child: const Text('Reglas de Lions Film')),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset('assets/logo123.jpeg'),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      child: const Text(
                          'En Lions Film priorizamos mucho la seguridad de nuestros usuarios, por ello cualquier persona que intente atentar contra las normas de la Aplicación como a los demas será severamente baneado de esta aplicación y no podra subir cortos nunca mas.\n\nNormas:\n\n1.- Solo se pueden subir cortos cualquier otro tipo de archivo sera eliminado y si se sube en exceso el que lo postee será baneado\n\n2.- Los cortos no deben durar mas de 3 minutos\n\n3.- Poner el nombre en el archivo antes de subirlo\n\n4.- Pasarlo bien y disfrutar'),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      )),
    );
  }

  void uploadData() async {
    final fileName = (file!.uri.pathSegments.last);
    final destination = 'files/$fileName';
    FirebaseApi.uploadFile(destination, file!);
  }
}
