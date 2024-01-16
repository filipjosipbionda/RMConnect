import 'package:flutter/material.dart';
import 'package:rm_connect/models/result.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rm_connect/widgets/result_item.dart';

class ResultsView extends StatelessWidget {
  const ResultsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Adjust the height as needed
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('results').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }

          List<Result> results = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return Result(
              date: data['date'],
              imageUrlTeamA: data['imageUrlTeamA'],
              imageUrlTeamB: data['imageUrlTeamB'],
              result: data['result'],
            );
          }).toList();

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: results.length,
            itemBuilder: (context, index) {
              return ResultItem(result: results[index]);
            },
          );
        },
      ),
    );
  }
}
