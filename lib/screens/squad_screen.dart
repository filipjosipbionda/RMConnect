import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rm_connect/models/player.dart';
import 'package:rm_connect/widgets/players_view.dart';

class SquadScreen extends StatefulWidget {
  const SquadScreen({super.key});

  @override
  State<SquadScreen> createState() => _SquadScreenState();
}

class _SquadScreenState extends State<SquadScreen>
    with AutomaticKeepAliveClientMixin {
  late Stream<List<Player>> _playersStream;
  List<Player> players = [];
  List<Player> goalkeepers = [];
  List<Player> defenders = [];
  List<Player> midfielders = [];
  List<Player> attackers = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _playersStream = FirebaseFirestore.instance
        .collection('players')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data();
        return Player(
          imageUrl: data['imageUrl'],
          name: data['name'],
          number: data['number'],
          position: data['position'],
          isTracked: data['isTracked'],
          documentId: data['name'].toLowerCase().replaceAll(' ', '_'),
        );
      }).toList()
        ..sort((player1, player2) => player1.number.compareTo(player2.number));
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<List<Player>>(
      stream: _playersStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Text('No data available');
        }
        players = snapshot.data!;
        goalkeepers =
            players.where((player) => player.position == 'goalkeeper').toList();
        defenders =
            players.where((player) => player.position == 'defender').toList();
        midfielders =
            players.where((player) => player.position == 'midfielder').toList();
        attackers =
            players.where((player) => player.position == 'attacker').toList();

        return Container(
          margin: const EdgeInsets.only(top: 20),
          child: ListView(
            children: [
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    'Goalkeepers',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              PlayersView(
                players: goalkeepers,
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    'Defenders',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: PlayersView(
                  players: defenders,
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const Text(
                    'Midfielders',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: PlayersView(
                  players: midfielders,
                ),
              ),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(left: 20, bottom: 10),
                  child: const Text(
                    'Attackers',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: PlayersView(
                  players: attackers,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
