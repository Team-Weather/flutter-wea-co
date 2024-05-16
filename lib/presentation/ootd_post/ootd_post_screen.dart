import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
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
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _contentTextController = TextEditingController();
  bool isClicked = false;
  bool _isScrolledUp = true;
  CroppedFile? _newCroppedFile;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
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
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(28, 15, 28, 30),
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          _newCroppedFile == null // 새 크롭 화면의 image null 검사
                              ? viewModel.croppedImage ==
                                      null // viewModel image null 검사
                                  ? const Center(
                                      child: CircularProgressIndicator())
                                  : Image.file(viewModel.croppedImage!)
                              : Image.file(File(_newCroppedFile!.path)),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: GestureDetector(
                              onTap: () async {
                                await viewModel.getOriginImage();
                                await cropImage(viewModel.originImage!.path);
                              },
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
                          ),
                        ],
                      ),
                      !_isScrolledUp
                          ? const SizedBox()
                          : const Padding(
                              padding: EdgeInsets.only(top: 20),
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
                            setState(() {
                              _isScrolledUp = !_isScrolledUp;
                            });
                            _scrollTo();
                          },
                          icon: _isScrolledUp
                              ? const Icon(Icons.arrow_circle_down_outlined,
                                  size: 40)
                              : const Icon(Icons.arrow_circle_up_outlined,
                                  size: 40),
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
                            maxLines: 10,
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
                          SizedBox(
                            height: MediaQuery.of(context).viewInsets.bottom,
                          )
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
        onPressed: () async {
          await viewModel.getOriginImage();
          await cropImage(viewModel.originImage!.path);
        },
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

  Future<void> cropImage(String sourcePath) async {
    final croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      aspectRatio: const CropAspectRatio(ratioX: 9, ratioY: 16),
      uiSettings: [
        AndroidUiSettings(
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.ratio16x9,
          lockAspectRatio: true, // 비율 고정
        ),
        IOSUiSettings(
          title: '이미지 자르기',
          minimumAspectRatio: 1.0, // 비율 고정
          rotateButtonsHidden: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );

    if (croppedFile != null) {
      setState(() {
        _newCroppedFile = croppedFile;
      });
    }
  }

  void _scrollListener() {
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      // 스크롤 위치가 상단에 도달하면 화살표를 위로 표시
      setState(() {
        _isScrolledUp = true;
      });
    } else if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      // 스크롤 위치가 하단에 도달하면 화살표를 아래로 표시
      setState(() {
        _isScrolledUp = false;
      });
    }
  }

  void _scrollTo() {
    _scrollController.animateTo(
      _isScrolledUp
          ? _scrollController.position.minScrollExtent
          : _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
