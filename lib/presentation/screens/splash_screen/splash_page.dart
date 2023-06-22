import 'package:flutter/material.dart';
import 'package:rythm1/presentation/screens/splash_screen/widgets/splash_widget.dart';
import '../../../infrastructure/database_functions/db_function.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    storagePermission();
    enterToExplore(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: logo(context));
  }
}
