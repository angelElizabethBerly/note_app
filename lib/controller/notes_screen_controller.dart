class NotesScreenController {
  static List notesList = [];
  static addNote() {
    notesList
        .add({"title": "", "description": "", "date": "", "colorIndex": ""});
  }
}
