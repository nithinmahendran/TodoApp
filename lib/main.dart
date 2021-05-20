import 'package:flutter/material.dart';
import 'package:todoapp/UI/Login/loginscreen.dart';
import 'models/global.dart';
import 'package:todoapp/UI/Intray/intray_page.dart';

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
      home: FutureBuilder(
        
        builder: (BuildContext context,AsyncSnapshot<String> snapshot){
          switch(snapshot.connectionState){
            case ConnectionState.none:
              return Text('Press Button to start.');
            case ConnectionState.active:
            case ConnectionState.waiting:
              return Text('Awaiting Result');
            case ConnectionState.done:
              if(snapshot.hasError) 
              return Text('Error:${snapshot.error}');

          }
          return null;
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
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
}
