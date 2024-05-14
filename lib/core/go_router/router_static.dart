import 'package:flutter/material.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/core/go_router/router.dart';

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
    router.go(RouterPath.signUp.path);
  }

  static void goToSignIn(BuildContext context) {
    router.go(RouterPath.signIn.path);
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

  static void goToUserPage(BuildContext context) {
    router.go(RouterPath.userPage.path);
  }

  static void goToOotdSearch(BuildContext context) {
    router.go(RouterPath.ootdSearch.path);
  }

  static void goToOotdFeed(BuildContext context) {
    router.go(RouterPath.ootdFeed.path);
  }

  static void goToOotdDetail(BuildContext context) {
    router.go(RouterPath.ootdDetail.path);
  }

  static void goToCamera(BuildContext context) {
    router.go(RouterPath.camera.path);
  }

  static void goToPictureCrop(BuildContext context) {
    router.go(RouterPath.pictureCrop.path);
  }

  static void goToOotdPost(BuildContext context) {
    router.go(RouterPath.ootdPost.path);
  }
}
