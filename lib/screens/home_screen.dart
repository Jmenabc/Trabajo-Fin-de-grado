import 'package:flutter/material.dart';
import 'package:lions_film/controlers/short_controller.dart';
import 'package:lions_film/dialogs/privacy_policy.dart';
import 'package:lions_film/providers/providers.dart';
import 'package:lions_film/controlers/login_controller.dart';
import 'package:lions_film/screens/screen.dart';
import 'package:lions_film/search/search_delegate.dart';
import 'package:lions_film/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    // ignore: avoid_print
    print(moviesProvider.onDisplayMovies);

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () =>
                  showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_outlined),
            )
          ],
        ),
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              Container(
                  height: 250,
                  child: const Image(image: AssetImage('assets/logo123.jpeg'))),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('Politica de privacidad'),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PrivacyPolicy(mdFilename: 'privacy_policy.md');
                      });
                },
              ),
              const Divider(),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('Login'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginController()));
                },
              ),
              const Divider(),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('Página web'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Website()));
                },
              ),
              const Divider(),
              const SizedBox(height: 8),
              ListTile(
                title: const Text('Cortos'),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                               const ShortController())); //TODO: crear página de cortos y empezar diseño grafico
                },
              ),
            ],
          ),
        ),
        // ignore: avoid_unnecessary_containers
        body: SingleChildScrollView(
            child: Column(
          children: [
            //targetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),
            //Slider peliculas
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares',
              onNextPage: () => {moviesProvider.getPopularMovies()},
            ),
            //SLider de topRates
            MovieSlider(
                movies: moviesProvider.topRatesMovies,
                title: 'Top Rates',
                onNextPage: () => {moviesProvider.getTopRatesMovies()}),
          ],
        )));
  }
}
