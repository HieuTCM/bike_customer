import 'package:bike_customerv2/Customer/models/station.dart';
import 'package:provider/provider.dart';

class CustomerTrip {
  late final customerId;
  late final routeId;
  late final slotId;
  late final pickupStationId;
  late final headtoStationId;
  late final pickupTime;
  late final amount;

  CustomerTrip(
      {this.customerId,
      this.routeId,
      this.slotId,
      this.headtoStationId,
      this.pickupStationId,
      this.pickupTime,
      this.amount});

  CustomerTrip.fromJson(Map<String, dynamic> json) {
    customerId = json["customerId"];
    routeId = json["routeId"];
    slotId = json["slotId"];
    pickupStationId = json["pickupStationId"];
    headtoStationId = json["headtoStationId"];
    pickupTime = json["pickupTime"];
    amount = json["amount"];
  }
  Map<String, dynamic> toJSon() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["customerId"] = this.customerId;
    data["routeId"] = this.routeId;
    data["slotId"] = this.slotId;
    data["pickupStationId"] = this.pickupStationId;
    data["headtoStationId"] = this.headtoStationId;
    data["pickupTime"] = this.pickupTime;
    data["amount"] = this.amount;

    return data;
  }
}

class CustomerTripFull {
  late final id;
  late final customerId;
  late final routeId;
  late final slotId;
  late final pickupStationId;
  late Station pickupStation;
  late final headtoStationId;
  late Station headtoStation;
  late final pickupTime;
  late final amount;
  late final createDate;
  late final status;

  CustomerTripFull(
      {this.id,
      this.customerId,
      this.routeId,
      this.slotId,
      this.pickupStationId,
      required this.pickupStation,
      this.headtoStationId,
      required this.headtoStation,
      this.pickupTime,
      this.amount,
      this.createDate,
      this.status});
}

class Trip {
  int customerId;
  int routeId;

  int slotId;
  String slot;
  String slotName;
  String pickupTime;
  String timeStart;

  double amount;

  int pickupStationId;
  String pickupName;
  double latlgPickup;
  double longlgPickup;

  int headtoStationId;
  String headtoName;
  double latlgheadto;
  double longlgheadto;

  Trip(
      this.customerId,
      this.routeId,
      this.slotId,
      this.pickupStationId,
      this.headtoStationId,
      this.pickupTime,
      this.amount,
      this.latlgPickup,
      this.longlgPickup,
      this.latlgheadto,
      this.longlgheadto,
      this.headtoName,
      this.pickupName,
      this.slotName,
      this.slot,
      this.timeStart);
}
