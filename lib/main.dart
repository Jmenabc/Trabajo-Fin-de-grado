import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lions_film/providers/google_sign_in.dart';
import 'package:lions_film/providers/providers.dart';
import 'package:lions_film/screens/screen.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

 void  main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
        title: 'Peliculas',
        routes: {
          'home': (_) => const HomeScreen(),
          'details': (_) => const DetailsScreen()
        },
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        // home: const HomeScreen(),
        theme: ThemeData.dark()
            .copyWith(appBarTheme: const AppBarTheme(color: Colors.transparent)),
      ),
    );
  }
}
