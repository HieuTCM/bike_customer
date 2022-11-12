import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:bike_customerv2/Customer/components/NavBar.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:bike_customerv2/Customer/provider/customer_provider.dart';
import 'package:bike_customerv2/Customer/screen/booking/historyScreen.dart';
import 'package:bike_customerv2/Customer/screen/mainScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class bookingInfomation extends StatefulWidget {
  CustomerTripFull trip;
  bookingInfomation(this.trip);
  @override
  State<bookingInfomation> createState() => _bookingInfomationState();
}

class _bookingInfomationState extends State<bookingInfomation> {
  cancelTrip() async {
    await customerProvider.cancelCusTrip(widget.trip.id).then((value) {
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
            context, MaterialPageRoute(builder: (context) => historyScreen()));
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
      slotId: widget.trip.slot.id,
      routeId: widget.trip.route.id,
      customerId: widget.trip.customerId.toString(),
      pickupStationId: widget.trip.pickupStationId.toString(),
      headtoStationId: widget.trip.headtoStationId.toString(),
      amount: widget.trip.amount.toString(),
      pickupTime: widget.trip.pickupTime.toString(),
    );

    await customerProvider.insCustomerTrip(trip).then((value) {
      if (value.isNotEmpty) {
        Fluttertoast.showToast(
            msg: "Booking Successful, Watting for driver ... ",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Color.fromARGB(255, 62, 177, 72),
            textColor: Colors.white,
            fontSize: 16.0);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => historyScreen()));
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Booking'),
          backgroundColor: Colors.orange,
        ),
        body: Container(
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
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.65,
                            //padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              // borderRadius: BorderRadius.only(
                              //     topLeft: Radius.circular(50),
                              //     topRight: Radius.circular(50)),
                            ),
                            child: Column(children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height *
                                    0.65 *
                                    0.20,
                                padding:
                                    const EdgeInsets.fromLTRB(15, 15, 15, 15),
                                decoration: const BoxDecoration(
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(50),
                                      topRight: Radius.circular(50)),
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height *
                                    0.65 *
                                    0.8,
                                child:
                                    //change map here
                                    FlutterMap(
                                  options: MapOptions(
                                    center: LatLng(51.509364, -0.128928),
                                    zoom: 9.2,
                                  ),
                                  nonRotatedChildren: [
                                    AttributionWidget.defaultWidget(
                                      source: 'OpenStreetMap contributors',
                                      onSourceTapped: null,
                                    ),
                                  ],
                                  children: [
                                    TileLayer(
                                      urlTemplate:
                                          'https://api.mapbox.com/styles/v1/pexinhpro26/clacind7n000014mae9q98bhk/wmts?access_token=pk.eyJ1IjoicGV4aW5ocHJvMjYiLCJhIjoiY2xhMTI2cWU2MDM5MzNvcGtkOWFxdXcxayJ9.LGyeOefV4CFf6ucU9KY__Q',
                                      userAgentPackageName:
                                          'com.example.bike_customerv2',
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height * 0.25,
                            padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
                            decoration: new BoxDecoration(
                              color: Color.fromARGB(255, 255, 255, 255),
                              borderRadius: new BorderRadius.only(
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50)),
                            ),
                            child: Column(
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Row(children: [
                                        const Text("From: ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        Text(widget.trip.pickupStation.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)))
                                      ]),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(children: [
                                        const Text("To: ",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Text(widget.trip.headtoStation.name,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)))
                                      ]),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          Text("Slot: ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          Text(widget.trip.slot.name,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      Row(
                                        children: [
                                          Text("PickUp Time: ",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0))),
                                          Text(
                                              widget.trip.pickupTime
                                                  .toString()
                                                  .substring(0, 5),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 0, 0, 0)))
                                        ],
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Row(children: [
                                        Text("Total: ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        Text(
                                            widget.trip.amount
                                                    .toString()
                                                    .substring(
                                                        0,
                                                        widget.trip.amount
                                                                .toString()
                                                                .length -
                                                            2) +
                                                " VNĐ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color.fromARGB(
                                                    255, 236, 144, 5))),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.12,
                                        ),
                                        Text(widget.trip.status,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: widget.trip.status ==
                                                        'STAND_BY'
                                                    ? Color.fromARGB(
                                                        255, 7, 143, 255)
                                                    : widget.trip.status ==
                                                            'WAITING'
                                                        ? Color.fromARGB(
                                                            255, 252, 235, 5)
                                                        : widget.trip.status ==
                                                                'CANCELED'
                                                            ? Color.fromARGB(
                                                                255, 252, 5, 5)
                                                            : Color.fromARGB(
                                                                255,
                                                                46,
                                                                252,
                                                                5)))
                                      ]),
                                    ]),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
              SizedBox(
                height: 20,
              ),
              Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.4,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.trip.status == 'STAND_BY'
                        ? Color.fromARGB(255, 236, 144, 5)
                        : widget.trip.status == 'WAITING'
                            ? Color.fromARGB(255, 107, 107, 107)
                            : Color.fromARGB(255, 31, 69, 238),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () => (widget.trip.status == 'STAND_BY')
                      ? cancelTrip()
                      : widget.trip.status == 'WAITING'
                          ? {}
                          : insCustomerTrip(),
                  child: Text(
                    (widget.trip.status == 'STAND_BY')
                        ? "Cancel"
                        : widget.trip.status == 'WAITING'
                            ? "Driver is Comming ..."
                            : 'Booking Again',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ])),
        bottomNavigationBar: NavBar());
  }
}
