import 'package:weaco/domain/feed/model/feed.dart';

class OotdCard {
  bool isFront = true;
  final Feed _feed;

  OotdCard({required Feed data}) : _feed = data;


  Feed get feed => _feed;
}
