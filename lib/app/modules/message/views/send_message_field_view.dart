import 'package:flutter/material.dart';

import 'package:get/get.dart';

class SendMessageFieldView extends GetView {
  const SendMessageFieldView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SendMessageFieldView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SendMessageFieldView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
