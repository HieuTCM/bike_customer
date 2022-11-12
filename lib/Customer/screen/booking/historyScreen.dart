import 'dart:convert';

import 'package:bike_customerv2/Customer/components/TabView/ConfirmTab.dart';
import 'package:bike_customerv2/Customer/components/TabView/ListRoute.dart';
import 'package:bike_customerv2/Customer/components/TabView/ListPickUpStation.dart';
import 'package:bike_customerv2/Customer/components/TabView/ListSlot.dart';
import 'package:bike_customerv2/Customer/components/NavBar.dart';
import 'package:bike_customerv2/Customer/components/TabView/PaymentMethod.dart';
import 'package:bike_customerv2/Customer/components/TabView/WatitingTab.dart';
import 'package:bike_customerv2/Customer/components/booking/bookingCard.dart';
import 'package:bike_customerv2/Customer/components/booking/bookingFinishedCard.dart';
import 'package:bike_customerv2/Customer/components/booking/bookinginfomation.dart';
import 'package:bike_customerv2/Customer/helper/shared_prefs.dart';
import 'package:bike_customerv2/Customer/models/slot.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:bike_customerv2/Customer/provider/customer_provider.dart';
import 'package:bike_customerv2/Customer/screen/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable

class historyScreen extends StatefulWidget {
  @override
  State<historyScreen> createState() => _historyScreenState();
}

class _historyScreenState extends State<historyScreen>
    with SingleTickerProviderStateMixin {
  static int id = getCuctomerIDFromSharedPrefs();
  Future<List<CustomerTripFull>>? listTrip;
  @override
  void initState() {
    super.initState();
    listTrip = customerProvider.fetchCustomertripByID(id);
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Trip customerTrip;
    return Scaffold(
        appBar: AppBar(
          title: const Text('History Booking'),
          backgroundColor: Colors.orange,
        ),
        body: FutureBuilder<List<CustomerTripFull>>(
            future: listTrip,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                //List<CustomerTripFull>? listTrip = snapshot.data;
                return Center(
                    child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "List Booking",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flexible(
                        child: Container(
                      padding: EdgeInsets.fromLTRB(15, 5, 15, 10),
                      margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 240, 210, 159),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      width: MediaQuery.of(context).size.width,
                      height: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var trip =
                              snapshot.data![snapshot.data!.length - index - 1];
                          return InkWell(
                              onTap: () {
                                setState(() {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              bookingInfomation(trip)));
                                });
                              },
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                      width: 350,
                                      height: 170,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(12.0),
                                        border: Border.all(
                                            color: trip.status == 'STAND_BY'
                                                ? Color.fromARGB(
                                                    255, 7, 143, 255)
                                                : trip.status == 'WAITING'
                                                    ? Color.fromARGB(
                                                        255, 252, 235, 5)
                                                    : trip.status == 'CANCELED'
                                                        ? Color.fromARGB(
                                                            255, 252, 5, 5)
                                                        : Color.fromARGB(
                                                            255, 46, 252, 5),
                                            width: 5),
                                      ),
                                      child: BookingCard(
                                        trip: trip,
                                      )),
                                  SizedBox(
                                    height: 20,
                                  )
                                ],
                              ));
                        },
                      ),
                    )),
                  ],
                ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            }),
        bottomNavigationBar: NavBar());
  }
}
