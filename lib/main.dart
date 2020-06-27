import 'package:dartmanmusicplayer/sidebutton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final dartmanBlue = Colors.blue[300];
  final dartmanGray = Colors.blueGrey[200];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: dartmanBlue,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 80.0,
                  ),
                  Container(
                    decoration: BoxDecoration(color: Colors.blueGrey[700]),
                    height: 5.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('FLUTTER',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.blueGrey[100],
                          fontFamily: 'RobotoSlab',
                        )),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    width: 150.0,
                    height: 350.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                      color: Colors.black,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text('DARTMAN',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.blueGrey[100],
                            fontFamily: 'MuseoModerno')),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: dartmanGray,
            ),
            width: 100.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 85.0),
                SideButton(icon: Icons.play_arrow),
                SizedBox(height: 16.0),
                SideButton(icon: Icons.stop),
                SizedBox(height: 16.0),
                SideButton(icon: Icons.fast_forward),
                SizedBox(height: 16.0),
                SideButton(icon: Icons.fast_rewind),
                SizedBox(height: 16.0),
                SideButton(text: "EJECT"),
              ],
            ),
          ),
        ],
      )),
    );
  }
}
