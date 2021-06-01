import 'package:flutter/material.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getApiKey(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        String apiKey = "";
        if (snapshot.hasData) {
          apiKey = snapshot.data;
        } else {
          print("There is no data");
        }
        // String apiKey = snapshot.data;
        // apiKey.length > 0 ? getHomePage() :
        return apiKey.length > 0
            ? getHomePage()
            : LoginPage(login: login, newUser: false,);
      },
    );
  }

  void login() {
    setState() {
      build(context);
    }
  }


  Future getApiKey() async {
    print("hello");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs);
    return await prefs.getString("API_Token");

    // String apiKey;
    // try {
    //   apiKey = prefs.getString('API_Token');
    // } catch (Exception) {
    //   apiKey = "";
    //   // await prefs.setString('API_Token', apiKey);
    // }
    // return apiKey;
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
                  IntrayPage(),
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
                  onPressed: () {},
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
}
