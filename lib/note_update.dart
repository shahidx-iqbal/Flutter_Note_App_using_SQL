import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqf_light_app/home_screen.dart';
import 'db_handler.dart';
import 'models/note.dart';


class UpdateNote extends StatefulWidget {

  final int id;
  final String title;
  final String noteTitle , noteDesc , email;
  const UpdateNote({required this.id,required this.title, required this.noteTitle,required this.noteDesc, required this.email, Key? key}) : super(key: key);

  @override
  State<UpdateNote> createState() => _UpdateNoteState();
}

class _UpdateNoteState extends State<UpdateNote> {
  DBHelper dbHelper = DBHelper();
  var now = DateTime.now();
  var formatter = DateFormat('yyyy-MM-dd');
  TextEditingController titleTextEditingController =TextEditingController();
  TextEditingController descriptionTextEditingController =TextEditingController();
  TextEditingController emailTextEditingController =TextEditingController();



  @override
  void initState() {
    dbHelper = DBHelper();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: titleTextEditingController,
                  decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: widget.noteTitle,
                      focusColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: descriptionTextEditingController,
                  decoration: InputDecoration(
                      labelText: 'Description',
                      hintText: widget.noteDesc,
                      focusColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  keyboardType: TextInputType.emailAddress,
                  controller: emailTextEditingController,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: widget.email,
                      focusColor: Colors.white70,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5)
                      )
                  ),
                ),
              ),
              const SizedBox(height: 10.0,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed:(){
                          dbHelper.updateQuantity(NotesModel(
                              id: widget.id,
                              title: titleTextEditingController.text,
                            description: descriptionTextEditingController.text,
                            email: emailTextEditingController.text,
                            date: formatter.format(now).toString()
                          )
                          );
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                          elevation: MaterialStateProperty.all(5),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
                          backgroundColor: MaterialStateProperty.all(Colors.blue),
                        ),
                        child: const Text('Save')
                    ),
                  ),
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}






