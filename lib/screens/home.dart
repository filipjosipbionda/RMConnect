import 'package:flutter/material.dart';

import 'package:rm_connect/widgets/news_page_view.dart';
import 'package:rm_connect/widgets/results_view.dart';
import 'package:rm_connect/widgets/videos_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList(
          delegate: SliverChildListDelegate([
            const NewsPageView(),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10),
              child: const Text(
                'Latest Results',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 13,
            ),
          ]),
        ),
        SliverToBoxAdapter(
          child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: const ResultsView())),
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Container(
              margin: const EdgeInsets.only(top: 10, left: 10),
              child: const Text(
                'Latest Videos',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
          ]),
        ),
        const SliverToBoxAdapter(
          child: VideosView(),
        )
      ],
    );
  }
}
