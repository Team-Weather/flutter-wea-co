import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/enum/season_code.dart';
import 'package:weaco/core/enum/temperature_code.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/presentation/ooted_search/view_model/ootd_search_view_model.dart';

class OotdSearchScreen extends StatefulWidget {
  const OotdSearchScreen({super.key});

  @override
  State<OotdSearchScreen> createState() => _OotdSearchScreenState();
}

class _OotdSearchScreenState extends State<OotdSearchScreen> {
  final List<String> seasonItemList =
      List.generate(4, (index) => SeasonCode.fromValue(index + 1).description);

  final List<String> weatherItemList = List.generate(
      12, (index) => WeatherCode.fromValue(index + 1).description);
  final List<String> temperatureItemList = List.generate(
      6, (index) => TemperatureCode.fromValue(index + 1).description);

  List<String?> selectedData = [null, null, null];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                dropDownButton(
                    defaultText: '계절',
                    borderColor: const Color(0xFFF2C347),
                    items: seasonItemList,
                    width: 80,
                    selectedValueIndex: 0,
                    onChanged: (value) {
                      context.read<OotdSearchViewModel>().tmpMethod(
                          seasonCodeValue:
                              seasonItemList.indexOf(value ?? '') + 1,
                          weatherCodeValue:
                              weatherItemList.indexOf(selectedData[1] ?? '') +
                                  1,
                          temperatureCodeValue: temperatureItemList
                                  .indexOf(selectedData[2] ?? '') +
                              1);
                      setState(() {
                        selectedData[0] = value;
                      });
                    },
                    fontSize: 13),
                dropDownButton(
                    defaultText: '날씨',
                    borderColor: const Color(0xFF4C8DE6),
                    items: weatherItemList,
                    width: 120,
                    selectedValueIndex: 1,
                    onChanged: (value) {
                      context.read<OotdSearchViewModel>().tmpMethod(
                          seasonCodeValue:
                              seasonItemList.indexOf(selectedData[0] ?? '') +
                                  1,
                          weatherCodeValue:
                              weatherItemList.indexOf(value ?? '') + 1,
                          temperatureCodeValue: temperatureItemList
                                  .indexOf(selectedData[2] ?? '') +
                              1);
                      setState(() {
                        selectedData[1] = value;
                      });
                    },
                    fontSize: 13),
                dropDownButton(
                    defaultText: '온도',
                    borderColor: const Color(0xFFE2853F),
                    items: temperatureItemList,
                    width: 130,
                    selectedValueIndex: 2,
                    onChanged: (value) {
                      context.read<OotdSearchViewModel>().tmpMethod(
                          seasonCodeValue:
                              seasonItemList.indexOf(selectedData[0] ?? '') +
                                  1,
                          weatherCodeValue:
                              weatherItemList.indexOf(selectedData[1] ?? '') +
                                  1,
                          temperatureCodeValue:
                              temperatureItemList.indexOf(value ?? '') + 1);
                      setState(() {
                        selectedData[2] = value;
                      });
                    },
                    fontSize: 12),
              ],
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
      required double width,
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
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              width: 2,
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
          width: width - 20,
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
