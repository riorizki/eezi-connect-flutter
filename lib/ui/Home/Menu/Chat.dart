import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'ChatRoom/ChatRoom.dart';
import 'Widget/ChatCardWidget.dart';

class ChatMenu extends StatelessWidget {
  const ChatMenu({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final HomeViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 19.h, left: 20.w, right: 20.w),
      height: 550.h,
      color: Colors.white,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 20,
              child: Center(
                child: Text(
                  'Chat Room',
                  style: TextStyle(
                    fontSize: 18.nsp,
                    color: COLOR_PRIMARY_1,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 0,
            right: 0,
            child: Container(
              height: 530,
              child: RefreshIndicator(
                onRefresh: () async {
                  controller.getAllUser();
                },
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: controller.users.length,
                  itemBuilder: (context, idx) => ChatCardWidget(
                    imgUrl: controller.users[idx].avatar,
                    onTap: () {
                      Get.to(
                        Chat(
                            username: controller.users[idx].username,
                            peerAvatar: controller.users[idx].avatar,
                            peerId: controller.users[idx].id),
                      );
                    },
                    username: '${controller.users[idx].username}',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
