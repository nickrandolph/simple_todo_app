import 'package:appcenter_analytics/appcenter_analytics.dart';

/////////////  Imports for platform info /////////////
import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/foundation.dart' show TargetPlatform;
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
  /////////////  Identifier used for initialising App Center /////////////
  String _appCenterIdentifier = defaultTargetPlatform == TargetPlatform.iOS
      ? "<< iOS App Center ID>> "
      : "<< Android App Center ID >>";

  /////////////  Instance of FlutterAppAuth /////////////

  /////////////  Attributes required for authenticating with Azure B2C /////////////
  final _clientId = 'a03d8224-6245-4149-aa42-8e1da5e7a4b3';
  final _redirectUrl = 'com.builttoroam.simpletodo://oauthredirect';
  final _discoveryUrl =
      'https://simpletodo.b2clogin.com/simpletodo.onmicrosoft.com/v2.0/.well-known/openid-configuration?p=B2C_1_SignUpAndIn';
  final List<String> _scopes = [
    'openid',
  ];

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

  // /////////////  Initialise AppCenter /////////////
  // void initAppCenter() async {
  //   // Initialise AppCenter to allow for event tracking and crash reporting
  //   await AppCenter.start(
  //       _appCenterIdentifier, [AppCenterAnalytics.id, AppCenterCrashes.id]);
  // }

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

              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.work),
                hintText: "Enter task",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5)
                ),
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
            child: new ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (BuildContext ctxt, int index) {
                return Padding(
                  padding: EdgeInsets.all(2),
                  child: Card(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tasks[index].title),
                  )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
