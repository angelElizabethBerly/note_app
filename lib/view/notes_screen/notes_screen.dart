// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:note_app/controller/notes_screen_controller.dart';
import 'package:note_app/core/constants/color_constants.dart';
import 'package:note_app/view/notes_screen/widgets/notes_card.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryBlack,
      appBar: AppBar(
        backgroundColor: ColorConstants.primaryBlack,
        title: Text("PENPAD"),
        centerTitle: true,
        titleTextStyle: TextStyle(fontSize: 25),
      ),
      body: ListView.builder(
          itemCount: NotesScreenController.notesList.length,
          itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
              child: NotesCard())),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                backgroundColor: ColorConstants.primaryBlack,
                context: context,
                builder: (context) => Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 25, horizontal: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Title",
                                filled: true,
                                fillColor: ColorConstants.primaryGrey),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 30, horizontal: 10),
                                hintText: "Description",
                                filled: true,
                                fillColor: ColorConstants.primaryGrey),
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            decoration: InputDecoration(
                                hintText: "Date",
                                filled: true,
                                fillColor: ColorConstants.primaryGrey),
                          ),
                          SizedBox(height: 15),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorConstants.primaryBlue),
                                height: 50,
                                width: 60,
                              ),
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorConstants.primaryGreen),
                                height: 50,
                                width: 60,
                              ),
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorConstants.primaryYellow),
                                height: 50,
                                width: 60,
                              ),
                              SizedBox(width: 10),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: ColorConstants.primaryRed),
                                height: 50,
                                width: 60,
                              ),
                            ],
                          ),
                          SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      backgroundColor: MaterialStatePropertyAll(
                                          ColorConstants.primaryGrey)),
                                  onPressed: () {},
                                  child: Text(
                                    "Cancel",
                                    style: TextStyle(
                                        color: ColorConstants.primaryBlack),
                                  )),
                              SizedBox(width: 25),
                              TextButton(
                                  style: ButtonStyle(
                                      padding: MaterialStatePropertyAll(
                                          EdgeInsets.symmetric(
                                              vertical: 10, horizontal: 20)),
                                      shape: MaterialStatePropertyAll(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5))),
                                      backgroundColor: MaterialStatePropertyAll(
                                          ColorConstants.primaryGrey)),
                                  onPressed: () {
                                    NotesScreenController.addNote();
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: Text(
                                    "Save",
                                    style: TextStyle(
                                        color: ColorConstants.primaryBlack),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ));
          },
          child: Icon(Icons.add)),
    );
  }
}
