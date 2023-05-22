import 'package:flutter/material.dart';
import 'package:rythm1/rentering_items/screens/splash_screen/widgets/splash_widget.dart';
import '../../../database/database_functions/db_function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    enterToExplore(context);
    storagePermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: logo(context));
  }
}
