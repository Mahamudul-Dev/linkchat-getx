import 'package:flutter/material.dart';

import 'package:get/get.dart';

class GroupChatView extends GetView {
  const GroupChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GroupChatView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GroupChatView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
