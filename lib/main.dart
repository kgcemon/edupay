import 'package:edupay/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';

void main() {
   ForegroundService().start();
  runApp(const EduPay());
}
