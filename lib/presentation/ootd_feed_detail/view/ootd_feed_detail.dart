import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:weaco/presentation/ootd_feed_detail/view/pinch_zoom.dart';

class OotdDetailScreen extends StatefulWidget {
  final String _id;

  const OotdDetailScreen({super.key, required String id}) : _id = id;

  @override
  State<OotdDetailScreen> createState() => _OotdDetailScreenState();
}

class _OotdDetailScreenState extends State<OotdDetailScreen> {
  final double _detailAreaExpandHeight = 400;
  bool _isCancelAreaShow = false;

  void _changeArea() {
    setState(() => _isCancelAreaShow = !_isCancelAreaShow);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: [
        PinchZoom(
          child: Image.network(
            'https://user-images.githubusercontent.com/38002959/143966223-7c10b010-32a9-4fd5-b021-3a9764134318.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        GestureDetector(
          onTap: _changeArea,
          child: Visibility(
            visible: _isCancelAreaShow,
            maintainSize: false,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Color(0xFFFFFF),
            ),
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
              duration: const Duration(milliseconds: 500),
              child: Container(
                height: _isCancelAreaShow ? _detailAreaExpandHeight : null,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  color: Color(0x87000000),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10.0, // 얼마나 흩어져
                      spreadRadius: 0.1, // 얼마나 두껍게
                    )
                  ],
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 18),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: Image.network(
                              'https://cdn-icons-png.flaticon.com/256/169/169367.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                            child: Text('기온 25.5'),
                          ),
                          Spacer(),
                          const DefaultTextStyle(
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: Colors.white),
                            child: Text('2023.04.27'),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.white,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0x33FFFFFF),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                                child: Text('#봄'),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0x33FFFFFF),
                                border:
                                    Border.all(color: Colors.white, width: 1)),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              child: DefaultTextStyle(
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.white),
                                child: Text('#맑음'),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      SizedBox(
                        height: _isCancelAreaShow ? 274 : null,
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
                                '${widget._id}가나다라마바사아자차카타파하\n' * 100,
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
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 0,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(18, 16, 8, 16),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.network(
                      width: 40,
                      height: 40,
                      'https://health.chosun.com/site/data/img_dir/2024/01/22/2024012201607_0.jpg',
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  const DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    child: Text('호구몬_사실 후곰'),
                  ),
                  Spacer(),
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      size: 24,
                    ),
                    color: Colors.black,
                    onPressed: () => context.pop(),
                  )
                ],
              ),
            ))
      ],
    ));
  }
}
