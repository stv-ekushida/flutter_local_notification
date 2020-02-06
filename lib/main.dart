import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin localNotificationsPlugin;
  NotificationDetails platformChannelSpecifics;

  @override
  void initState() {
    _buildNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Notifiction Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Local通知'),
              onPressed: () {
                _onNotification();
              },
            )
          ],
        ),
      ),
    );
  }

  void _buildNotification() {
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();

    var initializationSettingsAndroid =
        AndroidInitializationSettings("app_icon");
    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocationLocation);

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    localNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);

    var chanelId = 'notification';
    var chanelName = 'チャンネル名';
    var chanelDescription = 'チャネル内容。';

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        chanelId, chanelName, chanelDescription,
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  }

  Future onSelectNotification(String payload) async {
    print("onSelectNotification");
  }

  Future onDidReceiveLocationLocation(
      int id, String title, String body, String payload) async {
    print("onDidReceiveLocationLocation");
  }

  Future _onNotification() async {
    await localNotificationsPlugin
        .show(1, "タイトル", "メッセージ", platformChannelSpecifics, payload: 'aaa');
  }
}
