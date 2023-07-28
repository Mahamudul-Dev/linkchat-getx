import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:linkchat/app/style/style.dart';
import 'package:linkchat/app/widgets/views/user_list_tile.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:path/path.dart';

import '../../../data/models/search_result_model.dart';
import '../controllers/search_controller.dart';

class SearchView extends GetView<SearchViewController> {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Obx(() => Container(
              height: 90.h,
              width: MediaQuery.of(context).size.width,
              color:
                  ThemeProvider().isSavedLightMood().value ? white : solidMate,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Spacer(),
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: controller.searchTextController.value,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search Keywords...',
                              contentPadding: const EdgeInsets.all(20),
                              hintStyle: Theme.of(context).textTheme.bodyMedium,
                              suffixIcon: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.search_rounded,
                                    color: brightWhite,
                                  ))),
                        ),
                      ),
                      const Icon(Icons.filter_alt_rounded),
                      const SizedBox(
                        width: 8,
                      )
                    ],
                  ),
                ],
              ),
            )),
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
    ));
  }

  Widget _buildGlobalSearchView() {
    return FutureBuilder(
      future: controller.searchUser(
          queryText: controller.searchTextController.value.text),
      builder: (context, AsyncSnapshot<SearchResultModel> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.global?.length,
            itemBuilder: (context, index) {
              return UserListTile(
                  profilePic: snapshot.data!.global![index].profilePic!,
                  userName: snapshot.data!.global![index].userName!,
                  email: snapshot.data!.global![index].email!,
                  country: snapshot.data!.global![index].country!);
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
      future: controller.searchUser(
          queryText: controller.searchTextController.value.text),
      builder: (context, AsyncSnapshot<SearchResultModel> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.followers?.length,
            itemBuilder: (context, index) {
              return UserListTile(
                profilePic: snapshot.data!.followers![index].profilePic!,
                userName: snapshot.data!.followers![index].userName!,
                email: snapshot.data!.followers![index].email!,
                country: snapshot.data!.followers![index].country!,
                isActive: snapshot.data!.followers![index].isActive!,
                buttonStatus: controller.getButtonStatus(snapshot.data!.followers![index].sId!).val,
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
      future: controller.searchUser(
          queryText: controller.searchTextController.value.text),
      builder: (context, AsyncSnapshot<SearchResultModel> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.linked?.length,
            itemBuilder: (context, index) {
              return UserListTile(
                profilePic: snapshot.data!.linked![index].profilePic!,
                userName: snapshot.data!.linked![index].userName!,
                email: snapshot.data!.linked![index].email!,
                country: snapshot.data!.linked![index].country!,
                isActive: snapshot.data!.linked![index].isActive!,
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
}
