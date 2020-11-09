import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDownWidget extends StatelessWidget {
  const DropDownWidget({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75.w,
      height: 40.h,
      margin: EdgeInsets.only(left: 20.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: COLOR_PRIMARY_2,
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: 8.w,
        ),
        alignment: Alignment.center,
        child: DropDownButtonWidget(
          onTap: (val) => onTap(val),
        ),
      ),
    );
  }
}

class DropDownButtonWidget extends StatelessWidget {
  const DropDownButtonWidget({
    Key key,
    @required this.onTap,
  }) : super(key: key);

  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      underline: Container(),
      dropdownColor: COLOR_PRIMARY_2,
      value: 1,
      items: [
        DropdownMenuItem(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 5.w),
                width: 16.w,
                height: 12.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/indonesia_flag.png'),
                  ),
                ),
              ),
              Container(
                child: Text(
                  '+62',
                  style: TextStyle(
                    fontSize: 12.nsp,
                    color: COLOR_WHITE,
                  ),
                ),
              ),
            ],
          ),
          value: 1,
        ),
        DropdownMenuItem(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 5.w),
                width: 16.w,
                height: 12.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/italy-flag-icon-256.png'),
                  ),
                ),
              ),
              Container(
                child: Text(
                  '+81',
                  style: TextStyle(
                    fontSize: 12.nsp,
                    color: COLOR_WHITE,
                  ),
                ),
              ),
            ],
          ),
          value: 2,
        ),
        DropdownMenuItem(
          child: Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 5.w),
                width: 16.w,
                height: 12.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/japan-flag-icon-256.png'),
                  ),
                ),
              ),
              Container(
                child: Text(
                  '+39',
                  style: TextStyle(
                    fontSize: 12.nsp,
                    color: COLOR_WHITE,
                  ),
                ),
              ),
            ],
          ),
          value: 3,
        ),
      ],
      onChanged: (val) => onTap(val),
    );
  }
}
