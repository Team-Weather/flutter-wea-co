import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/enum/season_code.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/presentation/ootd_post/ootd_post_view_model.dart';

class OotdPostScreen extends StatefulWidget {
  const OotdPostScreen({super.key});

  @override
  State<OotdPostScreen> createState() => _OotdPostScreenState();
}

class _OotdPostScreenState extends State<OotdPostScreen> {
  static const int maxLength = 300;
  late ScrollController _scrollController;
  final TextEditingController _contentTextController = TextEditingController();
  bool isClicked = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    Future.microtask(() => context.read<OotdPostViewModel>().initOotdPost());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<OotdPostViewModel>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(viewModel),
        body: viewModel.showSpinner
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                controller: _scrollController,
                // physics: NeverScrollableScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 80),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Image.file(viewModel.image!),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.crop),
                                    Text('수정'),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      isClicked
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.fromLTRB(0, 40, 0, 30),
                              child: Text(
                                '어떤 코디를 하셨나요?',
                                style: TextStyle(
                                  color: Color(0xFF979797),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 12, 0, 20),
                        child: IconButton(
                          onPressed: () {
                            _scrollTo();
                            setState(() {
                              isClicked = !isClicked;
                            });
                          },
                          icon: isClicked
                              ? const Icon(Icons.arrow_circle_up_outlined,
                                  size: 30)
                              : const Icon(Icons.arrow_circle_down_outlined,
                                  size: 30),
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              _tags(viewModel
                                  .dailyLocationWeather!.location.city),
                              _tags(SeasonCode.fromValue(viewModel
                                      .dailyLocationWeather!.seasonCode)
                                  .description),
                              _tags('${viewModel.weather!.temperature}°'),
                              _tags(WeatherCode.fromDtoCode(
                                      viewModel.weather!.code)
                                  .description),
                            ],
                          ),
                          const SizedBox(height: 15),
                          TextField(
                            controller: _contentTextController,
                            maxLength: maxLength,
                            maxLines: 13,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: '어떤 코디를 하셨나요?',
                              hintStyle:
                                  const TextStyle(color: Color(0xFF979797)),
                              border: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }

  PreferredSizeWidget _appBar(OotdPostViewModel viewModel) {
    return AppBar(
      title: const Text('피드글 쓰기'),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.arrow_back),
      ),
      actions: [
        TextButton(
          onPressed: () {
            viewModel.saveFeed(_contentTextController.text, (result) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: result
                      ? const Text('저장되었습니다.')
                      : const Text('다시 시도해 주세요.'),
                ),
              );
            });
          },
          child: const Text(
            '저장',
            style: TextStyle(color: Color(0xFFFC8800), fontSize: 18),
          ),
        ),
      ],
    );
  }

  Widget _tags(String name) {
    return Container(
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        color: const Color(0xFFDFF0FF),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6),
        child: Text(name),
      ),
    );
  }

  void _scrollTo() {
    _scrollController.animateTo(
      isClicked ? 0.0 : _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
