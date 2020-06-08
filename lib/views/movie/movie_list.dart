import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/widgets/provider_widget.dart';
import 'package:digipay_master1/services/database.dart';
import 'package:digipay_master1/views/movie/seat_selector_widget.dart';
import 'package:digipay_master1/views/movie/cinema_showtimings.dart';
import 'package:digipay_master1/views/movie/global_movie.dart' as Movieglobal;


class ListTileDemo extends StatelessWidget {


 // ListTileDemo({Key key,this.title,}) : super(key: key);

  //final String title;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
    appBar:  AppBar(
      centerTitle: true,
      title: Text("Movie Booking"),//Image.asset(
      //'assets/airtellogo.png',
      //fit: BoxFit.cover,
      //height: 35.0,
      //),
    ),
      body: Container(
      child: StreamBuilder(
          stream: getMovies(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildMovieCard(context, snapshot.data.documents[index]));
          }
      ),
      )
    );

  }


  Widget buildMovieCard(BuildContext context, DocumentSnapshot movie) {

    return Card(
            child: ListTile(
              leading: FlutterLogo(size: 56.0),
              title: Text(
                ""+movie['movie_name'],
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(""+movie['movie_certification']+"\n" +movie['movie_date']),
              trailing:   RaisedButton(
                child: Text("Book Now"),
                onPressed: (){
                  Movieglobal.movieName= movie['movie_name'];
                  Movieglobal.movieID = movie.documentID;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CinemaSearchWidget(movieid: movie.documentID,)));
                },
              ),
            ),
          );

  }



  Stream<QuerySnapshot> getMovies(
      BuildContext context) async* {

    yield* Firestore.instance.collection('movie').orderBy('movie_date',descending: true).snapshots();
  }
}
