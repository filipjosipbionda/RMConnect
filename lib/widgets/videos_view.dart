import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rm_connect/models/video.dart';
import 'package:rm_connect/widgets/video_item.dart';

class VideosView extends StatelessWidget {
  const VideosView({super.key});

  double parseDuration(String durationString) {
    List<String> parts = durationString.split(':');
    int minutes = int.parse(parts[0]);
    int seconds = int.parse(parts[1]);
    return minutes + seconds / 60.0;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('videos').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Text('Error loading data');
          }

          // Koristite `snapshot.data` za pristup najnovijim podacima
          List<Video> videos = snapshot.data!.docs
              .map((doc) => Video(
                  title: doc['title'],
                  duration: doc['duration'],
                  imageUrl: doc['imageUrl'],
                  videoUrl: doc['videoUrl'],
                  platformIcon: doc['platformIcon']))
              .toList();

          videos.sort((a, b) =>
              parseDuration(a.duration).compareTo(parseDuration(b.duration)));

          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: videos.length,
            itemBuilder: (context, index) {
              return VideoItem(
                video: videos[index],
              );
            },
          );
        },
      ),
    );
  }
}
