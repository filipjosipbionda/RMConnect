import 'package:flutter/material.dart';
import 'package:rm_connect/screens/hub_screen.dart';
import 'package:rm_connect/screens/starting_screen.dart';

class RMConnect extends StatefulWidget {
  const RMConnect({super.key});

  @override
  State<RMConnect> createState() {
    return _RMConnectState();
  }
}

class _RMConnectState extends State<RMConnect> {
  Widget? activeScreen;

  @override
  void initState() {
    super.initState();
    activeScreen = StartingScreen();
  }

  void switchScreen() {
    setState(() {
      activeScreen = const HubScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: activeScreen,
    );
  }
}
