import 'package:cached_network_image/cached_network_image.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ChatCardWidget extends StatelessWidget {
  const ChatCardWidget(
      {Key key,
      this.username,
      this.textChat,
      this.dateTime,
      this.isBubble = false,
      this.chatUnread,
      this.onTap,
      this.imgUrl})
      : super(key: key);

  final String username;
  final String textChat;
  final String dateTime;
  final bool isBubble;
  final String chatUnread;
  final Function onTap;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () {
        onTap();
      },
      child: Container(
        width: 320.w,
        height: 40.h,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              flex: 5,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    child: Container(
                      width: 36.w,
                      height: 36.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: COLOR_ACCENT,
                      ),
                      child: GetUtils.isNullOrBlank(imgUrl)
                          ? CircleAvatar(
                              radius: 18.w,
                              child: Center(
                                child: Icon(
                                  Icons.person,
                                  size: 12.w,
                                  color: COLOR_GRAY,
                                ),
                              ),
                            )
                          : CircleAvatar(
                              backgroundImage:
                                  CachedNetworkImageProvider(imgUrl),
                            ),
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Flexible(
                    flex: 6,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              child: Text(
                                '$username',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12.nsp,
                                  color: COLOR_PRIMARY_2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );

    // return Container(
    //   width: 320.w,
    //   height: 85.h,
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //     crossAxisAlignment: CrossAxisAlignment.center,
    //     children: [
    //       Flexible(
    //         flex: 5,
    //         child: Row(
    //           crossAxisAlignment: CrossAxisAlignment.center,
    //           children: [
    //             Flexible(
    //               child: Container(
    //                 width: 36.w,
    //                 height: 36.w,
    //                 decoration: BoxDecoration(
    //                   shape: BoxShape.circle,
    //                   color: COLOR_ACCENT,
    //                 ),
    //               ),
    //             ),
    //             SizedBox(
    //               width: 10.w,
    //             ),
    //             Flexible(
    //               flex: 6,
    //               child: Container(
    //                 child: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     Flexible(
    //                       child: Container(
    //                         child: Text(
    //                           '$username',
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: TextStyle(
    //                             fontWeight: FontWeight.bold,
    //                             fontSize: 12.nsp,
    //                             color: COLOR_PRIMARY_2,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                     SizedBox(
    //                       height: 3.h,
    //                     ),
    //                     Flexible(
    //                       flex: 6,
    //                       child: Container(
    //                         child: Text(
    //                           '$textChat',
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: TextStyle(
    //                             fontSize: 10.nsp,
    //                             color: COLOR_DARK_GRAY,
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       ),
    //       Flexible(
    //         child: Container(
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.end,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               isBubble
    //                   ? Container(
    //                       decoration: BoxDecoration(
    //                         color: COLOR_RED,
    //                         borderRadius: BorderRadius.circular(10),
    //                       ),
    //                       padding: EdgeInsets.symmetric(
    //                           horizontal: 3.w, vertical: 1.h),
    //                       child: Center(
    //                         child: Text(
    //                           '$chatUnread',
    //                           maxLines: 1,
    //                           overflow: TextOverflow.ellipsis,
    //                           style: TextStyle(
    //                             fontSize: 9.nsp,
    //                             color: COLOR_WHITE,
    //                             fontWeight: FontWeight.bold,
    //                           ),
    //                         ),
    //                       ),
    //                     )
    //                   : Container(),
    //               SizedBox(
    //                 height: 3.h,
    //               ),
    //               Container(
    //                 child: Text(
    //                   '$dateTime',
    //                   maxLines: 1,
    //                   overflow: TextOverflow.ellipsis,
    //                   style: TextStyle(
    //                     fontSize: 10.nsp,
    //                     color: isBubble ? COLOR_RED : COLOR_DARK_GRAY,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
