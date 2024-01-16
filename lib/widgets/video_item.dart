import 'package:flutter/material.dart';
import 'package:rm_connect/models/video.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoItem extends StatelessWidget {
  final Video video;

  const VideoItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () {
          launchUrl(Uri.parse(video.videoUrl));
        },
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  video
                      .imageUrl, // Zamijenite ovo sa stvarnim putem do vaše slike
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              const Center(
                child: Icon(
                  Icons.play_arrow,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
