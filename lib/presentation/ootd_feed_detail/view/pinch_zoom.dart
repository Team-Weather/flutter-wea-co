import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';

class PinchZoom extends StatefulWidget {
  final Widget child;

  const PinchZoom({
    super.key,
    required this.child,
  });

  @override
  State<PinchZoom> createState() => _PinchZoomState();
}

class _PinchZoomState extends State<PinchZoom>
    with SingleTickerProviderStateMixin {
  final TransformationController _transformationController =
      TransformationController();
  OverlayEntry? _overlayEntry;
  final widgetKey = GlobalKey();
  Timer? _endScrollTimer;
  bool? endHandled;
  final Matrix4 identity = Matrix4.identity();

  @override
  Widget build(BuildContext context) {
    log('핀치 줌 이미지 build() 호출');
    return InteractiveViewer(
      key: widgetKey,
      maxScale: 3.0,
      onInteractionStart: (details) {
        endHandled = null;
        if (details.pointerCount < 2) {
          endHandled = false;
          _transformationController.value = identity;
        } else {
          _endScrollTimer?.cancel();
        }
      },
      onInteractionUpdate: (details) {
        if (details.pointerCount < 2) {
          endHandled = false;
          _transformationController.value = identity;
        } else {
          _endScrollTimer?.cancel();
        }
      },
      onInteractionEnd: (details) {
        if (details.pointerCount == 0) {
          endHandled = false;
          _transformationController.value = identity;
        } else {
          _endScrollTimer = Timer(const Duration(milliseconds: 100), () {
            endHandled = false;
            _transformationController.value = identity;
          });
        }
      },
      transformationController: _transformationController,
      child: widget.child,
    );
  }

  @override
  void initState() {
    super.initState();
    _transformationController.addListener(
      () {
        bool isIdentity = _transformationController.value.isIdentity();
        OverlayEntry? entry = _overlayEntry;

        if (endHandled == true) {
          _transformationController.value = identity;
        } else if (endHandled == false) {
          endHandled = true;
          if (entry != null) {
            entry.remove();
            _overlayEntry = null;
          }
        } else if (!isIdentity && entry == null) {
          RenderBox? box =
              widgetKey.currentContext?.findRenderObject() as RenderBox?;
          if (box == null) return;
          Offset position = box.localToGlobal(Offset.zero);
          entry = OverlayEntry(
            builder: (context) => ValueListenableBuilder(
              valueListenable: _transformationController,
              builder: (BuildContext context, Matrix4 value, Widget? child) {
                return Positioned(
                  left: position.dx,
                  top: position.dy,
                  width: box.size.width,
                  height: box.size.height,
                  child: IgnorePointer(
                    child: Transform(
                      transform: value,
                      child: widget.child,
                    ),
                  ),
                );
              },
            ),
          );
          _overlayEntry = entry;
          Overlay.of(context).insert(entry);
        }
      },
    );
  }
}
