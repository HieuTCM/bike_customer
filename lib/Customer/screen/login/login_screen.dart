/// createdby Daewu Bintara
/// Tuesday, 04/01/22 18:29
/// Enjoy coding ☕

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_one_tap_sign_in/google_one_tap_sign_in.dart';

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

  @override
  void initState() {
    super.initState();
    print("INIT STATE");
  }

  void _onSignIn() async {
    print("sign in");
    var data = await GoogleOneTapSignIn.startSignIn(webClientId: _webClientId);
    if (data != null) {
      /// Whatever you do with [SignInResult] data
      print("Id Token : ${data.idToken ?? "-"}");
      print("ID : ${data.id ?? "-"}");
    }
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
                onPressed: () => _onSignIn(),
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
