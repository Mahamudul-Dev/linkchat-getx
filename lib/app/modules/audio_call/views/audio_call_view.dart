import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/audio_call_controller.dart';

class AudioCallView extends GetView<AudioCallController> {
  const AudioCallView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AudioCallView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AudioCallView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
