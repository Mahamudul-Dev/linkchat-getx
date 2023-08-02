import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../data/models/search_result_model.dart';
import '../../../database/cached_db_helper.dart';
import '../../../style/style.dart';
import '../../../widgets/widgets.dart';
import '../../profile/views/about_card_view.dart';
import '../../profile/views/profile_card_view.dart';
import '../controllers/search_controller.dart';

class SearchViewDelegate extends SearchDelegate<String> {
  final cachedDb = CachedDbHelper();
  SearchViewController controller = Get.put(SearchViewController());

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
        appBarTheme: const AppBarTheme(
            backgroundColor: black, foregroundColor: brightWhite),
        inputDecorationTheme:
            const InputDecorationTheme(border: InputBorder.none));
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => query = '',
          icon: const Icon(
            Icons.clear,
            color: brightWhite,
          ))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () => close(context, ''),
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
          color: brightWhite,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    return searchView(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
        itemCount: cachedDb.getSearchSuggestion().length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cachedDb.getSearchSuggestion()[index]),
            trailing: const Icon(
              Icons.call_made_rounded,
              color: brightWhite,
            ),
          );
        });
  }

  Widget searchView(BuildContext context) {
    return Column(
      children: [
        Expanded(
            child: Scaffold(
          appBar: TabBar(
            controller: controller.tabController.value,
            indicatorColor: accentColor,
            labelColor: accentColor,
            unselectedLabelColor: brightWhite,
            labelStyle: Theme.of(context).textTheme.bodyMedium,
            tabs: const [
              Tab(
                text: 'Global',
              ),
              Tab(
                text: 'Followers',
              ),
              Tab(
                text: 'Linked',
              ),
            ],
          ),
          body: TabBarView(
            controller: controller.tabController.value,
            children: [
              _buildGlobalSearchView(),
              _buildFollowerSearchView(),
              _buildLinkedSearchView()
            ],
          ),
        ))
      ],
    );
  }

  Widget _buildGlobalSearchView() {
    return FutureBuilder(
      future: controller.searchUser(queryText: query),
      builder: (context, AsyncSnapshot<SearchResultModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.global!.isEmpty) {
            return Center(
              child: Text(
                'No Data Found!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.global?.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  showBottomSheet(
                    backgroundColor: solidMate,
                    elevation: 0,
                    context: context,
                    enableDrag: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(35))),
                    builder: (context) {
                      return DraggableScrollableSheet(
                        initialChildSize: 0.9,
                        expand: true,
                        builder: (context, scrollController) {
                          return Container(
                              decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(35),
                                      topRight: Radius.circular(35))),
                              child: ListView(
                                controller: scrollController,
                                shrinkWrap: true,
                                children: [
                                  ProfileCardView(
                                    sId: snapshot.data?.global?[index].sId
                                            .toString() ??
                                        'N/A',
                                    bgColor: solidMate,
                                  ),
                                  AboutCardView(
                                      sId: snapshot.data?.global?[index].sId
                                              .toString() ??
                                          'N/A'),
                                ],
                              ));
                        },
                      );
                    },
                  );
                },
                child: UserListTile(
                    profilePic: snapshot.data!.global?[index].profilePic,
                    userName: snapshot.data!.global?[index].userName,
                    country: snapshot.data!.global?[index].country,
                    buttonStatus: controller
                        .getButtonStatus(snapshot.data!.global![index].sId!),
                    onPresses: () => controller.handleFollow(
                        snapshot.data!.global![index].sId!,
                        snapshot.data!.global![index].userName!)),
              );
            },
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'There was some error',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          );
        }
        return Obx(() {
          return controller.isLoading.value
              ? Container(
                  color: ThemeProvider().isSavedLightMood().value
                      ? brightWhite
                      : solidMate,
                  child: Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: accentColor, size: 50.w),
                  ),
                )
              : const SizedBox.shrink();
        });
      },
    );
  }

  Widget _buildFollowerSearchView() {
    return FutureBuilder(
      future: controller.searchUser(queryText: query),
      builder: (context, AsyncSnapshot<SearchResultModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.followers!.isEmpty) {
            return Center(
              child: Text(
                'No Data Found!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.followers?.length,
            itemBuilder: (context, index) {
              return UserListTile(
                profilePic: snapshot.data!.followers?[index].profilePic,
                userName: snapshot.data!.followers?[index].userName,
                email: snapshot.data!.followers?[index].email,
                country: snapshot.data!.followers?[index].country!,
                isActive: snapshot.data!.followers?[index].isActive ?? false,
                buttonStatus: controller
                    .getButtonStatus(snapshot.data!.followers![index].sId!),
                onPresses: () => controller.handleFollow(
                    snapshot.data!.followers![index].sId!,
                    snapshot.data!.followers![index].userName!),
              );
            },
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'There was some error',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          );
        }

        return Obx(() {
          return controller.isLoading.value
              ? Container(
                  color: ThemeProvider().isSavedLightMood().value
                      ? brightWhite
                      : solidMate,
                  child: Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: accentColor, size: 50.w),
                  ),
                )
              : const SizedBox.shrink();
        });
      },
    );
  }

  Widget _buildLinkedSearchView() {
    return FutureBuilder(
      future: controller.searchUser(queryText: query),
      builder: (context, AsyncSnapshot<SearchResultModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.linked!.isEmpty) {
            return Center(
              child: Text(
                'No Data Found!',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data?.linked?.length,
            itemBuilder: (context, index) {
              return UserListTile(
                  profilePic: snapshot.data!.linked?[index].profilePic,
                  userName: snapshot.data!.linked?[index].userName!,
                  email: snapshot.data!.linked?[index].email,
                  country: snapshot.data!.linked?[index].country,
                  isActive: snapshot.data!.linked?[index].isActive ?? false,
                  buttonStatus: controller
                      .getButtonStatus(snapshot.data!.linked![index].sId!),
                  onPresses: () => controller.handleFollow(
                      snapshot.data!.linked![index].sId!,
                      snapshot.data!.linked![index].userName!));
            },
          );
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'There was some error',
              style: Theme.of(context).textTheme.labelSmall,
            ),
          );
        }

        return Obx(() {
          return controller.isLoading.value
              ? Container(
                  color: ThemeProvider().isSavedLightMood().value
                      ? brightWhite
                      : solidMate,
                  child: Center(
                    child: LoadingAnimationWidget.inkDrop(
                        color: accentColor, size: 50.w),
                  ),
                )
              : const SizedBox.shrink();
        });
      },
    );
  }
}
