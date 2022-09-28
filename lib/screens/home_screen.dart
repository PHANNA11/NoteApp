import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app1/connection/note_database_con.dart';
import 'package:note_app1/screens/add_catagery_screen.dart';
import 'package:note_app1/screens/add_note_screen.dart';
import 'package:note_app1/screens/edit_note.dart';

import '../models/note_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late NotesDatabaseCon db;
  late Future<List<Notes>> listnote;
  @override
  void initState() {
    db = NotesDatabaseCon();
    // TODO: implement initState
    super.initState();
    db.initializeNoteData().whenComplete(() async {
      // await Future.delayed(Duration(seconds: 3));
      setState(() {
        listnote = db.readNoteData();
        print(listnote.then((value) => value.first.noteTitle.toString()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawerScrimColor: Colors.black,

      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color.fromARGB(255, 243, 241, 241),
        title: const Text(
          'Home page',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddCatagery(),
                    ));
              },
              child: const Center(
                child: Text('add Catagery',
                    style: TextStyle(color: Colors.black, fontSize: 18)),
              ))
        ],
      ),
      body: SizedBox(
        height: 500,
        width: double.infinity,
        child: FutureBuilder<List<Notes>>(
          future: listnote,
          builder: (context, AsyncSnapshot<List<Notes>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Icon(
                  Icons.info,
                  color: Colors.red,
                  size: 30,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var note = snapshot.data![index];
                  return InkWell(
                    onLongPress: () async {
                      await NotesDatabaseCon()
                          .deleteNoteData(note.noteId)
                          .whenComplete(() {
                        setState(() {
                          print('object was deleted');
                        });
                      });
                    },
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditNote(notes: note),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 0,
                        child: ListTile(
                          trailing: Text(note.noteCatagery.toString()),
                          title: Text(
                            note.noteTitle,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                note.noteBody,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(note.noteDate)
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      // body: Column(
      //   children: [
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Card(
      //         elevation: 0,
      //         child: ListTile(
      //           trailing: const Text('Person'),
      //           title: const Text(
      //             'Homework',
      //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      //           ),
      //           subtitle: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             // mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               const Text(
      //                 'W3Schools is optimized for learning and training. Examples might be simplified to improve reading and learning. Tutorials, reference',
      //                 maxLines: 1,
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               Text(DateTime.now().toString().substring(0, 19))
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Card(
      //         color: Colors.white,
      //         elevation: 0,
      //         child: ListTile(
      //           trailing: const Text('Person'),
      //           title: const Text(
      //             'Homework',
      //             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
      //           ),
      //           subtitle: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             // mainAxisAlignment: MainAxisAlignment.start,
      //             children: [
      //               const Text(
      //                 'W3Schools is optimized for learning and training. Examples might be simplified to improve reading and learning. Tutorials, reference',
      //                 maxLines: 1,
      //                 overflow: TextOverflow.ellipsis,
      //               ),
      //               const SizedBox(
      //                 height: 10,
      //               ),
      //               Text(DateTime.now().toString().substring(0, 19))
      //             ],
      //           ),
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const AddNoteScreen(),
              ),
              (route) => false);
        },
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
    );
  }
}
