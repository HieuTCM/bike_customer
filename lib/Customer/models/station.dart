import 'dart:convert';

class Station {
  late final id;
  late final name;
  late final address;
  late final img;
  late final latitude;
  late final longtitude;
  Station(
      {this.id,
      this.name,
      this.address,
      this.img,
      this.latitude,
      this.longtitude});

  Station.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = utf8.decode(json["name"]);
    address = utf8.decode(json["address"]);
    img = json["img"];
    latitude = json["latitude"];
    longtitude = json["longtitude"];
  }
  Map<String, dynamic> toJSon() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["address"] = this.address;
    data["img"] = this.img;
    data["latitude"] = this.latitude;
    data["longtitude"] = this.longtitude;
    return data;
  }
}
