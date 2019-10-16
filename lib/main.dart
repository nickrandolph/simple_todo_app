import 'package:flutter/material.dart';
import 'package:swagger/api.dart';

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

  final TextEditingController eCtrl = new TextEditingController();
  /////////////  Change List to use Task /////////////
  List<Task> tasks = [];

/////////////  Override Initialise State /////////////
  @override
  void initState() {
    super.initState();
  }

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

              tasks.add(
                new Task()..title = text,
              );

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
                  key: ValueKey("value$index"),
                  padding: EdgeInsets.all(2),
                  child: Text(tasks[index].title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _updateMyItems(int oldIndex, int newIndex) {
    if(newIndex > oldIndex){
      newIndex -= 1;
    }

    final Task item = tasks.removeAt(oldIndex);
    tasks.insert(newIndex, item);

  }
}
