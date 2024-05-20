import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:weaco/presentation/common/extension/image_extension.dart';

class CachedImageWidget extends StatelessWidget {
  final String _imageUrl;
  final Widget? _progressIndicatorBuilder;
  final Widget? _errorWidget;

  CachedImageWidget(
      String imageUrl, {Widget? progressIndicatorBuilder, Widget? errorWidget})
      : _imageUrl = imageUrl,
        _progressIndicatorBuilder = progressIndicatorBuilder,
        _errorWidget = errorWidget;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: _imageUrl,
      memCacheHeight: (16 * 35).cacheSize(context),
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          _progressIndicatorBuilder ?? Container(color: Colors.grey.withOpacity(0.05)),
      errorWidget: (context, url, error) => _errorWidget ?? _progressIndicatorBuilder ?? Container(color: Colors.grey.withOpacity(0.1)),
    );
  }
}