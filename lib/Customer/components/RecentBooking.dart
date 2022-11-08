import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BokkingCard extends StatelessWidget {
  final Booking? booking;
  BokkingCard({this.booking});
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
                Text(booking!.date,
                    style: TextStyle(color: Color.fromARGB(255, 236, 144, 5)))
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
                      Text(booking!.from)
                    ]),
                    Row(
                      children: [
                        Text("\u2022   " + "To: ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0))),
                        Text(booking!.to)
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
                Text("\u2022   " + "Slot: ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0))),
                Text(booking!.slot)
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
              Text(booking!.cost + " VNĐ",
                  style: TextStyle(color: Color.fromARGB(255, 236, 144, 5)))
            ]),
            SizedBox(
              height: 10,
            ),
          ]),
    );
  }
}
