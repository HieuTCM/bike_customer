/// createdby Daewu Bintara
/// Tuesday, 04/01/22 18:29
/// Enjoy coding ☕

import 'dart:io';
import 'dart:math';

import 'package:bike_customerv2/Customer/models/tokenAuthenticate.dart';
import 'package:bike_customerv2/Customer/provider/customer_provider.dart';
import 'package:bike_customerv2/Customer/screen/mainScreen.dart';
import 'package:bike_customerv2/Customer/screen/user/editProfile.dart';
import 'package:flutter/material.dart';
import 'package:google_one_tap_sign_in/google_one_tap_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const LoginPage());
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Your Web Client Id
  final String _webClientId =
      "665971199801-13uvkskt1dvub8vqopi2rdrq49b7ima9.apps.googleusercontent.com";

  File? _image;
  var isUpdated = false;

  @override
  void initState() {
    super.initState();
    print("INIT STATE");
  }

  void fetchTokenAuthenticated(String idToken) async {
    TokenAuthenticate tokenAuthenticate = new TokenAuthenticate();
    //tokenAuthenticate = await customerProvider.fetchTokenAuthenticate(idToken)
    //as TokenAuthenticate;
    final prefs = await SharedPreferences.getInstance();
    //await prefs.setString('Token', tokenAuthenticate.accessToken);
    await prefs.setString('Token',
        'eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhc3RlcmNvdWdhckBnbWFpbC5jb20iLCJpYXQiOjE2NjgyOTk3ODQsImV4cCI6MTY2ODI5OTc4NH0.9rp6ZDiJCwy9N8g4YUWFfRTFRGoLzQhdHbuWVbua1g0');

    //await prefs.setString('UserID', tokenAuthenticate.userId);
    await prefs.setInt('UserID', 18);

    setState(() {
      isUpdated = tokenAuthenticate.profileUpdated ?? false;
    });
  }

  void _onSignIn() async {
    print("sign in");
    var data = await GoogleOneTapSignIn.startSignIn(webClientId: _webClientId);
    if (data != null) {
      /// Whatever you do with [SignInResult] data
      print("Id Token : ${data.idToken ?? "-"}");
      print("ID : ${data.id ?? "-"}");
      String token = data.idToken;
      String idtoken = "";
      while (token.length > 0) {
        int initLength = (token.length >= 500 ? 500 : token.length);
        idtoken = idtoken + token.substring(0, initLength);
        int endLength = token.length;
        token = token.substring(initLength, endLength);
      }
    }

    fetchTokenAuthenticated('token');
  }

  void _onSignInWithHandle() async {
    var result =
        await GoogleOneTapSignIn.handleSignIn(webClientId: _webClientId);

    if (result.isTemporaryBlock) {
      // TODO: Tell your users about this status
      print("Temporary BLOCK");
    }

    if (result.isCanceled) {
      // TODO: Tell your users about this status
      print("Canceled");
    }

    if (result.isFail) {
      // TODO: Tell your users about this status
    }

    if (result.isOk) {
      // TODO: Whatever you do with [SignInResult] data
      print("OK");
      print("Id Token : ${result.data?.idToken ?? "-"}");
      print("Email : ${result.data?.username ?? "-"}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Google One Tap Sign In'),
        ),
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              TextButton(
                child: const Text("Sign In"),
                onPressed: () {
                  _onSignIn();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              isUpdated ? mainScreen() : editProfile()));
                },
              ),
              TextButton(
                child: const Text("Sign In With Handle"),
                onPressed: () => _onSignInWithHandle(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
