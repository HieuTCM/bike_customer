import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:dropdown_button2/dropdown_button2.dart';

// ignore: must_be_immutable
class PaymentMethod extends StatefulWidget {
  Trip customerTrip;
  Function(Trip) callback;

  Function() setPickupTime;
  PaymentMethod(this.customerTrip, this.callback, this.setPickupTime);
  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
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
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: Column(children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65 * 0.6,
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.65 * 0.33,
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                ),
              ]),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              padding: const EdgeInsets.fromLTRB(25, 15, 15, 15),
              decoration: new BoxDecoration(
                color: Color.fromARGB(255, 255, 255, 255),
                borderRadius: new BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50)),
              ),
              child: Column(
                children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(
                          height: 10,
                        ),
                        const Text("\u2022   " + "Route: ",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0))),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            const SizedBox(
                              width: 30,
                            ),
                            Flexible(
                                child: Column(
                              children: <Widget>[
                                Row(children: [
                                  const Text("\u2022   " + "From: ",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color.fromARGB(255, 0, 0, 0))),
                                  Text(widget.customerTrip.pickupName,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: Color.fromARGB(255, 0, 0, 0)))
                                ]),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    Text("\u2022   " + "To: ",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0))),
                                    Text(widget.customerTrip.headtoName,
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(255, 0, 0, 0)))
                                  ],
                                ),
                              ],
                            )),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("\u2022   " + "Slot: ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            Text(widget.customerTrip.slotName,
                                style: TextStyle(
                                    fontSize: 18,
                                    color: Color.fromARGB(255, 0, 0, 0)))
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Text("\u2022   " + "PickUp Time: ",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 0, 0, 0))),
                            SizedBox(
                              width: 10,
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton2(
                                dropdownMaxHeight: 150,
                                hint: Text(
                                  pickupTime,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Theme.of(context).hintColor,
                                  ),
                                ),
                                items: Listtime.map(
                                    (item) => DropdownMenuItem<String>(
                                          value: item,
                                          child: Text(
                                            item,
                                            style: const TextStyle(
                                              fontSize: 18,
                                            ),
                                          ),
                                        )).toList(),
                                value: selectedValue,
                                onChanged: (value) {
                                  setState(() {
                                    selectedValue = value as String;
                                    widget.customerTrip.pickupTime =
                                        '${selectedValue!}:00';
                                    pickupTime = selectedValue as String;
                                    widget.setPickupTime.call();
                                  });
                                },
                                buttonHeight: 40,
                                buttonWidth: 140,
                                itemHeight: 40,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(children: [
                          Text("\u2022   " + "Total: ",
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
                                  fontSize: 20,
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
