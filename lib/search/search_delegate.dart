import 'package:flutter/material.dart';
import 'package:lions_film/models/models.dart';
import 'package:lions_film/providers/providers.dart';
import 'package:provider/provider.dart';

class MovieSearchDelegate extends SearchDelegate{

  @override
  String? get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query='';
        },
        icon: const Icon(Icons.clear),)
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back)
    );

  }
  Widget _emptyContainer() {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: const Center(
          child: Icon(Icons.movie_creation_outlined,
            color: Colors.black38,
            size: 150,)
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('Error');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      // ignore: avoid_unnecessary_containers
      return _emptyContainer();
    }



    print('peticion http');

    final moviesProvider = Provider.of<MoviesProvider>(context,listen: false);

    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) return _emptyContainer();
        final movies = snapshot.data!;
        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_,int index) => _MovieItem(movies[index]),
        );
      },
    );
  }

}

class _MovieItem extends StatelessWidget {
  final Movie movie;

  const _MovieItem( this.movie);

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'search-${movie.id}';
    return ListTile(
      leading: Hero(
        tag: movie.heroId!,
        child: Image(
          image:NetworkImage(movie.fullPosterImg,) ,
          width: 50,
          fit: BoxFit.contain,
        ),
      ),
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details',arguments: movie);
      },
    );
  }
}

