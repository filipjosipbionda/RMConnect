import 'package:flutter/material.dart';
import 'package:rm_connect/screens/home.dart';
import 'package:rm_connect/screens/squad_screen.dart';
import 'package:rm_connect/screens/tracking_screen.dart';

class HubScreen extends StatefulWidget {
  const HubScreen({super.key});

  @override
  State<HubScreen> createState() => _HubScreenState();
}

class _HubScreenState extends State<HubScreen> {
  var _selectedIndex = 0;
  late PageController _pageController;
  late HomeScreen homeScreen;
  late SquadScreen squadScreen;
  late TrackingScreen trackingScreen;

  @override
  void initState() {
    super.initState();
    homeScreen = const HomeScreen();
    squadScreen = const SquadScreen();
    trackingScreen = const TrackingScreen();
    _pageController = PageController(initialPage: _selectedIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(milliseconds: 200),
                curve: Curves.linear);
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Squad',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.track_changes), label: 'Tracker')
        ],
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: [homeScreen, squadScreen, trackingScreen],
      ),
    );
  }
}
