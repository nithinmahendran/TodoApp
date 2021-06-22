import 'package:flutter/material.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'package:todoapp/bloc/resources/repository.dart';
import 'models/global.dart';
import 'package:todoapp/UI/Intray/intray_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/models/classes/user.dart';
import 'bloc/blocs/user_bloc_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          dialogBackgroundColor: Colors.transparent,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String apiKey = "";
  TaskBloc tasksBloc;
  Repository _repository = Repository();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: signinUser(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          apiKey = snapshot.data;
          tasksBloc = TaskBloc(apiKey);
        } else {
          print("There is no data");
        }
        // String apiKey = snapshot.data;
        // apiKey.length > 0 ? getHomePage() :
        return apiKey.length > 0
            ? getHomePage()
            : LoginPage(
                login: login,
                newUser: false,
              );
      },
    );
  }

  void login() {
    setState() {
      build(context);
    }
  }

  Future signinUser() async {
    String userName = "";
    apiKey = await getApiKey();
    if (apiKey != null) {
      if (apiKey.length > 0) {
        userBloc.signinUser("", "", apiKey);
      } else {
        print("No Api Key");
      }
    } else {
      apiKey = "";
    }

    return apiKey;
  }

  Future getApiKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return await prefs.getString("API_Token");
  }

  Widget getHomePage() {
    return MaterialApp(
      color: Colors.yellow,
      home: SafeArea(
        child: DefaultTabController(
          length: 3,
          child: new Scaffold(
            body: Stack(children: [
              TabBarView(
                children: [
                  IntrayPage(
                    apiKey: apiKey,
                  ),
                  new Container(
                    color: Colors.orange,
                  ),
                  new Container(
                    child: Center(
                        child: FlatButton(
                      color: Colors.red,
                      child: Text("Log out"),
                      onPressed: () {
                        logout();
                      },
                    )),
                    color: Colors.lightGreen,
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.only(left: 50),
                height: 160,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(40),
                        bottomRight: Radius.circular(40)),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Intray",
                      style: todoTitle,
                    ),
                    Container(),
                  ],
                ),
              ),
              Container(
                height: 65,
                width: 65,
                margin: EdgeInsets.only(
                    top: 131, left: MediaQuery.of(context).size.width * 0.43),
                child: FloatingActionButton(
                  onPressed: () {
                    _showAddDialog();
                  },
                  child: Icon(Icons.add),
                  backgroundColor: addButtonColor,
                ),
              )
            ]),
            appBar: AppBar(
              elevation: 0,
              title: new TabBar(
                tabs: [
                  Tab(
                    icon: new Icon(Icons.home),
                  ),
                  Tab(
                    icon: new Icon(Icons.rss_feed),
                  ),
                  Tab(
                    icon: new Icon(Icons.perm_identity),
                  ),
                ],
                labelColor: darkGrey,
                unselectedLabelColor: Colors.blue,
                indicatorSize: TabBarIndicatorSize.label,
                indicatorPadding: EdgeInsets.all(5.0),
                indicatorColor: Colors.transparent,
              ),
              backgroundColor: Colors.white,
            ),
            backgroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("API_Token", "");
    setState(() {
      build(context);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void addTask(String taskName, String taskDeadline) async {
    await _repository.addUserTask(this.apiKey, taskName, taskDeadline);
  }

  void _showAddDialog() {
    TextEditingController taskName = new TextEditingController();
    TextEditingController taskDeadline = new TextEditingController();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              constraints: BoxConstraints.expand(height: 250),
              padding: EdgeInsets.all(20.0),
              height: 250,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: darkGrey,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Add New Task', style: whiteTodoTitle),
                  Container(
                    child: TextField(
                      controller: taskName,
                      decoration: InputDecoration(
                        hintText: "Name of Task",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  Container(
                    child: TextField(
                      controller: taskDeadline,
                      decoration: InputDecoration(
                        hintText: "Deadline",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RaisedButton(
                        color: addButtonColor,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Cancel",
                          style: whiteButtonTitle,
                        ),
                      ),
                      RaisedButton(
                        color: addButtonColor,
                        onPressed: () {
                          if (taskName.text != null) {
                            addTask(taskName.text, taskDeadline.text);
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Add",
                          style: whiteButtonTitle,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
