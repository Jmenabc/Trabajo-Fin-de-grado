import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lions_film/helpers/debouncer.dart';
import 'package:lions_film/models/models.dart';
import 'package:flutter/widgets.dart';
import 'package:lions_film/models/search_movies_response.dart';

class MoviesProvider extends ChangeNotifier{
//propiedades
  final String _baseUrl='api.themoviedb.org';
  final String _apiKey = '77be0d10f917f167a6c643f8e501b92d';
  final String _launguage = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  List<Movie> topRatesMovies = [];
  Map<int,List<Cast>>  moviescast = {};

  int _popularPage = 0;
  int _topRatedPage=0;
  final debouncer = Debouncer(
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;



  MoviesProvider() {
    // ignore: avoid_print
    print('Moviesprovider iniciado');
    getOnDisplayMovies();
    getPopularMovies();
    getTopRatesMovies();
  }

  Future <String> _getJsonData (String endpoint,[int page=1]) async {
    var url = Uri.https(_baseUrl,endpoint, {
      'api_key':_apiKey,
      'language':_launguage,
      'page': '$page'
    }
    );

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }
  getOnDisplayMovies() async{
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    // ignore: avoid_print
    print(nowPlayingResponse.results[1].title);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();

  }

  getPopularMovies() async{
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular',_popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    // ignore: avoid_print
    popularMovies = [...popularMovies,...popularResponse.results];
    notifyListeners();
  }

  getTopRatesMovies() async {
    _topRatedPage++;
    final jsonData = await _getJsonData('3/movie/top_rated',_topRatedPage);
    final topResponse = PopularResponse.fromJson(jsonData);
    // ignore: avoid_print
    topRatesMovies = [...topRatesMovies,...topResponse.results];
    notifyListeners();
  }

  Future <List<Cast>>getMovieCast(int movieId) async {

    if(moviescast.containsKey(movieId)) return moviescast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviescast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;

  }

  Future<List<Movie>> searchMovie(String query) async{
    var url = Uri.https(_baseUrl,'3/search/movie', {
      'api_key':_apiKey,
      'language':_launguage,
      'query': query,
    });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm) {
    debouncer.value = '';
    debouncer.onValue = (value) async{
      final results = await this.searchMovie(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) {
      debouncer.value = searchTerm;
    });
    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());


  }
}

