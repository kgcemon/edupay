import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:readsms/readsms.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _plugin = Readsms();
  String sms = 'no sms received';
  Map myBody = {};
  String sender = 'no sms received';
  String time = 'no sms received';

  @override
  void initState() {



    getPermission().then((value) {
       ForegroundService().start();
      if (value) {
        _plugin.read();
        _plugin.smsStream.listen((event) {
          setState(() {
            sms = event.body;
            myBody.addAll({"body": sms });
            sender = event.sender;
            time = event.timeReceived.toString();
          });
        });
      }
    });
    super.initState();
  }

  Future<bool> getPermission() async {
    if (await Permission.sms.status == PermissionStatus.granted) {
      return true;
    } else {
      if (await Permission.sms.request() == PermissionStatus.granted) {
        return true;
      } else {
        return false;
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Column(
          children: [
            Text(sms),
            Text(myBody.toString()),
          ],
        )),
      ),
    );
  }
}
