import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rm_connect/models/news.dart';
import 'package:rm_connect/widgets/news_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsPageView extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('news').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return Text('Error loading data');
              }

              List<News> news = snapshot.data!.docs.map((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return News(
                  title: data['title'],
                  date: data['date'],
                  text: data['text'],
                  image: data['image'],
                );
              }).toList();

              return Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemBuilder: (ctx, index) => NewsItem(
                    news: news[index],
                  ),
                  itemCount: news.length,
                ),
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('news').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox
                    .shrink(); // Prikazati prazan widget tijekom dohvaćanja
              }

              if (snapshot.hasError) {
                return Text('Error loading data');
              }

              List<News> news = snapshot.data!.docs.map((doc) {
                Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
                return News(
                  title: data['title'],
                  date: data['date'],
                  text: data['text'],
                  image: data['image'],
                );
              }).toList();

              return SmoothPageIndicator(
                controller: _pageController,
                effect: JumpingDotEffect(
                  activeDotColor: Colors.blue.shade900,
                  dotHeight: 5,
                  dotColor: Colors.grey.withOpacity(0.7),
                ),
                count: news.length,
              );
            },
          ),
        ],
      ),
    );
  }
}
