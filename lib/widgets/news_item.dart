import 'package:flutter/material.dart';
import 'package:rm_connect/widgets/news_item_detail.dart';
import 'package:rm_connect/models/news.dart';

class NewsItem extends StatelessWidget {
  final News news;

  const NewsItem({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Originalna slika
          Hero(
            tag: 'news_image',
            child:
                ClipRRect(child: Image.network(fit: BoxFit.cover, news.image)),
          ),

          // Zatamnjeni sloj
          Positioned.fill(
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => NewsDetail(news: news),
                  ),
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black, Colors.transparent])),
              ),
            ),
          ),
          // Dodatni sadržaj, ako je potrebno
          Positioned.fill(
            bottom: 20,
            left: 20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  news.date,
                  style: const TextStyle(color: Colors.white, shadows: [
                    Shadow(
                      color: Colors.black,
                      offset: Offset(2.0, 2.0),
                      blurRadius: 4.0,
                    ),
                  ]),
                ),
                Text(
                  news.title,
                  softWrap: true,
                  style: const TextStyle(
                    shadows: [
                      Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                      ),
                    ],
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
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
