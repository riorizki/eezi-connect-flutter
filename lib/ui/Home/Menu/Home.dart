import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/config/Setting.dart';
import 'package:eezi_connect/ui/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Widget/CardWidget.dart';

class HomeMenu extends StatelessWidget {
  const HomeMenu({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final HomeViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.h,
      color: Colors.white,
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.h),
            child: Text(
              'Our Apps',
              style: TextStyle(
                color: COLOR_PRIMARY_1,
                fontSize: 18.nsp,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 19.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.launchApps(com: 'com.weeo.tracking');
                  },
                  child: CardWidget(
                    imageName: 'icon_tracking.png',
                    mr: 10,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.launchApps(com: 'com.weeo.match');
                  },
                  child: CardWidget(
                    imageName: 'icon_match.png',
                    mr: 10,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.launchApps(com: 'com.weeo.task');
                  },
                  child: CardWidget(
                    imageName: 'icon_task.png',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 28.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.launchApps(com: 'com.weeo.fence');
                  },
                  child: CardWidget(
                    imageName: 'icon_fence.png',
                    mr: 10,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.launchApps(com: 'com.weeo.guidance');
                  },
                  child: CardWidget(
                    imageName: 'icon_guidance.png',
                    mr: 10,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.launchApps(com: 'com.weeo.farm');
                  },
                  child: CardWidget(
                    imageName: 'icon_farm.png',
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 28.h),
            child: Text(
              'Third Parties Apps',
              style: TextStyle(
                color: COLOR_PRIMARY_1,
                fontSize: 18.nsp,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 19.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.launchBrowser(url: '$EDGE_COMPANY_URL');
                  },
                  child: CardWidget(
                    imageName: 'icon_the_edge_company.png',
                    mr: 10,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.launchBrowser(url: '$DITCH_ASSIST_URL');
                  },
                  child: CardWidget(
                    imageName: 'icon_ditch_assist.png',
                    mr: 10,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.launchBrowser(url: '$WEATHER_COMPANY_URL');
                  },
                  child: CardWidget(
                    imageName: 'icon_weather_company.png',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
