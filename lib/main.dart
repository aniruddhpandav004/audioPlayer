import 'package:flutter/material.dart';
import 'package:jsondata/screens/audioPlayer.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/' : (context) => JsonData(),
      },
    ),
  );
}
