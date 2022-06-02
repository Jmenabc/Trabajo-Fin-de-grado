import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lions_film/screens/login_screen.dart';

class LoggedInfoUser extends StatelessWidget {
  const LoggedInfoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () async {
          await FirebaseAuth.instance.signOut();

        },
      ),
      appBar: AppBar(
        elevation: 0,
        title: const Text('Información del usuario'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user!.photoURL!),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text("Nombre: ${user.displayName!}"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text("Correo: ${user.email!}"),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
                "Correo Verificado: ${user.emailVerified == false ? "Verifica tu correo no estas seguro pana" : "Verificado"}"),
          ),
        ],
      ),
    );
  }
}
