import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rm_connect/models/player.dart';
import 'package:rm_connect/widgets/player_item.dart';

class TrackingScreen extends StatefulWidget {
  const TrackingScreen({super.key});

  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  List<Player> trackedPlayers = [];
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _getTrackedPlayers();
  }

  Future<void> _getTrackedPlayers() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('tracked_players').get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          trackedPlayers = snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Player(
                imageUrl: data['imageUrl'],
                name: data['name'],
                number: data['number'],
                position: data['position'],
                isTracked: data['isFavorite'],
                documentId: data['documentId']);
          }).toList();
        });
        print(trackedPlayers.length);
      }
    } catch (error) {
      print(trackedPlayers.length);
      print('Error loading data: $error');
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

      FirebaseFirestore.instance.collection('tracked_players').snapshots();
      setState(() {
        trackedPlayers.remove(player);
        player.isTracked = false;
        print('Igrač uspješno obrisan s Firestore-a.');
      });
    } catch (error) {
      print('Greška pri brisanju igrača u Firestore: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 50),
            child: Text(
              'Tracked Players',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      offset: Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ]),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _pageController,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Stack(
                  children: [
                    PlayerItem(
                      player: trackedPlayers[index],
                    ),
                    Positioned(
                      top: 10,
                      right: 86,
                      child: IconButton(
                          iconSize: 30,
                          onPressed: () async {
                            await _removeFromFirestore(trackedPlayers[index]);
                          },
                          icon: const Icon(
                              color: Colors.blueAccent, Icons.track_changes)),
                    )
                  ],
                ),
              ),
              itemCount: trackedPlayers.length,
            ),
          ),
        ],
      ),
    );
  }
}
