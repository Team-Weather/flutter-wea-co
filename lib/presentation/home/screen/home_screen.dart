import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/util/reaction_util.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';
import 'package:weaco/presentation/common/style/image_path.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/presentation/common/util/alert_util.dart';
import 'package:weaco/presentation/home/component/recommend_ootd_list_widget.dart';
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
      () async {
        context.read<HomeScreenViewModel>().initHomeScreen();
        final tmp = context.read<HomeScreenViewModel>().precacheList;
        for (Feed e in tmp) {
          if (mounted) {
            await precacheImage(
                CachedNetworkImageProvider(e.thumbnailImagePath), context);
          }
        }
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final viewModel = context.read<HomeScreenViewModel>();
        if (viewModel.status.isError) {
          AlertUtil.showAlert(
            context: context,
            exceptionAlert: ExceptionAlert.snackBar,
            message: viewModel.errorMesasge,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeScreenViewModel>();

    final String temperatureGapPresentation = viewModel.temperatureGap! >= 0
        ? viewModel.temperatureGap!.toStringAsFixed(1)
        : (-viewModel.temperatureGap!).toStringAsFixed(1);

    return Scaffold(
      body: switch (viewModel.status) {
        HomeScreenStatus.error => const Center(child: Text('데이터를 불러올 수 없습니다.')),
        HomeScreenStatus.idle => const SizedBox(),
        HomeScreenStatus.loading || HomeScreenStatus.success => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image:
                    CachedNetworkImageProvider(viewModel.backgroundImagePath),
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
                          SizedBox(
                              height: ReactionUtil.reactHeight(
                            context: context,
                            marginHeight: 40,
                          )),
                          // city
                          viewModel.dailyLocationWeather != null
                              ? HomeScreenCityTextWidget(
                                  city: viewModel
                                      .dailyLocationWeather!.location.city)
                              : const HomeScreenCityTextWidget(city: '-'),
                          const SizedBox(height: 4),
                          // weather code description
                          viewModel.currentWeather != null
                              ? HomeScreenCurrentWeatherTextWidget(
                                  currentWeather: WeatherCode.fromValue(
                                          viewModel.currentWeather!.code)
                                      .description)
                              : const HomeScreenCurrentWeatherTextWidget(
                                  currentWeather: '-',
                                ),
                          SizedBox(
                              height: ReactionUtil.reactHeight(
                            context: context,
                            marginHeight: 20,
                          )),
                          // current temperature
                          viewModel.currentWeather != null
                              ? HomeScreenCurrentTemperatureTextWidget(
                                  currentTemperature:
                                      '${viewModel.currentWeather!.temperature}',
                                )
                              : const HomeScreenCurrentTemperatureTextWidget(
                                  currentTemperature: '-',
                                ),
                          SizedBox(
                              height: ReactionUtil.reactHeight(
                            context: context,
                            marginHeight: 20,
                          )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              // max, min temperature

                              Column(
                                children: [
                                  viewModel.dailyLocationWeather != null
                                      ? HomeScreenDailyHighestTemperatureTextWidget(
                                          highestTemperature:
                                              '${viewModel.dailyLocationWeather!.highTemperature}',
                                        )
                                      : const HomeScreenDailyHighestTemperatureTextWidget(
                                          highestTemperature: '-',
                                        ),
                                  viewModel.dailyLocationWeather != null
                                      ? HomeScreenDailyLowestTemperatureTextWidget(
                                          lowestTemperature:
                                              '${viewModel.dailyLocationWeather!.lowTemperature}',
                                        )
                                      : const HomeScreenDailyLowestTemperatureTextWidget(
                                          lowestTemperature: '-',
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
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          (viewModel.temperatureGap! >= 0)
                                              ? ImagePath.temperatureUpArrowIcon
                                              : ImagePath
                                                  .temperatureDownArrowIcon,
                                          width: 16,
                                          height: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '$temperatureGapPresentation℃',
                                          style: const TextStyle(
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
                          SizedBox(
                            height: ReactionUtil.reactHeight(
                              context: context,
                              marginHeight: 40,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // weathers by time
                    WeatherByTimeListWidget(
                      weatherList: viewModel.weatherByTimeList,
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: ReactionUtil.reactHeight(
                          context: context,
                          marginHeight: 20,
                        ),
                      ),
                    ),

                    // ootd list
                    RecommendOotdListWidget(
                      isLoading: viewModel.isRecommendOotdLoading,
                      dailyLocationWeather: viewModel.dailyLocationWeather,
                      feedList: viewModel.feedList,
                    ),
                  ],
                ),
              ),
            ),
          ),
      },
    );
  }
}

class HomeScreenCityTextWidget extends StatelessWidget {
  final String city;

  const HomeScreenCityTextWidget({
    super.key,
    required this.city,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      city,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }
}

class HomeScreenCurrentWeatherTextWidget extends StatelessWidget {
  const HomeScreenCurrentWeatherTextWidget({
    super.key,
    required this.currentWeather,
  });

  final String currentWeather;

  @override
  Widget build(BuildContext context) {
    return Text(
      currentWeather,
      style: const TextStyle(
        fontSize: 15,
        color: Colors.white,
      ),
    );
  }
}

class HomeScreenCurrentTemperatureTextWidget extends StatelessWidget {
  const HomeScreenCurrentTemperatureTextWidget({
    super.key,
    required this.currentTemperature,
  });

  final String currentTemperature;

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currentTemperature℃',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 60,
      ),
    );
  }
}

class HomeScreenDailyHighestTemperatureTextWidget extends StatelessWidget {
  const HomeScreenDailyHighestTemperatureTextWidget({
    super.key,
    required this.highestTemperature,
  });

  final String highestTemperature;

  @override
  Widget build(BuildContext context) {
    return Text(
      '최고 $highestTemperature℃',
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
    );
  }
}

class HomeScreenDailyLowestTemperatureTextWidget extends StatelessWidget {
  const HomeScreenDailyLowestTemperatureTextWidget({
    super.key,
    required this.lowestTemperature,
  });

  final String lowestTemperature;

  @override
  Widget build(BuildContext context) {
    return Text(
      '최저 $lowestTemperature℃',
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
    );
  }
}
