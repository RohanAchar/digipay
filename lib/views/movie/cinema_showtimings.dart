import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digipay_master1/views/movie/seat_selector_widget.dart';
import 'package:digipay_master1/views/movie/global_movie.dart' as Movieglobal;


class CinemaSearchWidget extends StatefulWidget {

  final String movieid;
  CinemaSearchWidget({this.movieid});



  static const String routeName = './CinemaSearchWidget';

  @override
  _CinemaSearchWidgetState createState() => _CinemaSearchWidgetState();
}

class _CinemaSearchWidgetState extends State<CinemaSearchWidget> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: Text('Bangalore')),
      body: Container(
        child: StreamBuilder(
            stream: getCinemas(context),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const Text("Loading...");
              return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) {

                  return _buildCinemaListItem(context,snapshot.data.documents[index]);
                },
              );
            }
        ),
      )
    );
  }

  Stream<QuerySnapshot> getCinemas(BuildContext context) async* {

    yield* Firestore.instance.collection('movie').document(widget.movieid).collection('theatres').snapshots();
  }


  Card _buildCinemaListItem(BuildContext context,DocumentSnapshot theatre) {
    Cinema cinema = new Cinema(1);
    final ThemeData theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _buildCinemaTitle(cinema, theme,theatre),
            _buildShowTimeList(cinema, context,theatre)
          ],
        ),
      ),
    );
  }

  /// Will create the list of show time. This list will contain
  /// input chips clicking on which user will be shown option to select
  /// seats.
  Wrap _buildShowTimeList(Cinema cinema, BuildContext context,DocumentSnapshot theatre) => Wrap(
    alignment: WrapAlignment.center,
    direction: Axis.horizontal,
    children: cinema.showTimes
        .map((String showTime) =>
        _buildShowTimeListItem(showTime, cinema, context,theatre))
        .toList(),
  );

  /// This will create an Input chip that will represent a given
  /// show time. clicking on this show time will take user to
  ///
  Padding _buildShowTimeListItem(
      String showTime, Cinema cinema, BuildContext context,DocumentSnapshot theatre) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: InputChip(
          // backgroundColor: the,
          label: Text(showTime),
          onPressed: () => _onShowTimeSelected(cinema, showTime, context,theatre['theatre_name']),
        ),
      );

  /// This will launch the seat selection widget.
  void _onShowTimeSelected(Cinema cinema, String showTime, BuildContext context,String n) {

    Movieglobal.showTime=showTime;
    Movieglobal.theatreName=n;
    Navigator.push(context, MaterialPageRoute(builder: (context) => SeatSelectorWidget()));


  }

  /// Name of the cinema in cinema list item.
  Padding _buildCinemaTitle(Cinema cinema, ThemeData theme,DocumentSnapshot theatre) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        ""+theatre['theatre_name'],
        style: TextStyle(
            color: theme.accentColor,
            fontSize: 25,
            fontWeight: FontWeight.w300),
      ),
    );
  }
}

/// this is supposed to be fetched from the theatre api, as we don't
/// have it as of now we are using dummy data

class Cinema {

  Cinema(int i);

  String get name => "Cinema 1";



  final List<String> showTimes = [
    '09:00 AM',
    '11:00 AM',
    '12:15 PM',
    '03:15 PM',
    '06:15 PM',
    '08:00 PM',
    '10:15 PM',
  ];
}

/*class Cinema extends StatelessWidget {

String theatreid;
Cinema({this.theatreid});



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getCinemaShows(context),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Loading");
          }
          else{
            final shows = snapshot.data.documents;

            for (var show in shows) {
              Movieglobal.showTimes.add(show.data['show_time']);
              Movieglobal.showAmounts.add(show.data['show_price']);
            }
          }
          return Text('');
        });
  }


  Stream<QuerySnapshot> getCinemaShows(BuildContext context) async* {

    yield* Firestore.instance.collection('movie').document(Movieglobal.movieID).collection('theatres').document(theatreid).collection('showtimings').orderBy('show_time').snapshots();
  }

}*/


