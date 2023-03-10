import 'package:flutter/material.dart';
import 'package:sqf_light_app/db_handler.dart';
import 'package:sqf_light_app/models/note.dart';
import 'package:sqf_light_app/note_detail.dart';
import 'package:sqflite/sqflite.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
   DBHelper dbHelper = DBHelper();
   Future <List<NotesModel>>? noteList;


  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    getData();
  }

  getData() {
   noteList = dbHelper.getNoteLists();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('SQFlite')),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: noteList,
                builder: (BuildContext context, AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (true){
                    return  ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                              snapshot.data![index].priority.toString() == 1
                                  ? Colors.red
                                  : Colors.yellow,
                              child: Icon( snapshot.data![index].priority.toString() == 1
                                  ? Icons.add
                                  : Icons.move_to_inbox_sharp),
                            ),
                            title: Text( snapshot.data![index].title.toString()),
                            subtitle: Text( snapshot.data![index].description.toString()),
                            trailing: const Icon(
                              Icons.delete,
                              color: Colors.blueGrey,
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NoteDetail(
                                        title: 'Edit Note',
                                      )));
                            },
                          ),
                        );
                      },
                    );
                  }else {
                    print('data is null');
                   return Container(
                     alignment: AlignmentDirectional.center,
                     child: CircularProgressIndicator(),
                   );
                  }
                },

              ),
            ),
            FloatingActionButton(
              backgroundColor: Colors.blue,
              tooltip: 'Add Note',
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              onPressed: () {
                dbHelper.insert(NotesModel(
                  id: 21,
                  title: 'task',
                  description: 'this is my first task',
                  date: '22',
                  priority: 1,
                ))
                    .then((value) {
                  print('data added');
                  setState(() {
                    // noteList = dbHelper!.getNoteLists();
                  });
                }).onError((error, stackTrace) {
                  print(error.toString());
                });
                // Navigator.push(context, MaterialPageRoute(builder: (context)=>NoteDetail(
                // title: 'Add Note',
                // )));
              },
            ),
          ],
        ));
  }

  //  getNotesList() {
  //     return
  // }

}
