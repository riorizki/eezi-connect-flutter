import 'package:cached_network_image/cached_network_image.dart';
import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({
    Key key,
    this.username,
    this.imgUrl,
  }) : super(key: key);
  final String username;
  final String imgUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      color: COLOR_CONNECT_1,
      child: Container(
        margin: EdgeInsets.only(),
        child: Row(
          children: [
            Flexible(
              flex: 5,
              child: Row(
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
                  SizedBox(width: 10.w),
                  Flexible(
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
                                  color: COLOR_WHITE,
                                ),
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              child: Text(
                                'Online',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 10.nsp,
                                  color: COLOR_WHITE,
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
  }
}
