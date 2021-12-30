import 'package:flutter/material.dart';
import 'LocalNotifyManager.dart';

class TestNotifyScreen extends StatefulWidget {
  const TestNotifyScreen({Key? key}) : super(key: key);

  @override
  _TestNotifyScreenState createState() => _TestNotifyScreenState();
}

class _TestNotifyScreenState extends State<TestNotifyScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localNotifyManager.setOnNotificationReceive(onNotificationReceive);
    localNotifyManager.setOnNotificationClick(onNotificationClick);
  }

  onNotificationReceive(ReceiveNotification notification){
    print('notification received :: ${notification.id}');
  }

  onNotificationClick(paayload){
    print('payload $paayload');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notification'),
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(bottomRight: Radius.elliptical(200, 500),bottomLeft: Radius.elliptical(200, 500))
        ),
      ),
      body: Center(
        child: FlatButton(
          onPressed: () async{
            await localNotifyManager.showNotification();

          },
          child: Text('Send Notification'),
          ),
        ),
      );

  }
}
