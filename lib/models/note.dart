class NotesModel{

  final int id;
  final String title;
  final String description;
  final String date;
  final int priority;

   //NotesModel(this.id,this.title,this.description,this.date,this.priority);
   NotesModel({required this.id,required this.title,required this.description,required this.date,required this.priority});
   // Note.withId(this._id,this._title,this._date,this._priority,this._description);

  Map<String,Object?> toMap(){
    return {
      'id': id,
      'title':title,
      'description':description,
      'Date':date,
      'priority':priority
    };
  }

   NotesModel.fromMap(Map<String , dynamic> res):
     id=res['id'],
     title=res['title'],
     description= res['description'],
     date=res['Date'],
     priority=res['priority'];

}