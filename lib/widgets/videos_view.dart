import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rm_connect/models/video.dart';
import 'package:rm_connect/widgets/video_item.dart'; // Zamijenite s pravilnom putanjom prema vašem modelu

class VideosView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('videos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<Video> videos = snapshot.data!.docs
              .map((doc) => Video(
                    title: doc['title'],
                    duration: doc['duration'],
                    imageUrl: doc['imageUrl'],
                    videoUrl: doc['videoUrl'],
                  ))
              .toList();

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
