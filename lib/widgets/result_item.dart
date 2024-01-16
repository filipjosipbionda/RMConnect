import 'package:flutter/material.dart';
import 'package:rm_connect/models/result.dart';

class ResultItem extends StatelessWidget {
  final Result result;
  const ResultItem({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 20, left: 10),
      height: 100,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Boja senke
            spreadRadius: 2, // Proširenje senke
            blurRadius: 5, // Zamagljivanje senke
            offset:
                Offset(0, 3), // Pomeranje senke u odnosu na kontejner (X, Y)
          ),
        ],
        color: Colors.blue,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/bernabeu_result.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black.withOpacity(0.5)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Grb kluba 1
                    Image.network(
                      result.imageUrlTeamA,
                      width: 30,
                      height: 30,
                      // Postavite putanju do slike prvog grba
                    ),
                    const SizedBox(width: 8),
                    // Rezultat
                    Text(
                      result.result, // Postavite stvarni rezultat
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Grb kluba 2
                    Image.network(
                      result.imageUrlTeamB,
                      width: 30,
                      height: 30,
                      // Postavite putanju do slike drugog grba
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                // Datum
                Text(
                  result.date, // Postavite stvarni datum
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
