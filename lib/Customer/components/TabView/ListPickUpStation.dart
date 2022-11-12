import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:bike_customerv2/Customer/helper/shared_prefs.dart';
import 'package:bike_customerv2/Customer/models/station.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:bike_customerv2/Customer/provider/customer_provider.dart';
import 'package:bike_customerv2/Customer/screen/booking/bookingScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class ListPickUpStation extends StatefulWidget {
  Trip customerTrip;
  Function(Trip) callback;
  Function() getRoute;
  Function(int) setPickup;
  Function(int) setHeadto;
  ListPickUpStation(this.customerTrip, this.callback, this.getRoute,
      this.setPickup, this.setHeadto);

  @override
  State<ListPickUpStation> createState() => _ListPickUpStationState();
}

class _ListPickUpStationState extends State<ListPickUpStation> {
  static int id = getCuctomerIDFromSharedPrefs();
  String route = '';
  int indexpickup = 0;
  Future<List<Station>>? station;
  void getStation() {
    setState(() {
      station =
          customerProvider.fetchStationByRoutedID(widget.customerTrip.routeId);
      customerProvider
          .fetchRoutebyid(widget.customerTrip.routeId)
          .then((value) => {route = value.placeFrom + ' - ' + value.placeTo});
    });
  }

  @override
  void initState() {
    isChoosePickUpStation = false;
    if (widget.customerTrip.routeId != 0) {
      setState(() {
        getStation();
      });
    }
    ;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map isSelectedPickup = {};
  Map isSelectedHeadto = {};
  bool isChoosePickUpStation = false;
  @override
  Widget build(BuildContext context) {
    if (station == null) {
      if (widget.customerTrip.amount != 0) {
        getStation();
      }
    }

    return Column(
      children: [
        if (station == null)
          ElevatedButton(
              onPressed: (() {
                getStation();
              }),
              child: Text('Get Station')),
        SizedBox(
          height: 5,
        ),
        if (station != null)
          FutureBuilder<List<Station>>(
            future: station,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Station>? listStation = snapshot.data;
                if (listStation!.isEmpty) {
                  return Column(
                    children: [
                      Text('Route : ' + route + ' has no Station',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                      ElevatedButton(
                          onPressed: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        bookingScreen(1, widget.customerTrip)));
                          }),
                          child: Text('Choose another Station'))
                    ],
                  );
                } else {
                  return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.65 * 0.5,
                      child: Column(
                        children: [
                          Text(
                            "Select Pickkup Station",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data!.length - 1,
                              itemBuilder: (context, index) {
                                var station = snapshot.data![index];
                                (widget.customerTrip.pickupStationId ==
                                        station.id)
                                    ? isSelectedPickup.putIfAbsent(
                                        index, () => 1)
                                    : isSelectedPickup.putIfAbsent(
                                        index, () => 0);
                                if (widget.customerTrip.pickupStationId == '') {
                                  if (station.id ==
                                      widget.customerTrip.pickupStationId) {
                                    isSelectedPickup[index] = 1;
                                  }
                                }
                                ;
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        for (var i in isSelectedPickup.keys) {
                                          isSelectedPickup[i] = 0;
                                        }
                                        widget.setPickup(index);
                                        isSelectedPickup[index] = 1;
                                        widget.customerTrip.pickupStationId =
                                            station.id;
                                        isChoosePickUpStation = true;
                                        indexpickup = index;
                                        widget.customerTrip.latlgPickup =
                                            station.latitude;
                                        widget.customerTrip.longlgPickup =
                                            station.longtitude;
                                        widget.customerTrip.pickupName =
                                            station.name;
                                        widget.callback(widget.customerTrip);
                                      });
                                    },
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Container(
                                          width: 350,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.0),
                                            border: Border.all(
                                                color:
                                                    isSelectedPickup[index] == 0
                                                        ? Colors.orange
                                                        : Colors.green,
                                                width: 3),
                                          ),
                                          child: Center(
                                            child: Text(station.name),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        )
                                      ],
                                    ));
                              },
                            ),
                          )
                        ],
                      ));
                }
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        if (isChoosePickUpStation == true)
          FutureBuilder<List<Station>>(
            future: station,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Station>? listStation = snapshot.data;
                return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65 * 0.5,
                    child: Column(
                      children: [
                        Text(
                          "Select Headto Station",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              var station = snapshot.data![index];
                              (widget.customerTrip.headtoStationId ==
                                      station.id)
                                  ? isSelectedHeadto.putIfAbsent(index, () => 1)
                                  : isSelectedHeadto.putIfAbsent(
                                      index, () => 0);
                              if (widget.customerTrip.headtoStationId == '') {
                                if (station.id ==
                                    widget.customerTrip.headtoStationId) {
                                  isSelectedHeadto[index] = 1;
                                }
                              }
                              ;
                              return InkWell(
                                  onTap: () {
                                    if (index <= indexpickup) {
                                    } else {
                                      setState(() {
                                        for (var i in isSelectedHeadto.keys) {
                                          isSelectedHeadto[i] = 0;
                                        }
                                        widget.setHeadto(index);
                                        isSelectedHeadto[index] = 1;
                                        widget.customerTrip.headtoStationId =
                                            station.id;
                                        widget.customerTrip.latlgheadto =
                                            station.latitude;
                                        widget.customerTrip.longlgheadto =
                                            station.longtitude;
                                        widget.customerTrip.headtoName =
                                            station.name;
                                        widget.callback(widget.customerTrip);
                                      });
                                    }
                                    ;
                                  },
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Container(
                                        width: 350,
                                        height: 50,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          border: Border.all(
                                              color: index <= indexpickup
                                                  ? Colors.grey
                                                  : isSelectedHeadto[index] == 0
                                                      ? Colors.orange
                                                      : Colors.green,
                                              width: 3),
                                        ),
                                        child: Center(
                                          child: Text(station.name),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      )
                                    ],
                                  ));
                            },
                          ),
                        )
                      ],
                    ));
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return Text('');
            },
          )
      ],
    );
  }
}
