import 'package:flutter/material.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:house_price_predictor/formWrapper.dart';

class WindowManager {
  static Future<void> initialize() async {
    try {
      // Wait for a moment to ensure the window exists
      await Future.delayed(Duration(milliseconds: 150));
      await DesktopWindow.setBorders(false);
      await DesktopWindow.setFullScreen(true);
    } catch (e) {
      debugPrint('Window configuration error: $e');
    }
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());

  // Ensure the app is rendered first
  Future.delayed(Duration(milliseconds: 100), () async {
    await WindowManager.initialize();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FormWrapper(),
    );
  }
}
