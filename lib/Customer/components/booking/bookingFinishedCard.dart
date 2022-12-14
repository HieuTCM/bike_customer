import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BookingCard extends StatelessWidget {
  final CustomerTripFull? trip;
  BookingCard({this.trip});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("\u2022   " + "Date: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
                Text(trip!.createDate.toString().substring(0, 10),
                    style: TextStyle(color: Color.fromARGB(255, 236, 144, 5))),
                Spacer(),
                Text(
                  trip!.status,
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: trip!.status == 'STAND_BY'
                          ? Color.fromARGB(255, 7, 143, 255)
                          : trip!.status == 'WAITING'
                              ? Color.fromARGB(255, 252, 235, 5)
                              : trip!.status == 'CANCELED'
                                  ? Color.fromARGB(255, 252, 5, 5)
                                  : Color.fromARGB(255, 46, 252, 5)),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text("\u2022   " + "Route: ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 0, 0, 0))),
            Row(
              children: [
                SizedBox(
                  width: 30,
                ),
                Flexible(
                    child: Column(
                  children: <Widget>[
                    Row(children: [
                      Text("\u2022   " + "From: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 0, 0, 0))),
                      Text(trip!.pickupStation.name)
                    ]),
                    Row(
                      children: [
                        Text("\u2022   " + "To: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0))),
                        Text(trip!.headtoStation.name)
                      ],
                    ),
                  ],
                )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Text("\u2022   " + "Time: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
                Text(trip!.slot.name)
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(children: [
              Text("\u2022   " + "Cost: ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0))),
              Text(trip!.amount.toString() + " VN??",
                  style: TextStyle(color: Color.fromARGB(255, 236, 144, 5)))
            ]),
            SizedBox(
              height: 10,
            ),
          ]),
    );
  }
}
