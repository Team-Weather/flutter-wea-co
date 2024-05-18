import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/common/image_path.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/presentation/common/enum/exception_alert.dart';
import 'package:weaco/presentation/common/util/alert_util.dart';
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
      () async {
        await context.read<HomeScreenViewModel>().initHomeScreen();
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
        HomeScreenStatus.loading =>
          const Center(child: CircularProgressIndicator()),
        HomeScreenStatus.idle => const SizedBox(),
        HomeScreenStatus.success => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage(viewModel.backgroundImagePath),
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
                            viewModel.dailyLocationWeather!.location.city,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // weather code description
                          Text(
                            WeatherCode.fromValue(
                                    viewModel.currentWeather!.code)
                                .description,
                            style: const TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // current temperature
                          Text(
                            '${viewModel.currentWeather!.temperature}°',
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
                                    '최고 ${viewModel.dailyLocationWeather!.highTemperature}°',
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
                                    '최저 ${viewModel.dailyLocationWeather!.lowTemperature}°',
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
                                          '$temperatureGapPresentation°',
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
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),

                    // weathers by time
                    WeatherByTimeListWidget(
                      weatherList: viewModel.weatherByTimeList,
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.03),
                    ),
                    // ootd list
                    RecommandOotdListWidget(
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
