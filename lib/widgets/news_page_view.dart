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
  List<News> news = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _fetchNewsData();
  }

  Future<void> _fetchNewsData() async {
    try {
      final QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('news').get();

      if (snapshot.docs.isNotEmpty) {
        setState(() {
          news = snapshot.docs.map((doc) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            return News(
              title: data['title'],
              date: data['date'],
              text: data['text'],
              image: data['image'],
            );
          }).toList();
        });
      }
    } catch (error) {
      print('Error loading data: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SizedBox(
      height: 500,
      child: Column(
        children: [
          if (news.isEmpty)
            const CircularProgressIndicator()
          else
            Expanded(
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
            ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            child: Center(
              child: SmoothPageIndicator(
                controller: _pageController,
                effect: JumpingDotEffect(
                  activeDotColor: Colors.blue.shade900,
                  dotHeight: 5,
                  dotColor: Colors.grey.withOpacity(0.7),
                ),
                count: news.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
