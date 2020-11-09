import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
