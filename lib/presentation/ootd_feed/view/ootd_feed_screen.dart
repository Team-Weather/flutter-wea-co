import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/presentation/common/style/colors.dart';
import 'package:weaco/presentation/common/component/base_change_notifier.dart';
import 'package:weaco/presentation/common/component/base_state_widget.dart';
import 'package:weaco/presentation/common/state/base_alert_data.dart';
import 'package:weaco/presentation/ootd_feed/view_model/ootd_feed_view_model.dart';
import 'flip_card.dart';

double scale = 35;
double cardWidth = 9 * scale;
double cardHeight = 16 * scale;
Duration cardMoveSpeed = const Duration(milliseconds: 150);

class OotdFeedScreen<T extends BaseChangeNotifier> extends StatefulWidget {
  const OotdFeedScreen({super.key});

  @override
  State<OotdFeedScreen> createState() => _OotdFeedScreenState<T>();
}

class _OotdFeedScreenState<T extends BaseChangeNotifier>
    extends BaseState<OotdFeedScreen, T> {
  late PageController _pageViewController;

  @override
  void initState() {
    super.initState();
    _pageViewController = PageController(viewportFraction: 0.75);
    Future.microtask(() => context.read<OotdFeedViewModel>().initPage());
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<OotdFeedViewModel>().feedList.map(
        (e) => precacheImage(Image.network(e.feed.imagePath).image, context));
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: WeacoColors.backgroundColor,
        title: const Text(
          'OOTD 피드',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: WeacoColors.greyColor90),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageViewController,
              physics: const NeverScrollableScrollPhysics(),
              pageSnapping: true,
              itemCount: context.watch<OotdFeedViewModel>().feedList.length,
              itemBuilder: (BuildContext context, int index) {
                return SizedBox(
                  width: cardWidth,
                  height: cardHeight,
                  child: FlipCard(
                      index: index,
                      moveCallback: moveCard,
                      flipCallback: flipCard),
                );
              },
            ),
          ),
        ],
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

  @override
  BaseAlertData baseAlertData = BaseAlertData();
}
