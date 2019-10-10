import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World\'s Best Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'World\'s Best Flutter App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //// Controller for TextField and List of tasks ////
  final TextEditingController eCtrl = new TextEditingController();
  List<String> tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      /////////////  Body of the app is made up of a single column /////////////
      body: new Column(
        children: [
          /////////////  TextField to capture input /////////////
          new TextField(
            controller: eCtrl,
            onSubmitted: (text) {
              tasks.add(text);
              eCtrl.clear();
              setState(() {});
            },
          ),
/////////////  Expand ListView to remaining space /////////////
          new Expanded(
            child: new ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding: EdgeInsets.all(2),
                  child: Text(tasks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
