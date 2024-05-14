import 'package:flutter/material.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/presentation/home/component/weather_by_time_widget.dart';

class WeatherByTimeListWidget extends StatefulWidget {
  const WeatherByTimeListWidget({
    super.key,
    required this.dailyLocationWeather,
    required this.scrollController,
  });

  final DailyLocationWeather? dailyLocationWeather;
  final ScrollController scrollController;

  @override
  State<WeatherByTimeListWidget> createState() =>
      _WeatherByTimeListWidgetState();
}

class _WeatherByTimeListWidgetState extends State<WeatherByTimeListWidget> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _moveScrollToCurrentTime();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
          alignment: Alignment.center,
          height: 100,
          decoration: BoxDecoration(
              color: const Color.fromARGB(136, 90, 152, 196),
              borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.builder(
              controller: widget.scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.dailyLocationWeather?.weatherList.length,
              itemBuilder: (context, index) {
                return WeatherByTimeWidget(
                  dailyLocationWeather: widget.dailyLocationWeather,
                  index: index,
                );
              })),
    );
  }

  _moveScrollToCurrentTime() {
    final hour = DateTime.now().hour;
    const totalItems = 24; // 전체 아이템 개수
    const visibleItems = 5; // 화면에 보이는 아이템 개수
    final middleIndex = (visibleItems / 2).floor(); // 중앙 인덱스

    // 현재 시간을 5개의 아이템 중 가운데에 위치시키기 위해 중앙 인덱스에서 현재 시간의 위치를 계산
    final scrollToIndex =
        (totalItems - visibleItems) ~/ 2 + (hour - middleIndex);

    // 계산된 인덱스가 스크롤 가능한 범위 내에 있는지 확인
    final scrollExtent = widget.scrollController.position.maxScrollExtent;
    final itemExtent =
        widget.scrollController.position.viewportDimension / visibleItems;
    final maxScrollIndex = (scrollExtent - itemExtent).floor();
    final clampedScrollToIndex = scrollToIndex.clamp(0, maxScrollIndex);

    // 계산된 인덱스로 스크롤 이동
    widget.scrollController.jumpTo(clampedScrollToIndex * itemExtent);
  }
}
