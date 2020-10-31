import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AppBarComponent(),
          BodyComponent(),
          Positioned(
            top: 567.h,
            left: 20.w,
            right: 20.w,
            child: Container(
              width: 320.w,
              height: 60.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: COLOR_CONNECT_1,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BottomItemWidget(
                    iconData: Icons.home,
                    title: 'Home',
                    color: COLOR_ACCENT,
                  ),
                  BottomItemWidget(
                    iconData: Icons.chat,
                    title: 'Messages',
                    color: COLOR_WHITE,
                  ),
                  BottomItemWidget(
                    iconData: Icons.account_balance_wallet,
                    title: 'Payment',
                    color: COLOR_WHITE,
                  ),
                  BottomItemWidget(
                    iconData: Icons.local_mall,
                    title: 'Marketplace',
                    color: COLOR_WHITE,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomItemWidget extends StatelessWidget {
  const BottomItemWidget({
    Key key,
    this.iconData,
    this.title,
    this.color,
  }) : super(key: key);

  final IconData iconData;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Icon(
              iconData,
              color: color,
              size: 24.w,
            ),
          ),
          Container(
            child: Text(
              '$title',
              style: TextStyle(
                fontSize: 9.nsp,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BodyComponent extends StatelessWidget {
  const BodyComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90.h,
      left: 0,
      right: 0,
      child: Container(
        height: 550.h,
        color: COLOR_CONNECT_1.withOpacity(0.28),
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
                  CardWidget(
                    imageName: 'icon_tracking.png',
                    mr: 10,
                  ),
                  CardWidget(
                    imageName: 'icon_match.png',
                    mr: 10,
                  ),
                  CardWidget(
                    imageName: 'icon_task.png',
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 28.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CardWidget(
                    imageName: 'icon_fence.png',
                    mr: 10,
                  ),
                  CardWidget(
                    imageName: 'icon_guidance.png',
                    mr: 10,
                  ),
                  CardWidget(
                    imageName: 'icon_farm.png',
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
                  CardWidget(
                    imageName: 'icon_the_edge_company.png',
                    mr: 10,
                  ),
                  CardWidget(
                    imageName: 'icon_ditch_assist.png',
                    mr: 10,
                  ),
                  CardWidget(
                    imageName: 'icon_weather_company.png',
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

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key key,
    this.imageName,
    this.mt = 0.0,
    this.mb = 0.0,
    this.mr = 0.0,
    this.ml = 0.0,
  }) : super(key: key);

  final String imageName;
  final double mt, mb, mr, ml;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: mt.h,
        bottom: mb.h,
        right: mr.w,
        left: ml.w,
      ),
      width: 100.w,
      height: 100.h,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/$imageName'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 90.h,
        color: COLOR_CONNECT_1,
        child: Container(
          margin: EdgeInsets.only(top: 36.h, left: 19.w, right: 19.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            children: [
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Icon(
                        Icons.close,
                        color: COLOR_WHITE,
                        size: 24.w,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Logout',
                        style: TextStyle(
                          color: COLOR_WHITE,
                          fontSize: 9.nsp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 69.w,
                height: 36.43.h,
                child: Image.asset(
                  'assets/images/icon_connect.png',
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      child: Icon(
                        Icons.person,
                        color: COLOR_WHITE,
                        size: 24.w,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Profile',
                        style: TextStyle(
                          color: COLOR_WHITE,
                          fontSize: 9.nsp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
