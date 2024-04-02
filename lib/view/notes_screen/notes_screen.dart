// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  void initState() {
    NotesScreenController.getInitKeys();
    super.initState();
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int selectedColorIndex = 0;
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
          itemCount: NotesScreenController.notesListKeys.length,
          itemBuilder: (context, index) {
            final currentKey = NotesScreenController.notesListKeys[index];
            final currentElement = NotesScreenController.myBox.get(currentKey);
            return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                child: NotesCard(
                  title: currentElement["title"],
                  description: currentElement["description"],
                  date: currentElement["date"],
                  selectedColorIndex: currentElement["colorIndex"],
                  onDeletePressed: () async {
                    await NotesScreenController.deleteNote(currentKey);
                    setState(() {});
                  },
                  onEditPressed: () {
                    titleController.text = currentElement["title"];
                    descriptionController.text = currentElement["description"];
                    dateController.text = currentElement["date"];
                    selectedColorIndex = currentElement["colorIndex"];
                    customBottomSheet(
                        context: context, isEdit: true, currentKey: currentKey);
                  },
                ));
          }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            titleController.clear();
            descriptionController.clear();
            dateController.clear();
            selectedColorIndex = 0;

            customBottomSheet(context: context);
          },
          child: Icon(Icons.add)),
    );
  }

  Future<dynamic> customBottomSheet(
      {required BuildContext context, bool isEdit = false, var currentKey}) {
    return showModalBottomSheet(
        backgroundColor: ColorConstants.primaryBlack,
        context: context,
        builder: (context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: StatefulBuilder(builder: (context, bottomSetState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isEdit == true ? "Update Note" : "Add Note",
                      style: TextStyle(
                          color: ColorConstants.primaryWhite, fontSize: 18),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                          hintText: "Title",
                          filled: true,
                          fillColor: ColorConstants.primaryGrey),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 30, horizontal: 10),
                          hintText: "Description",
                          filled: true,
                          fillColor: ColorConstants.primaryGrey),
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      readOnly: true,
                      controller: dateController,
                      decoration: InputDecoration(
                          hintText: "Date",
                          filled: true,
                          fillColor: ColorConstants.primaryGrey,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                final selectedDate = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2034));
                                if (selectedDate != null) {
                                  String formattedDate = DateFormat('MMMMEEEEd')
                                      .format(selectedDate);
                                  dateController.text =
                                      formattedDate.toString();
                                }
                                bottomSetState() {}
                              },
                              icon: Icon(Icons.calendar_month))),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          4,
                          (index) => InkWell(
                                onTap: () {
                                  selectedColorIndex = index;
                                  print(selectedColorIndex);
                                  bottomSetState(() {});
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: selectedColorIndex == index
                                              ? 5
                                              : 0,
                                          color: ColorConstants.primaryGrey),
                                      borderRadius: BorderRadius.circular(5),
                                      color: NotesScreenController
                                          .colorList[index]),
                                ),
                              )),
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
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style:
                                  TextStyle(color: ColorConstants.primaryBlack),
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
                            onPressed: () async {
                              if (isEdit == true) {
                                await NotesScreenController.editNote(
                                    key: currentKey!,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    date: dateController.text,
                                    colorIndex: selectedColorIndex);
                              } else {
                                if ((titleController.text != "") &&
                                    (descriptionController.text != "") &&
                                    (dateController.text != "")) {
                                  await NotesScreenController.addNote(
                                      title: titleController.text,
                                      description: descriptionController.text,
                                      date: dateController.text,
                                      colorIndex: selectedColorIndex);
                                  setState(() {});
                                }
                              }
                              Navigator.pop(context);
                              setState(() {});
                            },
                            child: Text(
                              isEdit == true ? "Edit" : "Save",
                              style:
                                  TextStyle(color: ColorConstants.primaryBlack),
                            ))
                      ],
                    )
                  ],
                );
              }),
            ));
  }
}
