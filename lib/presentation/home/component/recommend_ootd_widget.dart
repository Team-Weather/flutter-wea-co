import 'package:flutter/material.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/presentation/common/component/cached_image_widget.dart';

class RecommendOotdWidget extends StatelessWidget {
  const RecommendOotdWidget({
    super.key,
    required this.feedList,
    required this.index,
  });

  final List<Feed> feedList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 110 * 16 / 9,
      margin: const EdgeInsets.only(right: 25),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(48, 95, 95, 95),
                blurRadius: 2,
                offset: Offset(5, 0))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: CachedImageWidget(
          feedList[index].imagePath,
        ),
       
      ),
    );
  }
}
