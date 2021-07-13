import 'package:flutter/material.dart';
import 'package:peliculasapp/models/models.dart';

class MovieSlider extends StatelessWidget {

  final List<Movie> movies;
  final String? title;

  const MovieSlider({Key? key, required this.movies, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      // color: Colors.blue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              this.title ?? 'Populares',
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold
              ),
            ),
          ),

          SizedBox(height: 5,),

          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              /*itemBuilder: (BuildContext context, int index) { return _MoviePoster()}, */
              itemBuilder: ( _ , int index) {
                final movie = movies[index];

                return _MoviePoster( movie: movie );
              }
            ),
          ),
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;

  const _MoviePoster({ Key? key, required this.movie }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: EdgeInsets.symmetric(
        horizontal: 10.0, 
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: AssetImage('assets/no-image.jpg'),
                image: NetworkImage( movie.fullPosterImg ),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 5,),

          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          
        ],
      ),
    );
  }
}