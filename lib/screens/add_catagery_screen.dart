import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:note_app1/connection/catagery_database_con.dart';
import 'package:note_app1/models/catagery_model.dart';

class AddCatagery extends StatefulWidget {
  const AddCatagery({Key? key}) : super(key: key);

  @override
  State<AddCatagery> createState() => _AddCatageryState();
}

class _AddCatageryState extends State<AddCatagery> {
  late CatageryDatabaseCon db;
  int catageryIdUpdate = -1;
  late Future<List<CatageryModel>> listCatagerys;
  TextEditingController catageryController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catageryIdUpdate = -1;
    db = CatageryDatabaseCon();
    db.initializeCatageryData().whenComplete(() async {
      setState(() {
        listCatagerys = db.readCatageryData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Catagery'),
        actions: [
          catageryIdUpdate > 0
              ? TextButton(
                  onPressed: () async {
                    await CatageryDatabaseCon()
                        .updateCatagery(CatageryModel(
                            CatageryId: catageryIdUpdate,
                            CatageryName: catageryController.text))
                        .whenComplete(() async {
                      db.initializeCatageryData().whenComplete(() async {
                        setState(() {
                          catageryIdUpdate = -1;
                          catageryController.text = '';
                          listCatagerys = db.readCatageryData();
                        });
                      });
                    });
                  },
                  child: const Text(
                    'update',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
              : TextButton(
                  onPressed: () async {
                    await CatageryDatabaseCon()
                        .inserCatageryData(CatageryModel(
                            CatageryId: Random().nextInt(100),
                            CatageryName: catageryController.text))
                        .whenComplete(() async {
                      db.initializeCatageryData().whenComplete(() async {
                        setState(() {
                          listCatagerys = db.readCatageryData();
                        });
                      });
                    });
                  },
                  child: const Text(
                    'save',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ))
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            // flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: catageryController,
                decoration: const InputDecoration(
                    hintText: 'Catagery', border: OutlineInputBorder()),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: SizedBox(
              height: 500,
              width: double.infinity,
              child: FutureBuilder<List<CatageryModel>>(
                future: listCatagerys,
                builder:
                    (context, AsyncSnapshot<List<CatageryModel>> snapshot) {
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
                        var catagerys = snapshot.data![index];
                        return InkWell(
                          onLongPress: () async {
                            await CatageryDatabaseCon()
                                .deleteCatagery(catagerys.CatageryId)
                                .whenComplete(() async {
                              db
                                  .initializeCatageryData()
                                  .whenComplete(() async {
                                setState(() {
                                  listCatagerys = db.readCatageryData();
                                });
                              });
                            });
                          },
                          onTap: () {
                            setState(() {
                              catageryController.text = catagerys.CatageryName;
                              catageryIdUpdate = catagerys.CatageryId;
                            });
                          },
                          child: Card(
                            // elevation: 0,
                            child: ListTile(
                              title: Text(catagerys.CatageryName),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
