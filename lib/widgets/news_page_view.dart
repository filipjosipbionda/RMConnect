import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rm_connect/models/news.dart';
import 'package:rm_connect/widgets/news_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class NewsPageView extends StatefulWidget {
  const NewsPageView({super.key});
  @override
  State<NewsPageView> createState() => _NewsPageViewState();
}

class _NewsPageViewState extends State<NewsPageView>
    with AutomaticKeepAliveClientMixin {
  final _pageController = PageController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('news').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              if (snapshot.hasError) {
                return const Text('Error loading data');
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
                  itemBuilder: (ctx, index) => AspectRatio(
                    aspectRatio: 16 / 9,
                    child: NewsItem(
                      news: news[index],
                    ),
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
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Text('Error loading data');
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
