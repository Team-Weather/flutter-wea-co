import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/enum/season_code.dart';
import 'package:weaco/core/enum/weather_code.dart';
import 'package:weaco/core/extension/date_time.dart';
import 'package:weaco/presentation/ootd_feed_detail/view/pinch_zoom.dart';
import 'package:weaco/presentation/ootd_feed_detail/view_model/ootd_detail_view_model.dart';

class OotdDetailScreen extends StatefulWidget {
  final String _id;
  final String _mainImagePath;

  const OotdDetailScreen(
      {super.key, required String id, required String mainImagePath})
      : _mainImagePath = mainImagePath,
        _id = id;

  @override
  State<OotdDetailScreen> createState() => _OotdDetailScreenState();
}

class _OotdDetailScreenState extends State<OotdDetailScreen> {
  final double _detailAreaExpandHeight = 400;
  bool _isCancelAreaShow = false;


  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  }

  void _changeArea() {
    setState(() => _isCancelAreaShow = !_isCancelAreaShow);
  }

  Widget defaultWidget({double? opacity}) => Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey[300]!.withOpacity(opacity ?? 1),
              Colors.grey[200]!.withOpacity(opacity ?? 1),
            ],
          ),
        ),
      );

  Widget _loadingImageWidget({required String? data, double? opacity}) {
    return Builder(
      builder: (context) {
        if (data != null) {
          return Image.network(
            data,
            fit: BoxFit.fitHeight,
            errorBuilder: (context, error, stackTrace) =>
                defaultWidget(opacity: opacity),
          );
        } else {
          return defaultWidget(opacity: opacity);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    log('build() 호출 ${widget._id}');
    return SafeArea(
        child: Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        PinchZoom(
          child: _loadingImageWidget(
              data: widget._mainImagePath),
        ),
        GestureDetector(
          onTap: _changeArea,
          child: Visibility(
            visible: _isCancelAreaShow,
            maintainSize: false,
            child: Builder(builder: (context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                color: const Color(0x00ffffff),
              );
            }),
          ),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: _changeArea,
            child: AnimatedSize(
              alignment: _isCancelAreaShow
                  ? Alignment.topCenter
                  : Alignment.bottomCenter,
              curve: Curves.easeOutQuint,
              duration: const Duration(milliseconds: 300),
              child: Container(
                height: _isCancelAreaShow ? _detailAreaExpandHeight : 135,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Color(0x87000000),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.fromLTRB(16, 16, 16, 8),
                  child: Builder(builder: (context) {
                    log('하단 시트 build() 호출');
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          textBaseline: TextBaseline.ideographic,
                          children: [
                            SizedBox(
                              width: 25,
                              height: 25,
                              child: Image.asset(
                                  WeatherCode.fromValue(context
                                              .watch<OotdDetailViewModel>()
                                              .feed
                                              ?.weather
                                              .code ??
                                          0)
                                      .iconPath,
                                  errorBuilder: (_, __, ___) =>
                                      defaultWidget(opacity: 0.2)),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                              child: Text(
                                  '${context.watch<OotdDetailViewModel>().feed?.weather.temperature.toString() ?? ''}°C'),
                            ),
                            const Spacer(),
                            DefaultTextStyle(
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white),
                              child: Text(context
                                      .watch<OotdDetailViewModel>()
                                      .feed
                                      ?.createdAt
                                      .toFormat() ??
                                  ''),
                            ),
                            Visibility(
                                maintainSize: false,
                                visible: context
                                        .watch<OotdDetailViewModel>()
                                        .userProfile
                                        ?.email !=
                                    context
                                        .watch<OotdDetailViewModel>()
                                        .userProfile
                                        ?.email,
                                child: const Row(
                                  children: [
                                    SizedBox(
                                      width: 16,
                                    ),
                                    Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: Colors.white,
                                    )
                                  ],
                                ))
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0x33FFFFFF),
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                  child: Text(
                                      '#${SeasonCode.fromValue(context.watch<OotdDetailViewModel>().feed?.seasonCode ?? 0).description}'),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: const Color(0x33FFFFFF),
                                  border: Border.all(
                                      color: Colors.white, width: 1)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: DefaultTextStyle(
                                  style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.white),
                                  child: Text(
                                      '#${WeatherCode.fromValue(context.watch<OotdDetailViewModel>().feed?.weather.code ?? 0).description}'),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: DefaultTextStyle(
                                style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                                child: Text(
                                  context
                                          .watch<OotdDetailViewModel>()
                                          .feed
                                          ?.description ??
                                      '',
                                  overflow: _isCancelAreaShow
                                      ? null
                                      : TextOverflow.ellipsis,
                                  maxLines: _isCancelAreaShow ? null : 1,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 8, 0),
              child: Builder(builder: (context) {
                log('상단 프로필 build() 호출');
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: SizedBox(
                        width: 40,
                        height: 40,
                        child: _loadingImageWidget(
                            opacity: 0.2,
                            data: context
                                .watch<OotdDetailViewModel>()
                                .userProfile
                                ?.profileImagePath),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    DefaultTextStyle(
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white),
                      child: Text(context
                              .watch<OotdDetailViewModel>()
                              .feed
                              ?.userEmail ??
                          ''),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 28,
                      ),
                      color: Colors.white,
                      onPressed: () => context.pop(),
                    )
                  ],
                );
              }),
            ))
      ],
    ));
  }
}
