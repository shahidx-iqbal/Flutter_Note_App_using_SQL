class NotesModel {
  final int? id;
  final String title;
  final String description;
  final String email;
  final String date;

  NotesModel(
      { this.id,
      required this.title,
      required this.description,
      required this.email,
      required this.date});

  NotesModel.fromMap(Map<String, dynamic> res)
      : id = res['id'],
        title = res['title'],
        description = res['description'],
        email = res['email'],
        date = res['date'];

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'email': email,
      'date': date
    };
  }
}
