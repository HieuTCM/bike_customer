import 'package:bike_customerv2/Customer/helper/shared_prefs.dart';
import 'package:bike_customerv2/Customer/models/route.dart';
import 'package:bike_customerv2/Customer/models/slot.dart';
import 'package:bike_customerv2/Customer/models/station.dart';
import 'package:bike_customerv2/Customer/models/tokenAuthenticate.dart';
import 'package:bike_customerv2/Customer/models/trip.dart';
import 'package:bike_customerv2/Customer/models/user.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class customerProvider {
  static String token = getTokenAuthenFromSharedPrefs();

  static const String _mainUrl = 'https://another-bikeke2.herokuapp.com';
  //_header
  static final Map<String, String> _header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    'Accept-Charset': 'UTF-8',
    "Authorization": 'Bearer $token'
  };
  //token Authorization
  static const String _Authenticate = '/api/v1/auth/customer';

//Booking
  static const String _createCustomerTrip = '/api/v1/customer-trip/create';
  static const String _cancelCustomerTrip = '/api/v1/customer-trip/cancel/';
  static const String _getAllBookingByCustomerID =
      '/api/v1/customer-trip/find-by-customer?customerId=';

//customer
  static const String _getCustomerByID =
      '/api/v1/customer/'; /*/api/v1/customer/{id} */
  static const String _updProfile = '/api/v1/account/profile/update';
  static const String _getprofileByEmail = '/api/v1/account/profile?email=';

//route
  static const String _getAllRoute = '/api/v1/route/all/active/no-pagin';
  static const String _getRouteByID = '/api/v1/route/';

//slot
  static const String _getAllSlot = '/api/v1/slot/all';
  static const String _getSlotbyId = '/api/v1/slot/';

//Station
  static const String _getStationByRouteID =
      '/api/v1/route-station/all?routeId=';

// get token
  static Future<TokenAuthenticate> fetchTokenAuthenticate(
      String idToken) async {
    TokenAuthenticate tokenAuthenticate = new TokenAuthenticate();
    var data = json.encode(idToken);
    try {
      final response = await http
          .post(Uri.parse('$_mainUrl' + '$_Authenticate'), body: data);
      if (response.statusCode == 200) {
        tokenAuthenticate =
            TokenAuthenticate.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return tokenAuthenticate;
  }

//get all route
  static Future<List<Routes>> fetchAllRoute() async {
    List<Routes> listRoute = [];
    Routes route = new Routes();
    try {
      final response = await http.get(Uri.parse('$_mainUrl' + '$_getAllRoute'),
          headers: _header);
      if (response.statusCode == 200) {
        var jsonData = (json.decode(response.body));
        for (var data in jsonData) {
          if (data['status'] == 'ACTIVE') {
            if (data is Map) {
              route = new Routes(
                  id: data['id'],
                  placeFrom: data['placeFrom'],
                  placeTo: data['placeTo'],
                  DefaultCost: data['defaultCost'],
                  Status: data['status']);
            }
            listRoute.add(route);
          }
        }
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return listRoute;
  }

//get route by id
  static Future<Routes> fetchRoutebyid(int id) async {
    Routes route = new Routes();
    int ID;
    (id == 0) ? ID = 1 : ID = id;
    try {
      final response = await http.get(
          Uri.parse('$_mainUrl' + '$_getRouteByID' + '$ID'),
          headers: _header);
      if (response.statusCode == 200) {
        if (response.body.isNotEmpty)
          route = Routes.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return route;
  }

//get station by route ID
  static Future<List<Station>> fetchStationByRoutedID(int id) async {
    List<Station> listStation = [];
    Station station = new Station();
    try {
      final response = await http.get(
          Uri.parse('$_mainUrl' + '$_getStationByRouteID' + '$id'),
          headers: _header);
      if (response.statusCode == 200) {
        var jsonData;
        if (response.body.isNotEmpty)
          jsonData = await (json.decode(response.body));
        if (jsonData != null) {
          for (var data in jsonData) {
            var sta = data['station'];
            if (sta is Map) {
              station = Station(
                id: sta['id'],
                name: (sta['name']),
                address: sta['address'],
                img: sta['img'],
                latitude: sta['latitude'],
                longtitude: sta['longtitude'],
              );
            }
            listStation.add(station);
          }
        } else {
          return listStation = [];
        }
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return listStation;
  }

  //get all slot
  static Future<List<Slot>> fetchAllSlot() async {
    List<Slot> listSlot = [];
    Slot slot = new Slot();
    try {
      final response = await http.get(Uri.parse('$_mainUrl' + '$_getAllSlot'),
          headers: _header);
      if (response.statusCode == 200) {
        var jsonData = (json.decode(response.body));
        for (var data in jsonData) {
          if (data['status'] == 'ACTIVE') {
            if (data is Map) {
              slot = new Slot(
                  id: data['id'],
                  name: data['name'],
                  timeStart: data['timeStart'],
                  timeEnd: data['timeEnd'],
                  status: data['status']);
            }
            listSlot.add(slot);
          }
        }
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return listSlot;
  }
//get slot by id

  static Future<Slot> fetchSlotbyid(int id) async {
    Slot slot = new Slot();
    try {
      final response = await http.get(
          Uri.parse('$_mainUrl' + '$_getSlotbyId' + '$id'),
          headers: _header);
      if (response.statusCode == 200) {
        slot = Slot.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return slot;
  }

// get information by email
  static Future<Customer> fetchCustomerByEmail(String email) async {
    Customer customer = new Customer();
    try {
      final response = await http.get(
          Uri.parse('$_mainUrl' + '$_getprofileByEmail' + '$email'),
          headers: _header);
      if (response.statusCode == 200) {
        customer = Customer.formJson(json.decode(response.body));
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return customer;
  }

//get information by ID
  static Future<Customer> fetchCustomerByID(int id) async {
    Customer cus = new Customer();
    try {
      final response = await http.get(
          Uri.parse('$_mainUrl' + '$_getCustomerByID' + '$id'),
          headers: _header);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var data = jsonData['accountDto'];

        if (data is Map) {
          cus = new Customer(
              Accountid: data['id'],
              Customerid: data['userId'],
              email: data['email'],
              phone: data['phone'],
              password: data['password'],
              name: data['name'],
              img: data['img'],
              gender: data['gender'],
              totalTrip: data['totalTrip'],
              dateCreated: data['createdDate'],
              status: data['status']);
        }
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }

    return cus;
  }

// update profile
  static Future<String> updProfile(Customer cus) async {
    String result = '';
    var data = json.encode(cus.toJson());
    try {
      final response = await http.put(Uri.parse('$_mainUrl' + '$_updProfile'),
          headers: _header, body: data);
      if (response.statusCode == 200) {
        result = response.body;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return result;
  }

  //get Customer's Trip by Customer ID
  static Future<List<CustomerTripFull>> fetchCustomertripByID(int ID) async {
    Station pickupstation = new Station();
    Station headtostation = new Station();
    CustomerTripFull cus = new CustomerTripFull(
        pickupStation: pickupstation, headtoStation: headtostation);
    List<CustomerTripFull> listTrip = [];
    try {
      final response = await http.get(
          Uri.parse('$_mainUrl' + '$_getAllBookingByCustomerID' + '$ID'),
          headers: _header);
      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body);
        var pickupStation;
        var headtostation;

        for (var i in jsonData) {
          //fetch pick up station
          pickupStation = i['pickupStation'];
          if (pickupStation is Map) {
            pickupStation = new Station(
              id: pickupStation['id'],
              name: pickupStation['name'],
              address: pickupStation['address'],
              img: pickupStation['img'],
              latitude: pickupStation['latitude'],
              longtitude: pickupStation['longtitude'],
            );
          }
          //fetch headto station
          headtostation = i['headtoStation'];
          if (headtostation is Map) {
            headtostation = new Station(
              id: headtostation['id'],
              name: headtostation['name'],
              address: headtostation['address'],
              img: headtostation['img'],
              latitude: headtostation['latitude'],
              longtitude: headtostation['longtitude'],
            );
          }
          //fetch customer's Trip
          cus = new CustomerTripFull(
              id: i['id'],
              customerId: i['customerId'],
              slotId: i['slotId'],
              routeId: i['routeId'],
              pickupStationId: i['pickupStationId'],
              pickupStation: pickupStation,
              headtoStationId: i['headtoStationId'],
              headtoStation: headtostation,
              pickupTime: i['pickupTime'],
              amount: i['amount'],
              createDate: i['createdDate'],
              status: i['status']);

          listTrip.add(cus);
        }
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }

    return listTrip;
  }

  //Inset Customer's Trip
  static Future<String> insCustomerTrip(CustomerTrip trip) async {
    String result = '';
    var data = json.encode(trip.toJSon());
    try {
      final response = await http.post(
          Uri.parse('$_mainUrl' + '$_createCustomerTrip'),
          headers: _header,
          body: data);
      if (response.statusCode == 200) {
        result = response.body;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return result;
  }

  //Cancel Customer's Trip
  static Future<String> cancelCusTrip(int tripID) async {
    String result = '';
    try {
      final response = await http.delete(
          Uri.parse('$_mainUrl' + '$_cancelCustomerTrip' + '$tripID'),
          headers: _header);
      if (response.statusCode == 200) {
        result = response.body;
      } else {
        throw Exception('Error ${response.statusCode}');
      }
    } on HttpException catch (message) {
      print(message.toString());
    }
    return result;
  }
}
