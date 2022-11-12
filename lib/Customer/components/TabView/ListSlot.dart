import 'package:bike_customerv2/Customer/helper/shared_prefs.dart';
import 'package:bike_customerv2/Customer/models/slot.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:bike_customerv2/Customer/provider/customer_provider.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListSlot extends StatefulWidget {
  Trip customerTrip;
  Function(Trip) callback;
  ListSlot(this.customerTrip, this.callback);
  @override
  State<ListSlot> createState() => _ListSlotState();
}

class _ListSlotState extends State<ListSlot> {
  static int id = getCuctomerIDFromSharedPrefs();
  Future<List<Slot>>? slot;

  @override
  void initState() {
    super.initState();
    slot = customerProvider.fetchAllSlot();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Map isSelected = {};
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Slot>>(
      future: slot,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Slot>? listSlot = snapshot.data;
          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: Column(
                children: [
                  Text(
                    "Select Slot",
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
                        var slot = snapshot.data![index];
                        (widget.customerTrip.slotId == slot.id)
                            ? isSelected.putIfAbsent(index, () => 1)
                            : isSelected.putIfAbsent(index, () => 0);
                        if (widget.customerTrip.slotId == '') {
                          if (slot.id == widget.customerTrip.slotId) {
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
                                widget.customerTrip.slotId = slot.id;
                                widget.customerTrip.slotName = slot.name +
                                    " : " +
                                    slot.timeStart.toString().substring(0, 5) +
                                    " - " +
                                    slot.timeEnd.toString().substring(0, 5);
                                widget.customerTrip.slot = slot.name;
                                widget.customerTrip.timeStart =
                                    slot.timeStart.toString().substring(0, 5);
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
                                    child: Text(slot.name +
                                        " : " +
                                        slot.timeStart
                                            .toString()
                                            .substring(0, 5) +
                                        " - " +
                                        slot.timeEnd
                                            .toString()
                                            .substring(0, 5)),
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
        return const CircularProgressIndicator();
      },
    );

    // Container(
    //     width: MediaQuery.of(context).size.width,
    //     height: MediaQuery.of(context).size.height * 0.65,
    //     child: Column(
    //       children: [
    //         Text(
    //           "Select Slot",
    //           style: TextStyle(
    //             fontSize: 25,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         Expanded(
    //           child: ListView.builder(
    //             shrinkWrap: true,
    //             itemCount: listSlot.length,
    //             itemBuilder: (context, index) {
    //               var slot = listSlot[index];
    //               var count = index + 1;
    //               if (!widget.booking.slot.isEmpty) {
    //                 if (listSlot[index].name == widget.booking.slot) {
    //                   listSlot[index].isSelected = true;
    //                 }
    //               }
    //               ;
    //               return InkWell(
    //                   onTap: () {
    //                     setState(() {
    //                       for (int i = 0; i < listSlot.length; i++) {
    //                         if (listSlot[i].isSelected = true) {
    //                           listSlot[i].isSelected = false;
    //                         }
    //                       }
    //                       widget.booking.slot = slot.name;
    //                       slot.isSelected = true;
    //                       widget.callback(widget.booking);
    //                     });
    //                   },
    //                   child: Column(
    //                     children: [
    //                       SizedBox(
    //                         height: 20,
    //                       ),
    //                       Container(
    //                         width: 350,
    //                         height: 50,
    //                         decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(12.0),
    //                           border: Border.all(
    //                               color: slot.isSelected
    //                                   ? Color.fromARGB(255, 85, 221, 92)
    //                                   : Colors.orange,
    //                               width: 3),
    //                         ),
    //                         child: Center(
    //                           child: Text("Slot $count :" + slot.name),
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         height: 20,
    //                       )
    //                     ],
    //                   ));
    //             },
    //           ),
    //         )
    //       ],
    //     ));
  }
}
