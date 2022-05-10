import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoggedInfoUser extends StatelessWidget {
  const LoggedInfoUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Información del usuario'),
        centerTitle: true,
      ),
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(user!.photoURL!),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(user.displayName!),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(user.email!),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                    "Correo Verificado: ${user.emailVerified == false ? "Verifica tu correo no estas seguro pana" : "Verificado"}"),
              ),
            ],
          )
        ],
      )




      /*Column(
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
      ),*/
    );
  }
}
