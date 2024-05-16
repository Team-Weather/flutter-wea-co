import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/presentation/ootd_feed/view_model/ootd_feed_view_model.dart';
import 'flip_card.dart';

double scale = 35;
double cardWidth = 9 * scale;
double cardHeight = 16 * scale;
Duration cardMoveSpeed = const Duration(milliseconds: 250);

class OotdFeedScreen extends StatefulWidget {
  const OotdFeedScreen({super.key});

  @override
  State<OotdFeedScreen> createState() => _OotdFeedScreenState();
}

class _OotdFeedScreenState extends State<OotdFeedScreen> {
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(viewportFraction: 0.75);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('전체 build() 호출', name: 'OotdFeedScreen.build()');
    return Scaffold(
      body: PageView.builder(
        controller: _pageViewController,
        physics: const NeverScrollableScrollPhysics(),
        pageSnapping: true,
        itemCount: context.watch<OotdFeedViewModel>().feedList.length,
        itemBuilder: (BuildContext context, int index) {
          return Center(
            child: SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: FlipCard(
                  index: index, moveCallback: moveCard, flipCallback: flipCard),
            ),
          );
        },
      ),
    );
  }

  void moveCard({required bool isToNext}) {
    final nextIndex =
        context.read<OotdFeedViewModel>().moveIndex(isToNext: isToNext);
    _pageViewController.animateToPage(
      nextIndex,
      duration: cardMoveSpeed,
      curve: Curves.easeInOut,
    );
  }

  void flipCard() {
    context.read<OotdFeedViewModel>().flipCard();
  }
}