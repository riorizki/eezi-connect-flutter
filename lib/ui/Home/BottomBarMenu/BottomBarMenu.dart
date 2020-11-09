import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BottomItemWidget/BottomItemWidget.dart';

class BottomBarMenu extends StatelessWidget {
  const BottomBarMenu({
    Key key,
    @required this.model,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
            GestureDetector(
              onTap: () {
                model.changeMenuIndex(0);
              },
              child: BottomItemWidget(
                iconData: Icons.home,
                title: 'Home',
                color: model.indexMenu == 0 ? COLOR_ACCENT : COLOR_WHITE,
              ),
            ),
            GestureDetector(
              onTap: () {
                model.changeMenuIndex(1);
              },
              child: BottomItemWidget(
                iconData: Icons.chat,
                title: 'Chat',
                color: model.indexMenu == 1 ? COLOR_ACCENT : COLOR_WHITE,
              ),
            ),
            GestureDetector(
              onTap: () {
                model.changeMenuIndex(2);
              },
              child: BottomItemWidget(
                iconData: Icons.account_balance_wallet,
                title: 'Payment',
                color: model.indexMenu == 2 ? COLOR_ACCENT : COLOR_WHITE,
              ),
            ),
            GestureDetector(
              onTap: () {
                model.changeMenuIndex(3);
              },
              child: BottomItemWidget(
                iconData: Icons.local_mall,
                title: 'Marketplace',
                color: model.indexMenu == 3 ? COLOR_ACCENT : COLOR_WHITE,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
