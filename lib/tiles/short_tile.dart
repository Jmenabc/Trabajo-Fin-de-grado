import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/models/short_model.dart';

class ShorTile extends StatefulWidget {
  @override
  State<ShorTile> createState() => _ShorTileState();
}

class _ShorTileState extends State<ShorTile> {
  final uid = FirebaseAuth.instance.currentUser?.uid;

  ShortModel retrievedShorts = ShortModel();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(uid!).snapshots(),
        builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return const Text('Vuelve a intertarlo mas tarde');
          return Scaffold(
            appBar: AppBar(
              title: Text(snapshot.data!.docs[0]['name']),
            ),
            body: Align(child: Column()),
          );
        });
  }
}
