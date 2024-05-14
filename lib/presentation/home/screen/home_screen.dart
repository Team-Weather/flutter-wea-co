import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/common/image_path.dart';
import 'package:weaco/domain/common/enum/weather_code.dart';
import 'package:weaco/presentation/home/component/recommand_ootd_list_widget.dart';
import 'package:weaco/presentation/home/component/weather_by_time_list_widget.dart';
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
        HomeScreenStatus.loading =>
          const Center(child: CircularProgressIndicator()),
        HomeScreenStatus.idle => const SizedBox(),
        HomeScreenStatus.success => Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                // TODO. 날씨에 맞는 배경 이미지 삽입
                image: AssetImage(ImagePath.homeBackgroundSunny),
              ),
            ),
            child: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  // 날씨 새로고침
                  await viewModel.initHomeScreen();
                },
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
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
                            WeatherCode.fromValue(currentWeather!.code)
                                .description,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                        ],
                      ),
                    ),

                    // weathers by time
                    WeatherByTimeListWidget(
                      dailyLocationWeather: dailyLocationWeather,
                    ),

                    const SliverToBoxAdapter(
                      child: SizedBox(height: 40),
                    ),

                    // ootd list
                    RecommandOotdListWidget(
                      dailyLocationWeather: dailyLocationWeather,
                      feedList: viewModel.feedList,
                    ),
                  ],
                ),
              ),
            ),
          ),
      },

      // 디자인 확인을 위한 임시 네비게이션
      // bottomNavigationBar: Stack(children: [
      //   Stack(
      //     children: [
      //       BottomNavigationWidget(
      //         onTap: (value) {},
      //         currentIndex: 0,
      //       ),
      //       if (!isPressingFloatingActionButton)
      //         SizedBox(
      //           width: 72,
      //           height: 72,
      //           child: FloatingActionButton(
      //             onPressed: () {
      //               setState(() {
      //                 isPressingFloatingActionButton = true;
      //               });
      //               Future.delayed(const Duration(milliseconds: 2000), () {
      //                 setState(() {
      //                   isPressingFloatingActionButton = false;
      //                 });
      //               });
      //             },
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(50),
      //               side: BorderSide(
      //                   color: Theme.of(context).primaryColor,
      //                   width: deviceWidth * 0.005),
      //             ),
      //             backgroundColor: Theme.of(context).canvasColor,
      //             child: const Icon(
      //               Icons.add,
      //               color: Color(0xffF2C347),
      //               size: 40,
      //             ),
      //           ),
      //         ),
      //       if (isPressingFloatingActionButton)
      //         SizedBox(
      //           width: 128,
      //           height: 72,
      //           child: FloatingActionButton(
      //             onPressed: () {},
      //             elevation: 0,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(50),
      //               side: BorderSide(
      //                   color: Theme.of(context).primaryColor,
      //                   width: MediaQuery.of(context).size.width * 0.005),
      //             ),
      //             backgroundColor: Theme.of(context).canvasColor,
      //             child: const Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //               children: [
      //                 Icon(
      //                   Icons.camera_alt_rounded,
      //                   color: Color(0xffF2C347),
      //                   size: 40,
      //                 ),
      //                 Icon(
      //                   Icons.photo_album_outlined,
      //                   color: Color(0xffF2C347),
      //                   size: 40,
      //                 ),
      //               ],
      //             ),
      //           ),
      //         ),
      //     ],
      //   ),
      // ])
    );
  }
}
