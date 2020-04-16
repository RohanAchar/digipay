import 'package:flutter/material.dart';
import 'package:digipay_master1/views/movie/global_movie.dart' as Movieglobal;
import 'package:digipay_master1/views/wallet/payment.dart';


/// This widget is used to show user the summary of the selection
/// of movie, city, cinema, showtime and their seats.
/// User can click on the confirm dialog to buy the
/// ticket for this selection.
class SummaryWidget extends StatefulWidget {
  /// Used by the navigator to push this widget on the stack.
  static const routeName = './SummaryWidget';

  @override
  _SummaryWidgetState createState() => _SummaryWidgetState();
}

class _SummaryWidgetState extends State<SummaryWidget> {

  int total= Movieglobal.seats.length * 150;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ticket Booking Summary')),
      body: Stack(fit: StackFit.expand, children: [
        _buildContent(),
      ]),
    );
  }

  SafeArea _buildContent() => SafeArea(
    child: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('${Movieglobal.movieName}', style: TextStyle(fontSize: 60.0)),
            Text('Bangalore', style: TextStyle(fontSize: 30.0)),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                '${Movieglobal.theatreName}   |  ${Movieglobal.showTime}',
                style: TextStyle(fontSize: 25.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Seats : ${Movieglobal.seats.toString().split('[')[1].split(']')[0]}',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                'Total price = ${Movieglobal.seats.length}  x 150 = $total',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
            ),
            Padding(
              padding: EdgeInsets.only(right: 100.0),
              child: FloatingActionButton.extended(
                icon: Icon(Icons.payment),
                label: Text('Proceed to Pay'),
                onPressed: () {
                  Movieglobal.amt=total;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PayPage(page: 'movie',)));

                },
              ),
            ),

          ],
        ),
      ),
    ),
  );

  /// Returns comma separated seats as single string.

  /// Creates poster of the movie.
  Container _buildPoster() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Colors.black, width: 1),
          image: DecorationImage(image: AssetImage('assets/poster.jpg'))),
    );
  }

}
