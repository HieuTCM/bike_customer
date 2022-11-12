import 'dart:convert';

import 'package:bike_customerv2/Customer/components/TabView/ConfirmTab.dart';
import 'package:bike_customerv2/Customer/components/TabView/ListRoute.dart';
import 'package:bike_customerv2/Customer/components/TabView/ListPickUpStation.dart';
import 'package:bike_customerv2/Customer/components/TabView/ListSlot.dart';
import 'package:bike_customerv2/Customer/components/NavBar.dart';
import 'package:bike_customerv2/Customer/components/TabView/PaymentMethod.dart';
import 'package:bike_customerv2/Customer/components/TabView/WatitingTab.dart';
import 'package:bike_customerv2/Customer/helper/shared_prefs.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:bike_customerv2/Customer/provider/customer_provider.dart';
import 'package:bike_customerv2/Customer/screen/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// ignore: must_be_immutable

class bookingScreen extends StatefulWidget {
  int tabIndex;
  Trip customerTrip;
  bookingScreen(this.tabIndex, this.customerTrip);
  @override
  State<bookingScreen> createState() => _bookingScreenState();
}

class _bookingScreenState extends State<bookingScreen>
    with SingleTickerProviderStateMixin {
  static int id = getCuctomerIDFromSharedPrefs();
  late final PaymentMethod paymentMethod;
  int count = 0;
  String Button = "Continue";
  bool isSelected = false;
  bool selectDone = false;
  bool isSetTimePickup = false;
  int pickupIndex = 0;
  int headtoindex = 0;
  int tripID = 0;
  setpickupIndex(int pickup) {
    setState(() {
      pickupIndex = pickup;
    });
  }

  setheadtoindex(int headto) {
    setState(() {
      headtoindex = headto;
    });
  }

  checkStation() {
    if (!(headtoindex <= pickupIndex)) {
      setState(() {
        selectDone = true;
      });
    } else {
      selectDone = false;
    }
  }

  cancelTrip() async {
    await customerProvider.cancelCusTrip(tripID).then((value) {
      if (value.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Cancel Booking Successful",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 62, 177, 72),
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => mainScreen()));
      } else {
        Fluttertoast.showToast(
            msg: "Cancel Booking Fail ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  insCustomerTrip() async {
    CustomerTrip trip = new CustomerTrip(
      slotId: widget.customerTrip.slotId.toString(),
      routeId: widget.customerTrip.routeId.toString(),
      customerId: widget.customerTrip.customerId.toString(),
      pickupStationId: widget.customerTrip.pickupStationId.toString(),
      headtoStationId: widget.customerTrip.headtoStationId.toString(),
      amount: widget.customerTrip.amount.toString(),
      pickupTime: widget.customerTrip.pickupTime.toString(),
    );

    await customerProvider.insCustomerTrip(trip).then((value) {
      if (value.isNotEmpty) {
        setState(() {
          tripID = (json.decode(value)['id']);
        });
        Fluttertoast.showToast(
            msg: "Booking Successful, Watting for driver ... ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 62, 177, 72),
            textColor: Colors.white,
            fontSize: 16.0);
        incrementCounter();
      } else {
        Fluttertoast.showToast(
            msg: "Booking Fail ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    });
  }

  checkTimePickup() {
    if (widget.customerTrip.pickupTime.isNotEmpty) {
      isSetTimePickup = true;
    }
  }

  callback(Trip bookingValue) {
    setState(() {
      widget.customerTrip.slotId = bookingValue.slotId;
      widget.customerTrip.routeId = bookingValue.routeId;
      widget.customerTrip.pickupTime = bookingValue.pickupTime;
      widget.customerTrip.pickupStationId = bookingValue.pickupStationId;
      widget.customerTrip.headtoStationId = bookingValue.headtoStationId;
      widget.customerTrip.customerId = bookingValue.customerId;
      widget.customerTrip.amount = bookingValue.amount;
      widget.customerTrip.pickupName = bookingValue.pickupName;
      widget.customerTrip.headtoName = bookingValue.headtoName;
      isSelected = true;
    });
    checkStation();
  }

  getRoute() {
    setState(() {
      count = 1;
      isSelected = false;
    });
  }

  void incrementCounter() {
    setState(() {
      count < 6 ? count++ : count = 5;

      if (count >= 3) {
        isSelected = true;
      } else {
        isSelected = false;
      }
    });

    checkState();
  }

  void decrementCounter() {
    setState(() {
      count--;
      isSelected = true;
    });
    checkState();
  }

  void resetCounter() {
    cancelTrip();
  }

  void checkState() {
    if (count < 4) {
      setState(() {
        Button = "continue";
      });
    }
    if (count == 4) {
      setState(() {
        Button = "Confirm";
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
                        child: ListSlot(widget.customerTrip, callback),
                      ),
                      Container(
                        child: ListRoute(widget.customerTrip, callback),
                      ),
                      Container(
                        child: ListPickUpStation(widget.customerTrip, callback,
                            getRoute, setpickupIndex, setheadtoindex),
                      ),
                      Container(
                        child: PaymentMethod(
                            widget.customerTrip, callback, checkTimePickup),
                      ),
                      Container(
                        child: ConfirmTab(widget.customerTrip, callback),
                      ),
                      Container(
                        child: WaitingTab(widget.customerTrip, callback),
                      ),
                    ],
                  )),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  (count != 0 && Button != "Cancel")
                      ? Container(
                          height: 50.0,
                          width: MediaQuery.of(context).size.width * 0.4,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 255, 160, 0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                            ),
                            onPressed: () => {decrementCounter()},
                            child: Text(
                              "Previous",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
                      : SizedBox(
                          width: MediaQuery.of(context).size.width * 0.16,
                        ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  Container(
                    height: 50.0,
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 255, 160, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      ),
                      onPressed: () => !isSelected
                          ? {
                              Fluttertoast.showToast(
                                  msg: "Select Your Choose ",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0)
                            }
                          : count == 2 && !selectDone
                              ? {
                                  Fluttertoast.showToast(
                                      msg: "Select Headto Station ",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.CENTER,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.red,
                                      textColor: Colors.white,
                                      fontSize: 16.0)
                                }
                              : count == 3 && !isSetTimePickup
                                  ? {
                                      Fluttertoast.showToast(
                                          msg: "Select Pickup Time ",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.red,
                                          textColor: Colors.white,
                                          fontSize: 16.0)
                                    }
                                  : (Button == "Confirm")
                                      ? insCustomerTrip()
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
                ],
              ),
            ]),
          ),
        ),
        bottomNavigationBar: NavBar());
  }
}
