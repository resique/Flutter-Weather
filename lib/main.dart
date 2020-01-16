// Copyright 2018 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:music_app/models/city.dart';
//import 'package:flutter/rendering.dart';
import 'package:music_app/src/screens/home_screen.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

Future<String> _loadCities() async {
  return await rootBundle.loadString('assets/city.list.json');
}

void main() async {
//  String citiesJson = await _loadCities();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        home: Scaffold(
          body: HomeScreen()
      )
    );
  }
}