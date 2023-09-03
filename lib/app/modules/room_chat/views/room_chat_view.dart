import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:linkchat/app/data/utils/utils.dart';
import 'package:linkchat/app/style/style.dart';

import '../controllers/room_chat_controller.dart';

class RoomChatView extends GetView<RoomChatController> {
  const RoomChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Room'),
        centerTitle: false,
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 8),
              decoration: const BoxDecoration(
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: blackAccent,
                    backgroundImage: CachedNetworkImageProvider(PLACEHOLDER_IMAGE),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      SizedBox(width: MediaQuery.of(context).size.width*0.6, child: Text('Freelancers Bangladesh', style: Theme.of(context).textTheme.labelMedium, overflow: TextOverflow.ellipsis,)),
                      const SizedBox(height: 3,),
                      SizedBox(width: MediaQuery.of(context).size.width*0.6, child: Text('Official freelancers group of bangladesh', style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey),overflow: TextOverflow.ellipsis))
                      ,SizedBox(
                        width: MediaQuery.of(context).size.width*0.6,
                        height: 30,
                        child: Center(
                          child: ListView.separated(itemBuilder: (context, index){
                            return CircleAvatar(
                              radius: 10,
                              backgroundColor: blackAccent,
                              backgroundImage: CachedNetworkImageProvider(PLACEHOLDER_IMAGE),
                            );
                          }, itemCount: 10, scrollDirection: Axis.horizontal, separatorBuilder: (BuildContext context, int index) { return const SizedBox(width: 3,); },),
                        ),
                      )
                    ],
                  )
                ],
              ),
            );
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Row(
          children: [
            Text(
              'New Room',
              style: TextStyle(color: brightWhite, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 3,
            ),
            Icon(Icons.add)
          ],
        ),
        backgroundColor: accentColor,
      ),
    );
  }
}
