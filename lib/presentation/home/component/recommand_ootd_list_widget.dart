import 'package:flutter/material.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/weather/model/daily_location_weather.dart';
import 'package:weaco/presentation/home/component/recommand_ootd_widget.dart';

class RecommandOotdListWidget extends StatelessWidget {
  const RecommandOotdListWidget({
    super.key,
    required this.dailyLocationWeather,
    required this.feedList,
  });

  final DailyLocationWeather? dailyLocationWeather;
  final List<Feed> feedList;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        height: 250,
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(50))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '오늘은 이런 코디 어때요?',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            feedList.isEmpty
                ? const Center(
                    child: Text(
                      '아직 등록된 코디가 없어요 :( \n 가장 먼저 OOTD를 올려보세요! :D',
                      textAlign: TextAlign.center,
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: feedList.length,
                      itemBuilder: (context, index) {
                        return RecommandOotdWidget(
                          feedList: feedList,
                          index: index,
                        );
                      },
                    ),
                  ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
