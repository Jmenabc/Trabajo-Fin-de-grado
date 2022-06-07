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

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection(uid!).snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot ds = snapshot.data!.docs[index];
                return Center(child: Text(ds['name']));
              });
        });
  }
}
