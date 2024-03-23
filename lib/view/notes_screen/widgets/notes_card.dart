// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/core/constants/color_constants.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 15, left: 15, right: 20),
      decoration: BoxDecoration(
          color: ColorConstants.primaryYellow,
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text("Title"),
              Spacer(),
              Icon(Icons.edit),
              SizedBox(width: 10),
              Icon(Icons.delete)
            ],
          ),
          SizedBox(height: 10),
          Text("Description"),
          SizedBox(height: 30),
          Align(
            alignment: Alignment.bottomRight,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [Text("Date"), SizedBox(width: 15), Icon(Icons.share)],
            ),
          )
        ],
      ),
    );
  }
}
