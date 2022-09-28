import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:note_app1/connection/catagery_database_con.dart';

import 'package:note_app1/connection/note_database_con.dart';
import 'package:note_app1/screens/home_screen.dart';

import '../models/note_model.dart';

class EditNote extends StatefulWidget {
  EditNote({required this.notes, Key? key}) : super(key: key);
  Notes notes;
  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  TextEditingController titleController = TextEditingController();
  TextEditingController noteBodyController = TextEditingController();
  bool _isBackPressedOrTouchedOutSide = false,
      _isDropDownOpened = false,
      _isPanDown = false;
  List<String> listCatagery = [];
  String selectCatageryItem = '';
  getCatageryListFromDatabase() async {
    await CatageryDatabaseCon().readCatageryData().then((value) {
      setState(() {
        value.forEach((element) {
          listCatagery.add(element.CatageryName);
        });
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCatageryListFromDatabase();
    selectCatageryItem = widget.notes.noteCatagery;
    titleController.text = widget.notes.noteTitle;
    noteBodyController.text = widget.notes.noteBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MaterialButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                      (route) => false);
                },
                child: const Text('Cancel',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              const Text(
                'Edit Note',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              MaterialButton(
                onPressed: () async {
                  await NotesDatabaseCon()
                      .editNoteData(Notes(
                          noteId: widget.notes.noteId,
                          noteTitle: titleController.text,
                          noteCatagery: selectCatageryItem,
                          noteDate: DateTime.now().toIso8601String(),
                          noteBody: noteBodyController.text))
                      .whenComplete(() => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomeScreen()),
                          (route) => false));
                },
                child: const Text('Save',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              decoration: const InputDecoration(
                  hintText: 'Title', border: OutlineInputBorder()),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: noteBodyController,
              maxLines: 7,
              decoration: const InputDecoration(
                  hintText: 'write a note...', border: OutlineInputBorder()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Catagery',
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              Container(
                height: 50,
                width: 200,
                child: AwesomeDropDown(
                  isPanDown: _isPanDown,
                  elevation: 0,
                  selectedItemTextStyle: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                  dropDownListTextStyle: const TextStyle(fontSize: 18),
                  dropDownList: listCatagery,
                  isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                  selectedItem: selectCatageryItem,
                  onDropDownItemClick: (selectedItem) {
                    selectCatageryItem = selectedItem;
                    print(selectCatageryItem);
                  },
                  dropStateChanged: (isOpened) {
                    _isDropDownOpened = isOpened;
                    if (!isOpened) {
                      _isBackPressedOrTouchedOutSide = false;
                    }
                  },
                ),
              ),
            ],
          )
        ],
      )),
    );
  }
}
