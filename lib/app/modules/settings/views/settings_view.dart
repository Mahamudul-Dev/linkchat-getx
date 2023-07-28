import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/modules/block_list/controllers/block_list_controller.dart';
import 'package:linkchat/app/routes/app_pages.dart';
import 'package:linkchat/app/style/style.dart';

import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  SettingsView({Key? key}) : super(key: key);
  final BlockListController _blockListController = Get.find<BlockListController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ListTile(
            onTap: () => Get.toNamed(Routes.BLOCK_LIST),
            leading: Icon(
              Icons.block_sharp,
              color: ThemeProvider().isSavedLightMood().value ? black : brightWhite,
            ),
            title: Text(
              'Block List',
              style: TextStyle(
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite),
            ),
            subtitle: Obx(() =>
                Text('${_blockListController.blockList.length} users blocked')),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite,
                )),
          ),
          const Divider(),
          ListTile(
            onTap: () {},
            leading: Icon(
              Icons.fingerprint_rounded,
              color: ThemeProvider().isSavedLightMood().value ? black : brightWhite,
            ),
            title: Text(
              'Manage Fingerprint',
              style: TextStyle(
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite,
                )),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.storage_rounded,
              color: ThemeProvider().isSavedLightMood().value ? black : brightWhite,
            ),
            title: Text(
              'Storage Settings',
              style: TextStyle(
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite,
                )),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.security_rounded,
              color: ThemeProvider().isSavedLightMood().value ? black : brightWhite,
            ),
            title: Text(
              'Privacy & Security',
              style: TextStyle(
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite,
                )),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              Icons.speaker,
              color: ThemeProvider().isSavedLightMood().value ? black : brightWhite,
            ),
            title: Text(
              'Sound & Notifications',
              style: TextStyle(
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite),
            ),
            trailing: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios_rounded,
                  color:
                      ThemeProvider().isSavedLightMood().value ? black : brightWhite,
                )),
          ),
          const Divider()
        ],
      ),
    );
  }
}
