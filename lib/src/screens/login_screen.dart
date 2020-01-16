import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatelessWidget {

  // Build

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Login',
        home: Scaffold(
            appBar: AppBar(
                title: Text('Login')
            ),
            body: Center(
              child: CupertinoButton(
                child: Text('Login', textDirection: TextDirection.ltr),
              ),
            )
        )
    );
  }

  // Methods

  Future _loginPressed() async {
    const url = 'https://connect.deezer.com/oauth/auth.php?app_id=381944&redirect_uri=deezerviewer://deezer.viewer.com&perms=basic_access,email';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}