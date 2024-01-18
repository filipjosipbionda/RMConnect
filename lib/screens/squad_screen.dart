import 'package:flutter/material.dart';
import 'package:rm_connect/widgets/players_view.dart';

class SquadScreen extends StatefulWidget {
  const SquadScreen({super.key});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: ListView(
        children: const [
          Text('Players'),
          PlayersView(),
        ],
      ),
    );
  }
}
