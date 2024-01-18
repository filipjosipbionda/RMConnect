import 'package:flutter/material.dart';
import 'package:rm_connect/models/player.dart';

class PlayerItem extends StatelessWidget {
  final Player player;

  const PlayerItem({super.key, required this.player});

  @override
  Widget build(BuildContext context) {
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
      height: 400,
      width: 300,
      child: Stack(children: [
        Positioned(
          bottom: 0,
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
      ]),
    ));
  }
}
