import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lions_film/providers/google_sign_in.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Login'),
      ),
      body: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(16),
                  child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Image(
                          height: 75,
                          image: NetworkImage(
                              'https://logodownload.org/wp-content/uploads/2014/09/google-logo-1.png')))),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Inicia tu sesión con Google',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Disfruta de los cortos de la comunidad\nDisfruta de nuestra cartelera\ny de mucho mas',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              const Spacer(flex: 24),
              ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: const Size(double.infinity, 50)),
                  onPressed: () {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    provider.googleLogin();
                  },
                  icon:
                      const FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: const Text('Sign Up With Google')),
              const SizedBox(height: 40),
              const Spacer(),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: const Text(
                    'Inicia tu sesión con Google 100% seguro'
                  ))
            ],
          )),
    );
  }
}
