import 'package:bike_customerv2/Customer/helper/shared_prefs.dart';
import 'package:bike_customerv2/Customer/models/route.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:bike_customerv2/Customer/provider/customer_provider.dart';
import 'package:flutter/material.dart';
//import 'package:latlong2/latlong.dart';

// ignore: must_be_immutable
class ListRoute extends StatefulWidget {
  Trip customerTrip;
  Function(Trip) callback;
  ListRoute(this.customerTrip, this.callback);
  @override
  State<ListRoute> createState() => _ListRouteState();
}

class _ListRouteState extends State<ListRoute> {
  static int id = getCuctomerIDFromSharedPrefs();
  Future<List<Routes>>? route;
  //String selected = 'Gigashots - Voolith';
  @override
  void initState() {
    super.initState();
    route = customerProvider.fetchAllRoute();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map isSelected = {};
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var width = MediaQuery.of(context).size.width;

    return FutureBuilder<List<Routes>>(
      future: route,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Routes>? listSlot = snapshot.data;
          int size = listSlot!.length;
          // List<String> doubleList = List<String>.generate(
          //     size,
          //     (int index) =>

          //         listSlot[index].placeFrom +
          //         ' - ' +
          //         listSlot[index].placeTo);

          // List<DropdownMenuItem> menuItemList = doubleList
          //     .map((val) => DropdownMenuItem(value: val, child: Text(val)))
          //     .toList();

          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(children: [
                Text(
                  "Select Route",
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
                      var route = snapshot.data![index];
                      (widget.customerTrip.routeId == route.id)
                          ? isSelected.putIfAbsent(index, () => 1)
                          : isSelected.putIfAbsent(index, () => 0);
                      if (widget.customerTrip.routeId == '') {
                        if (route.id == widget.customerTrip.routeId) {
                          isSelected[index] = 1;
                        }
                      }
                      ;
                      return InkWell(
                          onTap: () {
                            setState(() {
                              for (var i in isSelected.keys) {
                                isSelected[i] = 0;
                              }
                              isSelected[index] = 1;
                              widget.customerTrip.routeId = route.id;
                              widget.customerTrip.amount = route.DefaultCost;
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
                                  borderRadius: BorderRadius.circular(12.0),
                                  border: Border.all(
                                      color: isSelected[index] == 0
                                          ? Colors.orange
                                          : Colors.green,
                                      width: 3),
                                ),
                                child: Center(
                                  child: Text(
                                      route.placeFrom + ' - ' + route.placeTo),
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
              ]));
          // DecoratedBox(
          //     decoration: BoxDecoration(
          //         color: const Color.fromARGB(255, 255, 160, 0),
          //         border: Border.all(color: Colors.black38, width: 3),
          //         borderRadius: BorderRadius.circular(50),
          //         boxShadow: const <BoxShadow>[
          //           BoxShadow(
          //               color: Color.fromRGBO(0, 0, 0, 0.57), blurRadius: 5)
          //         ]),
          //     child: Padding(
          //         padding: const EdgeInsets.only(left: 30, right: 30),
          //         child: DropdownButton(
          //           value: selected,
          //           onChanged: (val) => setState(() => {
          //                 selected = val,
          //                 widget.customerTrip.routeId = ,
          //                 widget.callback(widget.customerTrip)
          //               }),
          //           items: menuItemList,
          //           icon: Padding(
          //               //Icon at tail, arrow bottom is default icon
          //               padding: EdgeInsets.only(left: 20),
          //               child: Icon(Icons.arrow_circle_down_sharp)),
          //           iconEnabledColor: Colors.white, //Icon color
          //           style: TextStyle(
          //               //te
          //               color: Colors.white, //Font color
          //               fontSize: 20 //font size on dropdown button
          //               ),
          //           dropdownColor: Color.fromARGB(
          //               255, 202, 163, 96), //dropdown background color
          //           underline: Container(), //remove underline
          //           isExpanded: true, //make true to make width 100%
          //         )));
          // ;
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
    );
  }
}
