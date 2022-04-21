import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lions_film/tiles/logged_info_user.dart';
import '../screens/login_screen.dart';

class LoginController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return const LoggedInfoUser();
            } else if (snapshot.hasError) {
              return const Center(child: Text('ha habido un error intentalo de nuevo o espera 10 minutos y vuelve a intentarlo'));
            } else {
              return const LoginScreen();
            }
          }),
    );
  }
}
