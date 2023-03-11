import 'package:flutter/material.dart';
import 'package:sqf_light_app/db_handler.dart';
import 'package:sqf_light_app/models/note.dart';
import 'package:sqf_light_app/note_add.dart';
import 'package:sqf_light_app/note_update.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DBHelper dbHelper = DBHelper();
  Future<List<NotesModel>>? noteList;
  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    getData();
  }

  getData() {
    noteList = dbHelper.getCartListWithUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Center(child: Text('SQFlite with Flutter')),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: noteList,
                builder: (BuildContext context,
                    AsyncSnapshot<List<NotesModel>> snapshot) {
                  if (snapshot.data != null) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          child: GestureDetector(
                            onLongPress: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => UpdateNote(
                                            title: 'Update Your Note',
                                            id: snapshot.data![index].id!,
                                            noteTitle:
                                                snapshot.data![index].title,
                                            noteDesc: snapshot
                                                .data![index].description,
                                            email: snapshot.data![index].email,
                                          )));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  snapshot.data![index].title.characters.first,
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                backgroundColor: Colors.yellow,
                              ),
                              title: Text(
                                snapshot.data![index].title.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(snapshot.data![index].description
                                      .toString()),
                                  Text(snapshot.data![index].date),
                                ],
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    dbHelper.delete(snapshot.data![index].id!);
                                    snapshot.data!.remove(snapshot.data![index]);
                                    setState(() {
                                      noteList = dbHelper.getCartListWithUserId();
                                      ;
                                    });
                                  },
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                      size: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return Container(
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: FloatingActionButton(
                backgroundColor: Colors.blue,
                tooltip: 'Add Note',
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AddNoteDetail(title: 'Add your Note')));
                  // dbHelper.insert(NotesModel(
                  //     id: 22, title: 'waseem', description: 'weekend is ahead', email: 'hello@gmail.com', date: '2',
                  // ));
                },
              ),
            ),
          ],
        ));
  }
}
