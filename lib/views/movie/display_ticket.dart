import 'package:flutter/material.dart';
import 'package:ticket_pass_package/ticket_pass.dart';
import 'package:digipay_master1/views/movie/global_movie.dart' as Movieglobal;
import 'package:digipay_master1/views/dashboard.dart';


void main() => runApp(DisplayTicket());

class DisplayTicket extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Ticket Pass Flutter',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Movie Ticket Pass'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 70.0),
                ),
                Center(
                    child: TicketPass(
                        alignment: Alignment.center,
                        animationDuration: Duration(seconds: 2),
                        /* expansionChild: Expanded(
                        child: Container(
                      color: Colors.black,
                    )),*/
                        expandedHeight: 600,
                        expandIcon: CircleAvatar(
                            maxRadius: 14,
                            child: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                              size: 20,
                            )),
                        expansionTitle: Text('Seats',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                            )),
                        purchaserList: Movieglobal.seats,
                        separatorColor: Colors.black,
                        separatorHeight: 2.0,
                        color: Colors.white,
                        curve: Curves.easeOut,
                        titleColor: Colors.blue,
                        shrinkIcon: Align(
                            alignment: Alignment.centerRight,
                            child: CircleAvatar(
                                maxRadius: 14,
                                child: Icon(
                                  Icons.keyboard_arrow_up,
                                  color: Colors.white,
                                  size: 20,
                                ))),
                        ticketTitle: Text('Seats',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 18,
                            )),
                        titleHeight: 50,
                        width: 350,
                        height: 220,
                        shadowColor: Colors.blue.withOpacity(0.5),
                        elevation: 8,
                        shouldExpand: true,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 5),
                            child: Container(
                                height: 140,
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2.0),
                                    child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                              child: Container(
                                                  child: Row(children: <Widget>[
                                                    Expanded(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Text(
                                                                'Movie Time',
                                                                style: TextStyle(
                                                                    color: Colors.black
                                                                        .withOpacity(0.5)),
                                                              ),
                                                              Text(
                                                                '${Movieglobal.showTime}',
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600),
                                                              )
                                                            ])),
                                                    Expanded(
                                                        child: Column(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceAround,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: <Widget>[
                                                              Text(
                                                                'Name',
                                                                style: TextStyle(
                                                                  color: Colors.black
                                                                      .withOpacity(0.5),
                                                                ),
                                                              ),
                                                              Text('${Movieglobal.movieName}',
                                                                  overflow:
                                                                  TextOverflow.ellipsis,
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                    fontWeight:
                                                                    FontWeight.w600,
                                                                  ))
                                                            ]))
                                                  ]))),
                                          Expanded(
                                              child: Row(children: <Widget>[
                                                Expanded(
                                                    child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Text(
                                                            'Date',
                                                            style: TextStyle(
                                                                color: Colors.black
                                                                    .withOpacity(0.5)),
                                                          ),
                                                          Text(
                                                            '4th Nov,2020 ',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          )
                                                        ])),
                                                Expanded(
                                                    child: Column(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: <Widget>[
                                                          Text(
                                                            'PRICE',
                                                            style: TextStyle(
                                                                color: Colors.black
                                                                    .withOpacity(0.5)),
                                                          ),
                                                          Text(
                                                            '${Movieglobal.amt}',
                                                            style: TextStyle(
                                                                fontWeight:
                                                                FontWeight.w600),
                                                          )
                                                        ]))
                                              ])),
                                        ])))))),
                Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
                ),
                FloatingActionButton.extended(
                   // icon: Icon(Icons.thumb_up),
                    label: Text('Done'),
                    onPressed: () {
                      //Navigator.pushNamed(context, '/dashboard');
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Dashboard()));
                    }),

              ],
            ),
          ),
        ));
  }
}

/*Padding(
                                        padding:
                                            const EdgeInsets.only(top: 00.0),
                                      ), */
