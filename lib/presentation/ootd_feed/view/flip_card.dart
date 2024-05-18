import 'dart:developer';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/presentation/ootd_feed/ootd_card.dart';
import 'package:weaco/presentation/ootd_feed/view_model/ootd_feed_view_model.dart';
import 'ootd_feed_screen.dart';

BoxShadow shadow = const BoxShadow(
  color: Colors.black26,
  blurRadius: 10.0, // soften the shadow
  spreadRadius: 0.5, //extend the shadow
);

class FlipCard extends StatefulWidget {
  final int _index;
  final void Function({required bool isToNext}) _moveCallback;
  final void Function() _flipCallback;

  const FlipCard(
      {super.key,
      required int index,
      required void Function({required bool isToNext}) moveCallback,
      required void Function() flipCallback})
      : _index = index,
        _moveCallback = moveCallback,
        _flipCallback = flipCallback;

  @override
  State<FlipCard> createState() => _FlipCardState();
}

class _FlipCardState extends State<FlipCard>
    with SingleTickerProviderStateMixin {
  late final OotdCard _data;
  final double _swipeThreshold = 100.0;
  double _swipeStartPoint = 0.0;
  bool _isSwapping = false;
  final int _flipSpeed = 230;
  final double _flipThreshold = 40.0;
  double _dragStartPoint = 0.0;
  bool _isDragging = false;
  bool _isFlipping = false;
  bool _isKeepGoingDown = true;
  bool _isToBack = true;
  late AnimationController _controller;
  late Animation<double> _upAnimation;
  late Animation<double> _downAnimation;

  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: _flipSpeed));
    _upAnimation = TweenSequence([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: -math.pi / 2), weight: 0.5),
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 0.5),
    ]).animate(_controller);
    _downAnimation = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(math.pi / 2), weight: 0.5),
      TweenSequenceItem(
          tween: Tween(begin: math.pi / 2, end: 0.0), weight: 0.5),
    ]).animate(_controller);
    _data = context.read<OotdFeedViewModel>().feedList[widget._index];
    _isToBack = _data.isFront;
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flip({required bool isUp}) {
    widget._flipCallback();
    _isFlipping = true;
    if (_isKeepGoingDown && !isUp) _isToBack = !_isToBack;
    if (!_isKeepGoingDown && isUp) _isToBack = !_isToBack;
    _isKeepGoingDown = !isUp;
    (isUp ? _controller.forward(from: 0) : _controller.reverse(from: 1)).then(
      (value) {
        _isFlipping = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log('전체 build(${widget._index}) 호출', name: 'FlipCard.build()');
    var scale = context.read<OotdFeedViewModel>().currentIndex == widget._index
        ? 1.0
        : 0.85;
    return TweenAnimationBuilder(
      curve: Curves.ease,
      tween: Tween(begin: scale, end: scale),
      duration: const Duration(milliseconds: 0),
      builder: (_, __, Widget? child) {
        return Transform.scale(
          scale: scale,
          child: child,
        );
      },
      child: GestureDetector(
        onTap: () {
          RouterStatic.pushToOotdDetail(context, feed: _data.feed);
        },
        onHorizontalDragStart: (details) {
          _swipeStartPoint = details.localPosition.dx;
          _isSwapping = true;
        },
        onHorizontalDragUpdate: (details) {
          if (!_isSwapping) return;
          if (_swipeStartPoint - details.localPosition.dx >= _swipeThreshold) {
            _isSwapping = false;
            widget._moveCallback(isToNext: true);
          } else if (_swipeStartPoint - details.localPosition.dx <=
              -_swipeThreshold) {
            _isSwapping = false;
            widget._moveCallback(isToNext: false);
          }
        },
        onVerticalDragStart: (details) {
          _dragStartPoint = details.localPosition.dy;
          _isDragging = true;
        },
        onVerticalDragUpdate: (details) {
          if (!_isDragging || _isFlipping) return;
          if (_dragStartPoint - details.localPosition.dy >= _flipThreshold) {
            _isDragging = false;
            _flip(isUp: true);
            widget._flipCallback();
          } else if (_dragStartPoint - details.localPosition.dy <=
              -_flipThreshold) {
            _isDragging = false;
            _flip(isUp: false);
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: AnimatedBuilder(
                animation: _downAnimation,
                builder: (_, __) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0005)
                      ..rotateX(_downAnimation.value),
                    child: Visibility(
                      visible: _controller.value >= 0.5,
                      child: _isToBack ? _buildBackSide() : _buildFrontSide(),
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: cardWidth,
              height: cardHeight,
              child: AnimatedBuilder(
                animation: _upAnimation,
                builder: (_, __) {
                  return Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.0005)
                      ..rotateX(_upAnimation.value),
                    child: Visibility(
                      visible: _controller.value < 0.5,
                      child: _isToBack ? _buildFrontSide() : _buildBackSide(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFrontSide() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.grey[300]!,
            Colors.grey[200]!,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.black26,
            blurRadius: 10.0, // 얼마나 흩어져
            spreadRadius: 0.01, // 얼마나 두껍게
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Image.network(
          _data.feed.imagePath,
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }

  Widget _buildBackSide() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.black12,
            blurRadius: 10.0, // 얼마나 흩어져
            spreadRadius: 0.01, // 얼마나 두껍게
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const DefaultTextStyle(
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
              child: Text('그 날의 날씨는'),
            ),
            SizedBox(
              width: 100,
              height: 100,
              child: Image.asset(
                  WeatherCode.fromValue(_data.feed.weather.code).iconPath),
            ),
            Container(
              height: 130,
              width: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xFFFAFAFA),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: const Color(0xFF282828),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5.0, // 얼마나 흩어져
                            spreadRadius: 0.01, // 얼마나 두껍게
                          )
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        child: DefaultTextStyle(
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          child: Text(
                              WeatherCode.fromValue(_data.feed.weather.code)
                                  .description),
                        ),
                      ),
                    ),
                    const DefaultTextStyle(
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      child: Text('이 날의 온도는'),
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Colors.black),
                      child: Text('${_data.feed.weather.temperature}°C'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
