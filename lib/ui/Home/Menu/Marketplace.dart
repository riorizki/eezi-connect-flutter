import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/ui/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Widget/CardBottomTitleWidget.dart';

class MarketPlaceMenu extends StatelessWidget {
  const MarketPlaceMenu({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final HomeViewModel controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 550.h,
      color: Colors.white,
      // color: COLOR_CONNECT_1.withOpacity(0.28),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.h),
            child: Text(
              'Marketplace',
              style: TextStyle(
                color: COLOR_PRIMARY_1,
                fontSize: 18.nsp,
              ),
            ),
          ),
          SizedBox(
            height: 24.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CardBottomTitleWidget(
                imageName: 'new_systems.png',
                title: 'New Systems',
              ),
              CardBottomTitleWidget(
                imageName: 'leasing.png',
                title: 'Leasing',
              ),
              CardBottomTitleWidget(
                imageName: 'Insurance.png',
                title: 'Insurance',
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CardBottomTitleWidget(
                imageName: 'used_equip.png',
                title: 'Used Equip',
              ),
              CardBottomTitleWidget(
                imageName: 'farm_market.png',
                title: 'Farm Market',
              ),
              CardBottomTitleWidget(
                imageName: 'rental.png',
                title: 'Rental',
              ),
            ],
          ),
          SizedBox(
            height: 8.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CardBottomTitleWidget(
                imageName: 'contractor.png',
                title: 'Contractor',
              ),
              CardBottomTitleWidget(
                imageName: 'chemical.png',
                title: 'Chemical',
              ),
              CardBottomTitleWidget(
                imageName: 'services.png',
                title: 'Services',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
