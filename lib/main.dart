import 'package:appcenter_analytics/appcenter_analytics.dart';
import 'package:flutter/material.dart';
/////////////  Import for Swagger /////////////
import 'package:swagger/api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'World\'s Best Flutter App',
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.dark,
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

  /////////////  Base url for the Simple ToDo service /////////////
  static const _baseUrl = 'https://simpletodoservice.azurewebsites.net';

  //// Controller for TextField and List of tasks ////
  final TextEditingController eCtrl = new TextEditingController();
  /////////////  Change List to use Task /////////////
  List<Task> tasks = [];

/////////////  Override Initialise State /////////////
  @override
  void initState() {
    super.initState();

    //initAppCenter();
    loadData();
  }
  void loadData() async {
    ////  Calling App Service ////

    // Setup api client with base url and token returned by auth process
    //var client = ApiClient(basePath: _baseUrl);
// Setup api client with base url and token returned by auth process
    var client = ApiClient(basePath: _baseUrl);


    var tasksApi = new TasksApi(client);

    var downloadedTasks = await tasksApi.callGet();
    setState(() {
      tasks = downloadedTasks;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      /////////////  Body of the app is made up of a single column /////////////
      body: new Column(
        children: [
          SizedBox(height: 20,),
          /////////////  TextField to capture input /////////////
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: new TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.business),
                hintText: "Enter task here",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
              ),
              controller: eCtrl,
              onSubmitted: (text) {
                /////////////  Tracking event /////////////
                AppCenterAnalytics.trackEvent("Adding item", {"List Item": text});

                tasks.add(
                  new Task()..title = text,
                );

                eCtrl.clear();
                setState(() {});
              },
            ),
          ),
                    SizedBox(height: 20,),

          /////////////  Expand ListView to remaining space /////////////
          new Expanded(
            child: ReorderableListView(
              children: List.generate(tasks.length, (index)  {
                return Padding(
                  key: ValueKey("value$index"),
                  padding: EdgeInsets.all(2),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(tasks[index].title),
                    )),
                  ),
                );
              },
            ),
              onReorder: (old, newIndex){
                setState(() {
                  _updateMyItems(old, newIndex);
                });
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
