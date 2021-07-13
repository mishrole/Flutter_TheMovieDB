import 'package:flutter/material.dart';
import 'package:peliculasapp/providers/movies_provider.dart';
import 'package:peliculasapp/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Películas en cines')
        ),
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search_outlined)
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas Principales
            CardSwiper( movies: moviesProvider.onDisplayMovies ),

            // Slider de Películas Populares
            MovieSlider( movies: moviesProvider.popularMovies, title: 'Populares!'),
          ],
        ),
      ),
    );
  }
}