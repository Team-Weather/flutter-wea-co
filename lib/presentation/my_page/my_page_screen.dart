import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/enum/router_path.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/presentation/my_page/my_page_view_model.dart';
import 'package:weaco/presentation/user_page/screen/component/feed_grid/feed_grid_empty_widget.dart';
import 'package:weaco/presentation/user_page/screen/component/user_profile/user_profile_widget.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  @override
  Widget build(BuildContext context) {
    MyPageViewModel myPageViewModel = context.watch<MyPageViewModel>();

    final UserProfile? profile = myPageViewModel.profile;
    final List<Feed> feedList = myPageViewModel.feedList;
    final bool isPageLoading = myPageViewModel.isPageLoading;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
      ),
      body: isPageLoading || profile == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                children: [
                  UserProfileWidget(userProfile: profile),
                  const Divider(),
                  feedList.isEmpty
                      ? const FeedGridEmptyWidget()
                      : NotificationListener<UserScrollNotification>(
                          onNotification:
                              (UserScrollNotification notification) {
                            if (notification.direction ==
                                    ScrollDirection.reverse &&
                                notification.metrics.maxScrollExtent * 0.85 <
                                    notification.metrics.pixels) {
                              myPageViewModel.fetchFeed();
                            }

                            return false;
                          },
                          child: Expanded(
                            child: GridView.builder(
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: feedList.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: 3 / 4,
                                crossAxisSpacing: 4,
                                mainAxisSpacing: 4,
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    RouterStatic.goToOotdDetail(
                                      context,
                                      id: feedList[index].id ?? '',
                                      imagePath: feedList[index].imagePath,
                                    );
                                  },
                                  onLongPress: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) {
                                        return SizedBox(
                                          height: 120,
                                          width: double.maxFinite,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                width: 360,
                                                child: FilledButton(
                                                  onPressed: () {
                                                    final selectedFeed =
                                                        feedList[index];

                                                    context.push(
                                                        RouterPath
                                                            .ootdPost.path,
                                                        extra: selectedFeed);
                                                    context.pop();
                                                  },
                                                  style: FilledButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .primaryColor,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Text('수정'),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              SizedBox(
                                                height: 40,
                                                width: 360,
                                                child: FilledButton(
                                                  onPressed: () {
                                                    myPageViewModel
                                                        .removeSelectedFeed(
                                                            feedList[index]
                                                                .id!);
                                                    context.pop();
                                                  },
                                                  style: FilledButton.styleFrom(
                                                    backgroundColor:
                                                        Theme.of(context)
                                                            .colorScheme
                                                            .error,
                                                    shape:
                                                        const RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(12),
                                                      ),
                                                    ),
                                                  ),
                                                  child: const Text('삭제'),
                                                ),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(2),
                                    child: Image(
                                      image: NetworkImage(
                                          feedList[index].imagePath),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                ],
              ),
            ),
    );
  }
}
