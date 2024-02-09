import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rm_connect/models/player.dart';
import 'package:rm_connect/widgets/player_item.dart';

class PlayersView extends StatefulWidget {
  final List<Player> players;

  const PlayersView({super.key, required this.players});

  @override
  State<PlayersView> createState() {
    return _PlayersViewState();
  }
}

class _PlayersViewState extends State<PlayersView> {
  late List<bool> isPresentList;
  bool _isSnackBarVisible = false;

  Future<void> _addToFirestore(Player player) async {
    try {
      CollectionReference trackedPlayersCollection =
          FirebaseFirestore.instance.collection('tracked_players');

      CollectionReference playersCollection =
          FirebaseFirestore.instance.collection('players');

      DocumentReference playersDocumentReference =
          playersCollection.doc(player.documentId);
      await playersDocumentReference.update({'isTracked': true});

      DocumentReference documentReference =
          trackedPlayersCollection.doc(player.documentId);

      await documentReference.set({
        'name': player.name,
        'imageUrl': player.imageUrl,
        'number': player.number,
        'position': player.position,
        'documentId': player.documentId,
        'isTracked': true
      });

      setState(() {
        player.isTracked = true;
        print('Igrač uspješno dodan u Firestore.');
      });
    } catch (error) {
      print('Greška pri dodavanju igrača u Firestore: $error');
    }
  }

  Future<void> _removeFromFirestore(Player player) async {
    try {
      CollectionReference trackedPlayersCollection =
          FirebaseFirestore.instance.collection('tracked_players');

      CollectionReference playersCollection =
          FirebaseFirestore.instance.collection('players');
      DocumentReference playersDocumentReference =
          playersCollection.doc(player.documentId);

      await playersDocumentReference.update({'isTracked': false});

      DocumentReference trackedPlayersdocumentReference =
          trackedPlayersCollection.doc(player.documentId);

      await trackedPlayersdocumentReference.delete();
      setState(() {
        player.isTracked = false;
        print('Igrač uspješno obrisan s Firestore-a.');
      });
    } catch (error) {
      print('Greška pri brisanju igrača u Firestore: $error');
    }
  }

  void _showRemoveMessage(Player player) {
    if (_isSnackBarVisible) {
      return;
    }

    String playerName = player.name;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('$playerName has been removed from Tracker'),
      duration:
          const Duration(seconds: 2), // Možete prilagoditi trajanje snackbar-a
    ));
    setState(() {
      _isSnackBarVisible = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isSnackBarVisible = false;
      });
    });
  }

  void _showAddMessage(Player player) {
    if (_isSnackBarVisible) {
      return;
    }

    String playerName = player.name;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$playerName has been added to Tracker'),
        duration: const Duration(seconds: 1),
      ),
    );
    setState(() {
      _isSnackBarVisible = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isSnackBarVisible = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Player> players = widget.players;

    return SizedBox(
      height: 400,
      width: 500,
      child: Column(
        children: [
          if (players.isEmpty) const CircularProgressIndicator(),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, index) {
                // Provjeri duljinu isPresentList prije pristupa indeksu
                String playerKey = players[index].documentId!;
                return Stack(
                  children: [
                    PlayerItem(
                      key: Key(playerKey),
                      player: players[index],
                    ),
                    Positioned(
                      top: 26,
                      right: 26,
                      child: IconButton(
                        iconSize: 30,
                        onPressed: () async {
                          bool isTracked = players[index].isTracked!;
                          if (isTracked) {
                            _showRemoveMessage(players[index]);
                            await _removeFromFirestore(players[index]);
                          } else {
                            _showAddMessage(players[index]);
                            await _addToFirestore(players[index]);
                          }
                        },
                        icon: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('tracked_players')
                              .snapshots(),
                          builder: (context, snapshot) {
                            return Icon(
                              shadows: [
                                players[index].isTracked!
                                    ? const Shadow(
                                        color: Colors.black,
                                        offset: Offset(2,
                                            2), // Postavite offset prema želji
                                        blurRadius: 2)
                                    : const Shadow(
                                        color: Colors.green,
                                        offset: Offset(2,
                                            2), // Postavite offset prema želji
                                        blurRadius: 2)
                              ],
                              Icons.track_changes,
                              color: players[index].isTracked!
                                  ? const Color.fromARGB(255, 23, 185, 28)
                                  : Colors.black,
                            );
                          },
                        ),
                      ),
                    )
                  ],
                );
              },
              itemCount: players.length,
            ),
          ),
        ],
      ),
    );
  }
}
