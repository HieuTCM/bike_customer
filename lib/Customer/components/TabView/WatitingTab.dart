import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class WaitingTab extends StatefulWidget {
  Trip customerTrip;
  Function(Trip) callback;
  WaitingTab(this.customerTrip, this.callback);
  @override
  State<WaitingTab> createState() => _WaitingTabState();
}

class _WaitingTabState extends State<WaitingTab> {
  String? selectedValue;

  String pickupTime = 'Select Item';

  List<String> listTimePickup = getTimePickUp();
  List<String> Listtime = [];

  int indexTimePickup = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getTimePickup() {
    String timeStart = widget.customerTrip.timeStart;
    if (timeStart.isNotEmpty) {
      for (int i = 0; i <= listTimePickup.length; i++) {
        if (timeStart == listTimePickup[i]) {
          setState(() {
            indexTimePickup = i;
          });
          break;
        }
      }
      if (indexTimePickup != 0) {
        for (int y = indexTimePickup - 6; y < indexTimePickup; y++) {
          setState(() {
            Listtime.add(listTimePickup[y]);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Listtime.isEmpty) {
      if (widget.customerTrip.timeStart.isNotEmpty) {
        getTimePickup();
      }
      ;
    }

    return Column(
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
                  height: MediaQuery.of(context).size.height * 0.65 * 0.20,
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65 * 0.8,
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
                        userAgentPackageName: 'com.example.bike_customerv2',
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(children: [
                          const Text("From: ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                          Text(widget.customerTrip.headtoName,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0)))
                        ]),
                        SizedBox(
                          height: 6,
                        ),
                        Row(children: [
                          const Text("To: ",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0))),
                          SizedBox(
                            width: 25,
                          ),
                          Text(widget.customerTrip.headtoName,
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 0, 0, 0)))
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
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Text(widget.customerTrip.slotName,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 0, 0)))
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
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Text(widget.customerTrip.pickupTime,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(255, 0, 0, 0)))
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
                                  color: Color.fromARGB(255, 0, 0, 0))),
                          Text(
                              widget.customerTrip.amount.toString().substring(
                                      0,
                                      widget.customerTrip.amount
                                              .toString()
                                              .length -
                                          2) +
                                  " VNĐ",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Color.fromARGB(255, 236, 144, 5)))
                        ]),
                      ]),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
