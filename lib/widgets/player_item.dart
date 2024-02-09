import 'package:flutter/material.dart';
import 'package:rm_connect/models/player.dart';

class PlayerItem extends StatelessWidget {
  final Player player;

  const PlayerItem({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
    String playerName = player.name;
    int playerNumber = player.number;
    return Center(
      child: Container(
        margin: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Colors.blue.withOpacity(0.05),
              const Color.fromARGB(255, 10, 7, 236).withOpacity(0.3)
            ],
          ),
        ),
        height: 350,
        width: 250,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 10,
              left: 20,
              child: Text(
                playerNumber.toString(),
                style: TextStyle(
                    shadows: const [
                      Shadow(
                        color: Colors.white,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade900),
              ),
            ),
            Positioned.fill(
              child: Image.network(player.imageUrl),
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(
                    begin: Alignment.center,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      const Color.fromARGB(255, 11, 25, 235).withOpacity(0.7)
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  playerName,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
