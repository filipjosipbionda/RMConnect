import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rm_connect/models/player.dart';
import 'package:rm_connect/widgets/player_item.dart';

class PlayersView extends StatefulWidget {
  const PlayersView({super.key});

  @override
  State<PlayersView> createState() {
    return _PlayersViewState();
  }
}

class _PlayersViewState extends State<PlayersView>
    with AutomaticKeepAliveClientMixin {
  List<Player> players = [];
  final _pageController = PageController();
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    super.initState();
    _fetchNewsData();
  }

  Future<void> _fetchNewsData() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('players').get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          players = snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Player(
              imageUrl: data['imageUrl'],
              name: data['name'],
              number: data['number'],
              position: data['position'],
            );
          }).toList();
        });
      }
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return SizedBox(
      height: 500,
      width: 500,
      child: Column(
        children: [
          if (players.isEmpty) const CircularProgressIndicator(),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              itemBuilder: (ctx, index) => PlayerItem(
                player: players[index],
              ),
              itemCount: players.length,
            ),
          )
        ],
      ),
    );
  }
}
