import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarBrightness: Brightness.light));
  runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _toDoController = TextEditingController();
  List _toDoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  @override
  void initState() {
    super.initState();
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  void _addToDo() {
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      _toDoController.text = "";
      newToDo["ok"] = false;
      _toDoList.add(newToDo);
      _saveData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.green,
            title: Text(
              "Lista de Tarefas",
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true),
        body: Column(children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17.0, 2.0, 7.0, 2.0),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: TextField(
                      controller: _toDoController,
                      decoration: InputDecoration(
                        labelText: "Nova Lista",
                        labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    )),
                ElevatedButton(
                    onPressed: _addToDo,
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text("ADD", style: TextStyle(color: Colors.white)))
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10.0),
              itemCount: _toDoList.length,
              itemBuilder: buildItem,
            ),
          )
        ]));
  }

  Widget buildItem(context, index) {
    return Dismissible(
      key: Key(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
          color: Colors.red,
          child: Align(
              alignment: Alignment(-0.8, 0),
              child: Icon(Icons.delete, color: Colors.white))),
      child: CheckboxListTile(
        title: Text(
          _toDoList[index]["title"],
        ),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
            child: Icon(
                _toDoList[index]["ok"] ? Icons.check : Icons.access_alarm)),
        onChanged: (c) {
          setState(() {
            _toDoList[index]["ok"] = c;
            _saveData();
          });
        },
      ),
      onDismissed: (direction) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);
          _saveData();
          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" removida"),
            action: SnackBarAction(
              label: "Desfazer",
              onPressed: () {
                setState(() {
                  _toDoList.insert(_lastRemovedPos, _lastRemoved);
                  _saveData();
                });
              },
            ),
            duration: Duration(seconds: 4),
          );
          ScaffoldMessenger.of(context).showSnackBar(snack);
        });
      },
    );
  }

  Future<File> _getFile() async {
    final directory = await getApplicationDocumentsDirectory();
    return File("${directory.path}/data.json");
  }

  Future<File> _saveData() async {
    String data = json.encode(_toDoList);
    final file = await _getFile();
    return file.writeAsString(data);
  }

  Future<String> _readData() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
