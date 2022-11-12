class Slot {
  late final id;
  late final name;
  late final timeStart;
  late final timeEnd;
  late final status;
  Slot({this.id, this.name, this.timeStart, this.timeEnd, this.status});

  Slot.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    timeStart = json["timeStart"];
    timeEnd = json["timeEnd"];
    status = json["status"];
  }
  Map<String, dynamic> toJSon() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["name"] = this.name;
    data["timeStart"] = this.timeStart;
    data["timeEnd"] = this.timeEnd;
    data["status"] = this.status;
    return data;
  }
}
