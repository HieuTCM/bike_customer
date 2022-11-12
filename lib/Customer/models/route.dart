class Routes {
  late final id;
  late final placeFrom;
  late final placeTo;
  late final DefaultCost;
  late final Status;

  Routes(
      {this.id, this.placeFrom, this.placeTo, this.DefaultCost, this.Status});
  Routes.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    placeFrom = json["placeFrom"];
    placeTo = json["placeTo"];
    DefaultCost = json["DefaultCost"];
    Status = json["Status"];
  }
  Map<String, dynamic> toJSon() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.id;
    data["placeFrom"] = this.placeFrom;
    data["placeTo"] = this.placeTo;
    data["DefaultCost"] = this.DefaultCost;
    data["status"] = this.Status;
    return data;
  }
}

// class ListRoute {
//   late final totalPage;
//   late final totalElements;
//   late final List<Route> routeList;

//   ListRoute({this.totalPage, this.totalElements, required this.routeList});

//   ListRoute.fromJson(Map<String, dynamic> json) {
//     totalPage = json["totalPage"];
//     totalElements = json["totalElements"];
//     routeList = json["routeList"];
//   }

//   Map<String, dynamic> toJSon() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data["totalPage"] = this.totalPage;
//     data["totalElements"] = this.totalElements;
//     data["routeList"] = this.routeList;
//     return data;
//   }
// }
