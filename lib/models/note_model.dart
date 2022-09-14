class Notes {
  late int noteId;
  late String noteTitle;
  late String noteCatagery;
  late String noteBody;
  late String noteDate;
  Notes(
      {required this.noteId,
      required this.noteTitle,
      required this.noteCatagery,
      required this.noteDate,
      required this.noteBody});
  Map<String, dynamic> fromJson() {
    return {
      'noteId': noteId,
      'noteTitle': noteTitle,
      'noteCatagery': noteCatagery,
      'noteBody': noteBody,
      'noteDate': noteDate
    };
  }

  Notes.toJson(Map<String, dynamic> json)
      : noteId = json['noteId'],
        noteTitle = json['noteTitle'],
        noteCatagery = json['noteCatagery'],
        noteBody = json['noteBody'],
        noteDate = json['noteDate'];
}
