import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app1/widgets/textfield_wiget.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({Key? key}) : super(key: key);

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  bool _isBackPressedOrTouchedOutSide = false,
      _isDropDownOpened = false,
      _isPanDown = false;
  List<String> listCatagery = ['person', 'study', 'work', 'RND', 'other'];
  String selectCatageryItem = '';
  @override
  void initState() {
    // TODO: implement initState
    selectCatageryItem = 'select one';
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
                onPressed: () {},
                child: const Text('Cancel',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
              const Text(
                'Add Note',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              MaterialButton(
                onPressed: () {},
                child: const Text('Save',
                    style: TextStyle(
                      fontSize: 18,
                    )),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Title', border: OutlineInputBorder()),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              maxLines: 7,
              decoration: InputDecoration(
                  hintText: 'write a note...', border: OutlineInputBorder()),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
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
                  selectedItemTextStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  dropDownListTextStyle: TextStyle(fontSize: 18),
                  dropDownList: listCatagery,
                  isBackPressedOrTouchedOutSide: _isBackPressedOrTouchedOutSide,
                  selectedItem: selectCatageryItem,
                  onDropDownItemClick: (selectedItem) {
                    selectCatageryItem = selectedItem;
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
