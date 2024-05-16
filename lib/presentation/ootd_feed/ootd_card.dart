import 'package:weaco/domain/feed/model/feed.dart';

class OotdCard {
  bool isFront;
  final Feed feed;

  OotdCard({required this.feed, this.isFront = true});
}
