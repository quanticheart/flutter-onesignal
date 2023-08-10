import 'package:flutter/material.dart';
import 'package:one_signal_test/application.dart';
import 'package:one_signal_test/one_signal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OneSignalNotification.init("");
  runApp(const MyApp());
}
