import 'package:flutter/material.dart';

import 'package:get/get.dart';

class FingerprintView extends GetView {
  const FingerprintView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FingerprintViewView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FingerprintViewView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
