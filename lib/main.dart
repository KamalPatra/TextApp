import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() async {

  runApp(MaterialApp(
    title: "Text",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var _message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notes"),
        centerTitle: true,
        backgroundColor: Colors.deepPurpleAccent,
      ),

      body: ListView(
        children: <Widget>[
          ListTile(
            title: TextField(
              controller: _message,
              decoration: InputDecoration(
                labelText: "Write your notes",
              ),
            ),
          ),
          ListTile(
            title: FlatButton(
                onPressed: (){
                  writeFile(_message.text);
                },
              child: Column(
                children: <Widget>[
                  Text("Save Notes"),
                  Padding(padding: EdgeInsets.all(14.9)),
                  FutureBuilder(
                    future: readFile(),
                    builder: (BuildContext context, AsyncSnapshot<String> notes){
                      if (notes.hasData != null){
                        return Text(notes.data.toString());
                      }else {
                        return Text("Nothing saved yet!");
                      }
                    })
                ],
              ),
                ),
          )
        ],
      ) ,
    );
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File("$path/data.txt");
}

Future<File> writeFile(String message) async {
  final file = await _localFile;
  return file.writeAsString("$message");
}

Future<String> readFile() async {
  try {
    final file = await _localFile;
    String contents = await file.readAsString();
    return contents;
  } catch (e) {
    return "I am not well!";
  }
}
