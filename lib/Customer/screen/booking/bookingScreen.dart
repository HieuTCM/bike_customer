import 'dart:developer';

import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:bike_customerv2/Customer/components/TabView/ConfirmTab.dart';
import 'package:bike_customerv2/Customer/components/TabView/LIstFrom.dart';
import 'package:bike_customerv2/Customer/components/TabView/LIstTo.dart';
import 'package:bike_customerv2/Customer/components/TabView/ListSlot.dart';
import 'package:bike_customerv2/Customer/components/NavBar.dart';
import 'package:bike_customerv2/Customer/components/TabView/PaymentMethod.dart';
import 'package:bike_customerv2/Customer/components/TabView/WatitingTab.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class bookingScreen extends StatefulWidget {
  int tabIndex;
  Booking booking;
  bookingScreen(this.tabIndex, this.booking);
  @override
  State<bookingScreen> createState() => _bookingScreenState();
}

class _bookingScreenState extends State<bookingScreen>
    with SingleTickerProviderStateMixin {
  int count = 0;
  String Button = "Continue";
  bool isSelected = false;

  callback(Booking bookingValue) {
    setState(() {
      isSelected = true;
      widget.booking.slot = bookingValue.slot;
      widget.booking.from = bookingValue.from;
      widget.booking.to = bookingValue.to;
      widget.booking.cost = bookingValue.cost;
      widget.booking.date = bookingValue.date;
    });
  }

  void incrementCounter() {
    setState(() {
      print(count);
      count < 6 ? count++ : count = 5;
      isSelected = false;
    });
    checkState();
  }

  void resetCounter() {
    setState(() {
      count = 0;
      Button = "Continue";
    });
  }

  void checkState() {
    if (count == 4) {
      setState(() {
        Button = "Conform";
        isSelected = true;
      });
    }
    if (count == 5) {
      setState(() {
        Button = "Cancel";
        isSelected = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    count = widget.tabIndex;
    checkState();
  }

  @override
  void dispose() {
    //_tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
          backgroundColor: Colors.orange,
        ),
        body: DefaultTabController(
          length: 5,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0),
              ),
            ),
            child: Column(children: <Widget>[
              Material(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                  // borderRadius: BorderRadius.circular(12.0),
                  child: IndexedStack(
                    index: count,
                    children: [
                      Container(
                        child: ListSlot(widget.booking, callback),
                      ),
                      Container(
                        child: ListFrom(widget.booking, callback),
                      ),
                      Container(
                        child: ListTo(widget.booking, callback),
                      ),
                      Container(
                        child: PaymentMethod(widget.booking, callback),
                      ),
                      Container(
                        child: ConfirmTab(widget.booking, callback),
                      ),
                      Container(
                        child: WaitingTab(widget.booking, callback),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50.0,
                width: 200,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 255, 160, 0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () => !isSelected
                      ? {}
                      : (Button == "Cancel"
                          ? resetCounter()
                          : incrementCounter()),
                  child: Text(
                    "$Button",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ]),
          ),
        ),
        bottomNavigationBar: NavBar());
  }
}
