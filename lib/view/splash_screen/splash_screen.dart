// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/core/constants/color_constants.dart';
import 'package:note_app/view/notes_screen/notes_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2)).then((value) =>
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => NotesScreen())));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBlack,
      body: Center(
        child: Text(
          "NotesApp",
          style: TextStyle(fontSize: 30, color: ColorConstants.primaryWhite),
        ),
      ),
    );
  }
}
