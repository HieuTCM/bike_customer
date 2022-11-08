import 'package:bike_customerv2/Customer/models/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class customerProvider {
  static const String token =
      'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJodXluZzEwOThAZ21haWwuY29tIiwiaWF0IjoxNjY3ODc3MDY1LCJleHAiOjE2Njc4NzcwNjV9.TOMsrEfdgRNgW90i1PQNlsKUdNf2NILs7fhwP7iV5Yo ';

  static const String _mainUrl = 'https://another-bikeke2.herokuapp.com';
  static const String _getAllBikebyDriverId = '/api/v1/bike/all?driverId=';
  static const String _getBikebyId = '/api/v1/bike/'; /* /api/v1/bike/{id}*/
  static const String _getVehicleType = '/api/v1/vehicle-type/all';
  static const String _getBikeBrand = '/api/v1/bike-brand/all';
  static const String _getDriverById =
      '/api/v1/driver/{id}'; /*/api/v1/driver/{id} */
  static const String _getCustomerByID =
      '/api/v1/customer/{id}'; /*/api/v1/customer/{id} */
  static const String _updProfile = '/api/v1/account/update';
  static const String _getprofileByEmail = '/api/v1/account/profile?email=';
  static const String _createBooking = '/api/v1/customer-trip/find';
  static const String _getAllBookingByCustomerID =
      '/api/v1/customer-trip/findByCustomer?customerId=';

  static const String _getAllRoute = '/api/v1/route/all';
  static const String _getAllStation = '/api/v1/route/create';

  static final Map<String, String> _header = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
    "Authorization": 'Bearer $token'
  };

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

  static Future<String> updProfile(Customer cus) async {
    String result = '';
    var data = json.encode(cus.toJson());
    try {
      final response = await http.put(Uri.parse('$_mainUrl' + '$_updProfile'),
          headers: _header, body: data);
      print(data);
      if (response.statusCode == 200) {
        print(response.body);
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
