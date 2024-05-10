enum RouterPath {
  defaultPage(path: '/'),
  home(path: '/homeScreen'),
  signUp(path: '/signUp'),
  signIn(path: '/signIn'),
  dialog(path: '/dialog'),
  appSetting(path: '/appSetting'),
  myPage(path: '/myPage'),
  userPage(path: '/userPage'),
  ootdSearch(path: '/ootdSearchScreen'),
  ootdFeed(path: '/ootdFeedScreen'),
  ootdDetail(path: '/ootdDetailScreen'),
  camera(path: '/cameraScreen'),
  pictureCrop(path: '/pictureCropScreen'),
  ootdPost(path: '/ootdPostScreen');

  final String path;

  const RouterPath({required this.path});
}
