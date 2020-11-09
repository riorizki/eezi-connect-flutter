import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/config/Setting.dart';
import 'package:eezi_connect/ui/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Widget/CardIconWidget.dart';
import 'Widget/CardWidget.dart';

class PaymentMenu extends StatelessWidget {
  const PaymentMenu({
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
              'Payment',
              style: TextStyle(
                color: COLOR_PRIMARY_1,
                fontSize: 18.nsp,
              ),
            ),
          ),
          CardIconWidget(
            mt: 19,
            iconName: Icons.credit_card,
            title: 'Credit Card',
          ),
          CardIconWidget(
            mt: 28,
            iconName: Icons.payment_rounded,
            title: 'Paypal',
          ),
          CardIconWidget(
            mt: 28,
            iconName: Icons.money_outlined,
            title: 'Cash',
          ),
        ],
      ),
    );
  }
}
