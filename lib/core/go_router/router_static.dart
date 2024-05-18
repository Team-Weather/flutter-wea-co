import 'package:flutter/material.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/core/go_router/router.dart';
import 'package:weaco/domain/feed/model/feed.dart';

class RouterStatic {
  static void goToDefault(BuildContext context) {
    router.go(RouterPath.defaultPage.path);
  }

  static void goToHome(BuildContext context) {
    router.go(RouterPath.home.path);
  }

  static void popToHome(BuildContext context) {
    router.pop(RouterPath.home.path);
  }

  static void goToSignUp(BuildContext context) {
    router.push(RouterPath.signUp.path);
  }

  static void goToSignIn(BuildContext context) {
    router.push(RouterPath.signIn.path);
  }

  static void goToDialog(BuildContext context) {
    router.go(RouterPath.dialog.path);
  }

  static void goToAppSetting(BuildContext context) {
    router.go(RouterPath.appSetting.path);
  }

  static void pushToAppSetting(BuildContext context) {
    router.push(RouterPath.appSetting.path);
  }

  static void goToAppSettingLicense(BuildContext context) {
    router.go(RouterPath.appSettingLicense.path);
  }

  static void pushToAppSettingLicense(BuildContext context) {
    router.push(RouterPath.appSettingLicense.path);
  }

  static void goToAppSettingPolicy(BuildContext context) {
    router.go(RouterPath.appSettingPolicy.path);
  }

  static void pushToAppSettingPolicy(BuildContext context) {
    router.push(RouterPath.appSettingPolicy.path);
  }

  static void goToMyPage(BuildContext context) {
    router.go(RouterPath.myPage.path);
  }

  static void goToUserPage(BuildContext context, {required String email}) {
    router.go('${RouterPath.userPage.path}?email=$email');
  }

  static void goToOotdSearch(BuildContext context) {
    router.push(RouterPath.ootdSearch.path);
  }

  static void goToOotdFeed(BuildContext context) {
    router.push(RouterPath.ootdFeed.path);
  }

  static void goToOotdDetail(BuildContext context,
      {required String id, required String imagePath}) {
    router.push('${RouterPath.ootdDetail.path}?id=$id&imagePath=$imagePath');
  }

  static void goToCamera(BuildContext context) {
    router.push(RouterPath.camera.path);
  }

  static void goToPictureCrop(BuildContext context, String path) {
    router.push(RouterPath.pictureCrop.path, extra: path);
  }

  static void goToOotdPost(BuildContext context, {Feed? feed}) {
    router.go(RouterPath.ootdPost.path, extra: feed);
  }

  static void popFromOotdPost(BuildContext context) {
    router.pop(RouterPath.ootdPost.path);
  }
}
