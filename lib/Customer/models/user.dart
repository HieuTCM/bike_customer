import 'dart:math';

import 'package:bike_customerv2/Customer/models/trip.dart';

class Customer {
  late final Accountid;
  late final Customerid;
  late final name;
  late final phone;
  late final password;
  late final gender;
  late final email;
  late final totalTrip;
  late final dateCreated;
  late final status;
  late final img;

  Customer(
      {this.Accountid,
      this.Customerid,
      this.name,
      this.phone,
      this.password,
      this.gender,
      this.email,
      this.totalTrip,
      this.dateCreated,
      this.status,
      this.img});
  Customer.formJson(Map<String, dynamic> json) {
    Accountid = json["id"];
    email = json["email"];
    phone = json["phone"];
    password = json["password"];
    name = json["name"];
    img = json["img"];
    gender = json["gender"];
    totalTrip = json["totalTrip"];
    dateCreated = json["dateCreated"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.Accountid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['img'] = this.img;
    data['gender'] = this.gender;
    data['totalTrip'] = this.totalTrip;
    return data;
  }
}

class Driver {
  late final Accountid;
  late final Driverid;
  late final name;
  late final phone;
  late final password;
  late final gender;
  late final email;
  late final totalTrip;
  late final dateCreated;
  late final status;
  late final img;

  Driver(
      {this.Accountid,
      this.Driverid,
      this.name,
      this.phone,
      this.password,
      this.gender,
      this.email,
      this.totalTrip,
      this.dateCreated,
      this.status,
      this.img});
  Driver.formJson(Map<String, dynamic> json) {
    Accountid = json["id"];
    email = json["email"];
    phone = json["phone"];
    password = json["password"];
    name = json["name"];
    img = json["img"];
    gender = json["gender"];
    totalTrip = json["totalTrip"];
    dateCreated = json["dateCreated"];
    status = json["status"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.Accountid;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['password'] = this.password;
    data['img'] = this.img;
    data['gender'] = this.gender;
    data['totalTrip'] = this.totalTrip;
    return data;
  }
}
