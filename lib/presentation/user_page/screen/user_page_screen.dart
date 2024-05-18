import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:weaco/core/go_router/router_static.dart';
import 'package:weaco/domain/feed/model/feed.dart';
import 'package:weaco/domain/user/model/user_profile.dart';
import 'package:weaco/presentation/user_page/screen/component/feed_grid/feed_grid_deleted_user_widget.dart';
import 'package:weaco/presentation/user_page/screen/component/feed_grid/feed_grid_empty_widget.dart';
import 'package:weaco/presentation/user_page/screen/component/user_profile/user_profile_deleted_widget.dart';
import 'package:weaco/presentation/user_page/screen/component/user_profile/user_profile_widget.dart';
import 'package:weaco/presentation/user_page/view_model/user_page_view_model.dart';

class UserPageScreen extends StatefulWidget {
  const UserPageScreen({super.key});

  @override
  State<UserPageScreen> createState() => _UserPageScreenState();
}

class _UserPageScreenState extends State<UserPageScreen> {
  @override
  Widget build(BuildContext context) {
    UserPageViewModel userPageViewModel = context.watch<UserPageViewModel>();

    final UserProfile? userProfile = userPageViewModel.userProfile;
    final List<Feed> userFeedList = userPageViewModel.userFeedList;
    final bool isPageLoading = userPageViewModel.isPageLoading;

    return isPageLoading || userProfile == null
        ? Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(42),
              child: AppBar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                scrolledUnderElevation: 0,
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              child: Column(
                children: [
                  userProfile.deletedAt == null
                      ? UserProfileWidget(userProfile: userProfile)
                      : UserProfileDeletedWidget(userProfile: userProfile),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: Divider(),
                  ),
                  userProfile.deletedAt != null
                      ? const FeedGridDeletedUserWidget()
                      : userFeedList.isEmpty
                          ? const FeedGridEmptyWidget()
                          : _buildFeedList(),
                ],
              ),
            ),
          );
  }

  bool _handleFeedScroll(UserScrollNotification notification) {
    UserPageViewModel userPageViewModel = context.read<UserPageViewModel>();
    if (notification.direction == ScrollDirection.reverse &&
        notification.metrics.maxScrollExtent * 0.85 <
            notification.metrics.pixels) {
      userPageViewModel.fetchFeed();
    }

    return false;
  }

  Widget _buildFeedList() {
    return NotificationListener<UserScrollNotification>(
      onNotification: _handleFeedScroll,
      child: Expanded(
        child: _buildFeedGridView(),
      ),
    );
  }

  Widget _buildFeedGridView() {
    UserPageViewModel userPageViewModel = context.read<UserPageViewModel>();

    return GridView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: userPageViewModel.userFeedList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        crossAxisCount: 3,
      ),
      itemBuilder: (context, index) {
        return _buildFeedCard(userPageViewModel.userFeedList[index]);
      },
    );
  }

  Widget _buildFeedCard(Feed currentFeed) {
    return GestureDetector(
      onTap: () {
        RouterStatic.pushToOotdDetail(
          context,
          id: currentFeed.id ?? '',
          imagePath: currentFeed.imagePath,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image(
          image: NetworkImage(currentFeed.imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
