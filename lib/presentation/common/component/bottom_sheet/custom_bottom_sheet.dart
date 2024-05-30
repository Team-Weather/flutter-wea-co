import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weaco/presentation/common/style/colors.dart';

class CustomBottomSheet {
  /// pop 할 때 리턴받을 값을 넣으면 호출 한 곳에서 값을 반환받을 수 있는 바텀시트
  /// @param[child] 바텀시트에서 보여 줄 위젯
  static Future<T?> showSelectBottomSheet<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    double? heigth,
    bool? isScrollControlled,
    double? elevation,
    bool? barrierDismissible,
    bool? enableDrag,
    bool? useRootNavigator,
    bool? isExistCloseButton,
  }) async {
    final T? result = await showModalBottomSheet<T>(
      backgroundColor: WeacoColors.backgroundColor,
      isDismissible: barrierDismissible ?? true,
      enableDrag: enableDrag ?? true,
      useRootNavigator: useRootNavigator ?? false,
      context: context,
      elevation: elevation ?? 10,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(26),
          topRight: Radius.circular(26),
        ),
      ),
      isScrollControlled: isScrollControlled ?? true,
      builder: (BuildContext context) {
        return Container(
            padding: const EdgeInsets.only(top: 0, right: 20, left: 20),
            height: heigth,
            decoration: const BoxDecoration(
              color: WeacoColors.backgroundColor,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Scaffold(
              appBar: AppBar(
                leading: const SizedBox(),
                backgroundColor: WeacoColors.backgroundColor,
                title: Text(title ?? ''),
                actions: [
                  Offstage(
                    offstage: isExistCloseButton ?? false,
                    child: GestureDetector(
                      onTap: () {
                        context.pop();
                      },
                      child: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
              body: SafeArea(child: child),
            ));
      },
    );

    return result;
  }
}
