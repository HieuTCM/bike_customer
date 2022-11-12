//import 'dart:html';

import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:bike_customerv2/Customer/components/NavBar.dart';
import 'package:bike_customerv2/Customer/components/bookingTab.dart';
import 'package:bike_customerv2/Customer/components/bookinginfomation.dart';
import 'package:bike_customerv2/Customer/helper/shared_prefs.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:bike_customerv2/Customer/models/user.dart';
import 'package:bike_customerv2/Customer/provider/customer_provider.dart';
import 'package:bike_customerv2/Customer/screen/booking/bookingScreen.dart';

import 'package:flutter/material.dart';

import '../components/RecentBooking.dart';

// ignore: must_be_immutable

class mainScreen extends StatefulWidget {
  @override
  State<mainScreen> createState() => _mainScreenState();
}

class _mainScreenState extends State<mainScreen> {
  static int id = getCuctomerIDFromSharedPrefs();
  Future<Customer>? customer;
  Future<List<CustomerTripFull>>? listTrip;
  @override
  void initState() {
    super.initState();
    customer = customerProvider.fetchCustomerByID(id);
    listTrip = customerProvider.fetchCustomertripByID(id);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var defaultTab = 0;
    var confirmTab = 4;
    String urlimg;
    Trip customerTrip = new Trip(
        id, 0, 0, 0, 0, "", 0.0, 0.0, 0.0, 0.0, 0.0, "", "", "", "", "");

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 243, 237, 231),
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(10.0), // here the desired height
            child: AppBar(
              backgroundColor: Color.fromARGB(255, 255, 160, 0),
              elevation: 0.0,
              leading: const Padding(
                padding: EdgeInsets.only(
                  left: 18.0,
                  top: 12.0,
                  bottom: 12.0,
                  right: 12.0,
                ),
              ),
            )),
        body: FutureBuilder<Customer>(
          future: customer,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
                  constraints: BoxConstraints.expand(),
                  color: Colors.white,
                  child: Column(children: <Widget>[
                    Row(
                      children: [
                        Container(
                            width: 75,
                            height: 75,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50))),
                            child: CircleAvatar(
                              radius: 48, // Image radius
                              backgroundImage: snapshot.data!.img != null
                                  ? NetworkImage(snapshot.data!.img)
                                  : null,
                            )),
                        SizedBox(width: 20),
                        Flexible(
                            child: Column(
                          children: <Widget>[
                            Row(children: [
                              Text("Welcome, " + snapshot.data!.name,
                                  style: TextStyle(fontSize: 20))
                            ]),
                            SizedBox(
                              height: 5,
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(children: [
                              ElevatedButton(
                                  onPressed: () {}, child: Text("Sign Out"))
                            ]),
                          ],
                        )),
                        Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                                border: Border.all(
                                    color: Colors.black,
                                    width: 4.0,
                                    style: BorderStyle.solid)),
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: IconButton(
                                  icon: Icon(Icons.notifications),
                                  tooltip: 'Follow',
                                  onPressed: () {},
                                ))),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 50.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 50.0,
                          width: 450,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => bookingScreen(
                                          defaultTab, customerTrip)));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 160, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            child: Text(
                              "Booking",
                              style: TextStyle(
                                fontSize: 24,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(
                      height: 5,
                      thickness: 2,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Recent Booking :",
                                style: TextStyle(fontSize: 24)))),
                    SizedBox(
                      height: 20,
                    ),
                    FutureBuilder<List<CustomerTripFull>>(
                        future: listTrip,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Container(
                              padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                              margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 240, 210, 159),
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              width: MediaQuery.of(context).size.width,
                              height: double.infinity,
                              // child:
                              // ListView.builder(
                              //   shrinkWrap: true,
                              //   itemCount: snapshot.data!.length,
                              //   itemBuilder: (context, index) {
                              //     var trip = snapshot.data![
                              //         snapshot.data!.length - index - 1];
                              //     return InkWell(
                              //         onTap: () {
                              //           setState(() {
                              //             Navigator.push(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         bookingInfomation(
                              //                             trip)));
                              //           });
                              //         },
                              //         child: Column(
                              //           children: [
                              //             SizedBox(
                              //               height: 10,
                              //             ),
                              //             Container(
                              //                 width: 350,
                              //                 height: 170,
                              //                 decoration: BoxDecoration(
                              //                   borderRadius:
                              //                       BorderRadius.circular(
                              //                           12.0),
                              //                   border: Border.all(
                              //                       color: trip.status ==
                              //                               'STAND_BY'
                              //                           ? Color
                              //                               .fromARGB(255,
                              //                                   7, 143, 255)
                              //                           : trip.status ==
                              //                                   'WATTING'
                              //                               ? Color
                              //                                   .fromARGB(
                              //                                       255,
                              //                                       252,
                              //                                       235,
                              //                                       5)
                              //                               : trip.status ==
                              //                                       'CANCELED'
                              //                                   ? Color
                              //                                       .fromARGB(
                              //                                           255,
                              //                                           252,
                              //                                           5,
                              //                                           5)
                              //                                   : Color
                              //                                       .fromARGB(
                              //                                           255,
                              //                                           46,
                              //                                           252,
                              //                                           5),
                              //                       width: 5),
                              //                 ),
                              //                 child: BookingCard(
                              //                   trip: trip,
                              //                 )),
                              //             SizedBox(
                              //               height: 20,
                              //             )
                              //           ],
                              //         ));
                              //   },
                              // ),
                            );
                          } else if (snapshot.hasError) {
                            return Text('${snapshot.error}');
                          }

                          // By default, show a loading spinner.
                          return const CircularProgressIndicator();
                        }),
                    SizedBox(
                      height: 20,
                    ),
                  ]));
              ;
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
        bottomNavigationBar: NavBar());
  }

  List<Booking> listBookings = getBookings();
}
