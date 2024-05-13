import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/presentation/ootd_feed/view_model/ootd_feed_view_model.dart';
import 'flip_card.dart';

double scale = 30;
double cardWidth = 9 * scale;
double cardHeight = 16 * scale;
Duration cardMoveSpeed = const Duration(milliseconds: 200);

class OotdFeedScreen extends StatefulWidget {
  const OotdFeedScreen({super.key});

  @override
  State<OotdFeedScreen> createState() => _OotdFeedScreenState();
}

class _OotdFeedScreenState extends State<OotdFeedScreen> {
  late PageController _pageViewController;
  int _currentIdx = 0;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageViewController,
        // padEnds: true,
        pageSnapping: true,
        children: List.generate(
           context.watch<OotdFeedViewModel>().feedList.length,
            (index) => Center(
                  child: SizedBox(
                    width: cardWidth,
                    height: cardHeight,
                    child: FlipCard(data: context.watch<OotdFeedViewModel>().feedList[index], moveCallback: moveCard, flipCallback: flipCard),
                  ),
                )),
      ),
    );
  }

  void moveCard({required bool isToNext}) {
    int currentLength = context.read<OotdFeedViewModel>().feedList.length;
    isToNext ? _currentIdx++ : _currentIdx--;
    if (_currentIdx < 0) _currentIdx = 0;
    if (_currentIdx + 2 == currentLength) {
      context.read<OotdFeedViewModel>().loadMorePage();
    }
    if (_currentIdx >= currentLength) _currentIdx = currentLength - 1;

    _pageViewController.animateToPage(
      _currentIdx,
      duration: cardMoveSpeed,
      curve: Curves.easeInOut,
    );
  }

  void flipCard() {
    // context.read<OotdFeedViewModel>().flipCard(index: _currentIdx);
  }
}
