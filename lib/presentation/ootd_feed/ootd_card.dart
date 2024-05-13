import 'package:weaco/domain/feed/model/feed.dart';

class OotdCard {
  bool _isFront = true;
  final Feed _feed;

  OotdCard({required Feed data}) : _feed = data;


  Feed get feed => _feed;

  bool get isFront => _isFront;

  set isFront(bool value)  => _isFront = value;
}
