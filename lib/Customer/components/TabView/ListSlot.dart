import 'package:bike_customerv2/Customer/assets/data.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ListSlot extends StatefulWidget {
  Booking booking;
  Function(Booking) callback;
  ListSlot(this.booking, this.callback);
  @override
  State<ListSlot> createState() => _ListSlotState();
}

class _ListSlotState extends State<ListSlot> {
  @override
  Widget build(BuildContext context) {
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
                itemCount: listSlot.length,
                itemBuilder: (context, index) {
                  var slot = listSlot[index];
                  var count = index + 1;
                  if (!widget.booking.slot.isEmpty) {
                    if (listSlot[index].name == widget.booking.slot) {
                      listSlot[index].isSelected = true;
                    }
                  }
                  ;
                  return InkWell(
                      onTap: () {
                        setState(() {
                          for (int i = 0; i < listSlot.length; i++) {
                            if (listSlot[i].isSelected = true) {
                              listSlot[i].isSelected = false;
                            }
                          }
                          widget.booking.slot = slot.name;
                          slot.isSelected = true;
                          widget.callback(widget.booking);
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
                                  color: slot.isSelected
                                      ? Color.fromARGB(255, 85, 221, 92)
                                      : Colors.orange,
                                  width: 3),
                            ),
                            child: Center(
                              child: Text("Slot $count :" + slot.name),
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

  List<Slot> listSlot = getSlots();
}
