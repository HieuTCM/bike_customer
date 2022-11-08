import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class WaitingTab extends StatefulWidget {
  Booking booking;
  Function(Booking) callback;
  WaitingTab(this.booking, this.callback);
  @override
  State<WaitingTab> createState() => _WaitingTabState();
}

class _WaitingTabState extends State<WaitingTab> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: MediaQuery.of(context).size.height - 250,
                //   child: FlutterMap(
                //     options: new MapOptions(
                //       center: LatLng(10.841122, 106.809965),
                //       zoom: 15.0,
                //     ),
                //     nonRotatedChildren: [
                //       AttributionWidget.defaultWidget(
                //         source: 'OpenStreetMap contributors',
                //         onSourceTapped: () {},
                //       ),
                //     ],
                //     children: [
                //       TileLayer(
                //         urlTemplate:
                //             'https://api.mapbox.com/styles/v1/pexinhpro26/cl9ps79th000r15nwixky2qer/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoicGV4aW5ocHJvMjYiLCJhIjoiY2w5cHJ6M3hnMGJmajN2bXBhajl5NGQweCJ9.yrJWxXo_mVUI0q-7_yJqfg',
                //         userAgentPackageName:
                //             'dev.fleaflet.flutter_map.example',
                //         additionalOptions: {
                //           'accessToken':
                //               'pk.eyJ1IjoicGV4aW5ocHJvMjYiLCJhIjoiY2w5cHJ6M3hnMGJmajN2bXBhajl5NGQweCJ9.yrJWxXo_mVUI0q-7_yJqfg',
                //           'id': 'mapbox.mapbox-streets-v8'
                //         },
                //       ),
                //       MarkerLayer(
                //         markers: [
                //           Marker(
                //             point: LatLng(10.841122, 106.809965),
                //             builder: (ctx) {
                //               return Column(children: <Widget>[
                //                 Text(
                //                   "You",
                //                   style: TextStyle(
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 10),
                //                 ),
                //                 Container(
                //                     child: Icon(
                //                   Icons.location_on,
                //                   size: 18,
                //                   color: Colors.blueAccent,
                //                 ))
                //               ]);
                //             },
                //           )
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Waiting for driver . . .",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                            const SizedBox(
                              height: 35,
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
                                              color: Color.fromARGB(
                                                  255, 0, 0, 0))),
                                      Text(widget.booking.from,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0)))
                                    ]),
                                    SizedBox(
                                      height: 35,
                                    ),
                                    Row(
                                      children: [
                                        Text("\u2022   " + "To: ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0))),
                                        Text(widget.booking.to,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0)))
                                      ],
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Text("\u2022   " + "Slot: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0))),
                                Text(widget.booking.slot,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 0, 0, 0)))
                              ],
                            ),
                            SizedBox(
                              height: 35,
                            ),
                            Row(children: [
                              Text("\u2022   " + "Total: ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 0, 0, 0))),
                              Text(widget.booking.cost + " VNĐ",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 236, 144, 5)))
                            ]),
                            SizedBox(
                              height: 35,
                            ),
                            Row(
                              children: [
                                Text("\u2022   " + "Payment Method: ",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 0, 0, 0))),
                                Text(widget.booking.Payment,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Color.fromARGB(255, 0, 0, 0)))
                              ],
                            ),
                          ]),
                    ],
                  ),
                )
              ],
            ),
          ],
        ));
  }

  List<Payment> listPayment = getPayments();
}
