import 'package:flutter/material.dart';
import 'package:rm_connect/screens/hub_screen.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({super.key});
  @override
  State<StartingScreen> createState() {
    return _StartingScreenState();
  }
}

class _StartingScreenState extends State<StartingScreen> {
  bool showHubScreen = false;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 3),
      () {
        setState(() {
          showHubScreen = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AnimatedSwitcher(
          duration: const Duration(seconds: 1),
          child: showHubScreen
              ? const HubScreen()
              : const Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Image(
                          color: Colors.black,
                          image: AssetImage('assets/images/modern_badge.png'),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Text(
                        'RMConnect',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
