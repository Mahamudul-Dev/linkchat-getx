import 'package:flutter/material.dart';

import 'package:get/get.dart';

class EmailLoginView extends GetView {
  const EmailLoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EmailLoginView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EmailLoginView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
