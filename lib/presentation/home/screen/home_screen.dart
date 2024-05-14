import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weaco/common/image_path.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/presentation/home/view_model/home_screen_view_model.dart';

/// [홈 화면]
/// 사용자 위치에 따른 날씨 정보와 추천 OOTD 목록을 표시합니다.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(
        () async => await context.read<HomeScreenViewModel>().initHomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeScreenViewModel>();
    final currentWeather = viewModel.status.isSuccess
        ? viewModel.dailyLocationWeather?.weatherList[0]
        : null;
    final dailyLocationWeather =
        viewModel.status.isSuccess ? viewModel.dailyLocationWeather! : null;

    return Scaffold(
      body: switch (viewModel.status) {
        HomeScreenStatus.error => const Center(child: Text('데이터를 불러올 수 없습니다.')),
        HomeScreenStatus.loading => const CircularProgressIndicator(),
        HomeScreenStatus.idle => const SizedBox(),
        HomeScreenStatus.success =>
          // TODO. PTR 구현하기
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                // TODO. 날씨에 맞는 배경 이미지 삽입
                image: AssetImage(ImagePath.homeBackgroundSunny),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  // city
                  Text(
                    dailyLocationWeather!.location.city,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  // weather code description
                  Text(
                    WeatherCode.fromValue(currentWeather!.code).description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // current temperature
                  Text(
                    '${currentWeather.temperature}°',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 60,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // max, min temperature
                      Column(
                        children: [
                          Text(
                            '최고 ${dailyLocationWeather.highTemperature}°',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    blurRadius: 4,
                                    color: Color.fromARGB(165, 0, 0, 0),
                                    offset: Offset(1, 1)),
                              ],
                            ),
                          ),
                          Text(
                            '최저 ${dailyLocationWeather.lowTemperature}°',
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                    blurRadius: 4,
                                    color: Color.fromARGB(165, 0, 0, 0),
                                    offset: Offset(1, 1)),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // 전일 대비
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            const Text('전일대비',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                )),
                            // TODO. 전일 대비 차이 구하는 함수 필요함
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  ImagePath.temperatureDownArrowIcon,
                                  width: 16,
                                  height: 16,
                                ),
                                const SizedBox(width: 4),
                                const Text(
                                  '13°',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  // weathers by time
                  Container(
                    alignment: Alignment.center,
                    height: 100,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(136, 90, 152, 196),
                        borderRadius: BorderRadius.circular(15)),
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dailyLocationWeather.weatherList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  DateFormat('aa HH시', 'ko_KR').format(
                                      dailyLocationWeather
                                          .weatherList[index].timeTemperature),
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Image.asset(
                                  WeatherCode.fromDtoCode(dailyLocationWeather
                                          .weatherList[index].code)
                                      .iconPath,
                                  width: 28,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  '${dailyLocationWeather.weatherList[index].temperature}°',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                  ),
                  const Spacer(),

                  // ootd list
                  Container(
                    height: 250,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 26, vertical: 20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(50))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '오늘은 이런 코디 어때요?',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  dailyLocationWeather.weatherList.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  margin: const EdgeInsets.only(right: 30),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: const [
                                        BoxShadow(
                                            color:
                                                Color.fromARGB(48, 95, 95, 95),
                                            blurRadius: 2,
                                            offset: Offset(5, 0))
                                      ]),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        viewModel.feedList[index].imagePath),
                                  ),
                                );
                              }),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
      },

      // 디자인 확인을 위한 임시 네비게이션
      bottomNavigationBar:
          BottomNavigationBar(selectedItemColor: Colors.blue, items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.access_alarm_rounded,
              color: Colors.amber,
            ),
            label: 'temp'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.access_alarm_rounded,
              color: Colors.amber,
            ),
            label: 'temp'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.access_alarm_rounded,
              color: Colors.amber,
            ),
            label: 'temp'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.access_alarm_rounded,
              color: Colors.amber,
            ),
            label: 'temp'),
      ]),
    );
  }
}
