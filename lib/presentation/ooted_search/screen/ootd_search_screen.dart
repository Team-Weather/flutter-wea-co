import 'dart:developer';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/enum/season_code.dart';
import 'package:weaco/core/enum/temperature_code.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/core/util/reaction_util.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/presentation/common/style/colors.dart';
import 'package:weaco/presentation/ooted_search/view_model/ootd_search_view_model.dart';

class OotdSearchScreen extends StatefulWidget {
  const OotdSearchScreen({super.key});

  @override
  State<OotdSearchScreen> createState() => _OotdSearchScreenState();
}

class _OotdSearchScreenState extends State<OotdSearchScreen> {
  final List<String> seasonItemList =
      List.generate(5, (index) => SeasonCode.fromValue(index).description);

  final List<String> weatherItemList =
      List.generate(13, (index) => WeatherCode.fromValue(index).description);

  final List<String> temperatureItemList =
      List.generate(7, (index) => TemperatureCode.fromValue(index).description);

  List<String?> selectedData = [null, null, null];

  @override
  Widget build(BuildContext context) {
    final OotdSearchViewModel ootdSearchViewModel =
        context.watch<OotdSearchViewModel>();

    final List<Feed> searchFeedList = ootdSearchViewModel.searchFeedList;

    final bool isPageLoading = ootdSearchViewModel.isPageLoading;

    return isPageLoading
        ? const Center(child: CircularProgressIndicator())
        : Scaffold(
            appBar: AppBar(
              centerTitle: true,
              scrolledUnderElevation: 0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              title: const Text(
                'OOTD 검색',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: WeacoColors.greyColor90,
                ),
              ),
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Flexible(
                          flex: 1,
                          child: dropDownButton(
                              defaultText: '🌸 계절',
                              borderColor: WeacoColors.accentColor,
                              items: seasonItemList,
                              selectedValueIndex: 0,
                              onChanged: (value) {
                                log(value.toString(), name: '계절');
                                ootdSearchViewModel.fetchFeedWhenFilterChange(
                                  seasonCodeValue:
                                      seasonItemList.indexOf(value ?? ''),
                                  weatherCodeValue: weatherItemList
                                      .indexOf(selectedData[1] ?? ''),
                                  temperatureCodeValue: temperatureItemList
                                      .indexOf(selectedData[2] ?? ''),
                                );
                                setState(() {
                                  selectedData[0] = value;
                                });
                              },
                              fontSize: 13),
                        ),
                        SizedBox(
                          width: ReactionUtil.reactWidth(
                            context: context,
                            marginWidth: 10,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: dropDownButton(
                              defaultText: '☀️ 날씨',
                              borderColor: WeacoColors.accentColor,
                              items: weatherItemList,
                              selectedValueIndex: 1,
                              onChanged: (value) {
                                log(value.toString(), name: '날씨');
                                ootdSearchViewModel.fetchFeedWhenFilterChange(
                                  seasonCodeValue: seasonItemList
                                      .indexOf(selectedData[0] ?? ''),
                                  weatherCodeValue:
                                      weatherItemList.indexOf(value ?? ''),
                                  temperatureCodeValue: temperatureItemList
                                      .indexOf(selectedData[2] ?? ''),
                                );
                                setState(() {
                                  selectedData[1] = value;
                                });
                              },
                              fontSize: 13),
                        ),
                        SizedBox(
                          width: ReactionUtil.reactWidth(
                            context: context,
                            marginWidth: 10,
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: dropDownButton(
                            defaultText: '🌡️ 온도',
                            borderColor: WeacoColors.accentColor,
                            items: temperatureItemList,
                            selectedValueIndex: 2,
                            onChanged: (value) {
                              log(value.toString(), name: '기온');
                              ootdSearchViewModel.fetchFeedWhenFilterChange(
                                seasonCodeValue: seasonItemList
                                    .indexOf(selectedData[0] ?? ''),
                                weatherCodeValue: weatherItemList
                                    .indexOf(selectedData[1] ?? ''),
                                temperatureCodeValue:
                                    temperatureItemList.indexOf(value ?? ''),
                              );
                              setState(() {
                                selectedData[2] = value;
                              });
                            },
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                    child: Divider(),
                  ),
                  NotificationListener<UserScrollNotification>(
                    onNotification: (UserScrollNotification notification) {
                      if (notification.direction == ScrollDirection.reverse &&
                          notification.metrics.maxScrollExtent * 0.85 <
                              notification.metrics.pixels) {
                        ootdSearchViewModel.fetchFeedWhenScroll(
                          seasonCodeValue:
                              seasonItemList.indexOf(selectedData[0] ?? ''),
                          weatherCodeValue:
                              weatherItemList.indexOf(selectedData[1] ?? ''),
                          temperatureCodeValue: temperatureItemList
                              .indexOf(selectedData[2] ?? ''),
                        );
                      }

                      return false;
                    },
                    child: Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: searchFeedList.length,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 3 / 4,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            crossAxisCount: 3,
                          ),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                RouterStatic.pushToOotdDetail(context,
                                    feed: searchFeedList[index]);
                              },
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image(
                                  image: NetworkImage(
                                      searchFeedList[index].imagePath),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }

  Widget dropDownButton(
      {required int selectedValueIndex,
      required String defaultText,
      required double fontSize,
      required List<String> items,
      required Color borderColor,
      required Function(String?) onChanged}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            Expanded(
              child: Text(
                defaultText,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ))
            .toList(),
        value: selectedData[selectedValueIndex],
        onChanged: (value) {
          onChanged(value);
        },
        buttonStyleData: ButtonStyleData(
          height: 40,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 1,
              color: borderColor,
            ),
            color: Colors.white,
          ),
          elevation: 0,
        ),
        iconStyleData: const IconStyleData(
          icon: Icon(
            color: Colors.black,
            Icons.keyboard_arrow_down_rounded,
          ),
          iconSize: 18,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          offset: const Offset(18, 0),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(30),
            thickness: MaterialStateProperty.all(2),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 35,
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 8),
        ),
      ),
    );
  }
}
