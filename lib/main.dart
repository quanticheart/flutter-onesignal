import 'package:flutter/material.dart';
import 'package:one_signal_test/application.dart';
import 'package:one_signal_test/one_signal.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await OneSignalNotification.init("13fb7d07-ec07-4e80-80ce-1bae1e088e99");
  runApp(const MyApp());
}
