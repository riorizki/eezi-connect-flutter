import 'package:eezi_connect/ui/Login/components/PhoneNumber/widget/ButtonWidget.dart';
import 'package:eezi_connect/ui/Login/components/PhoneNumber/widget/DropDownWidget.dart';
import 'package:eezi_connect/ui/Login/components/PhoneNumber/widget/TextFieldWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PhoneNumberComponent extends StatelessWidget {
  const PhoneNumberComponent({
    Key key,
    @required this.textController,
    @required this.onTap,
  }) : super(key: key);

  final TextEditingController textController;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.h,
      ),
      child: Container(
        child: Row(
          children: [
            // Dropdown Button
            DropDownWidget(),
            SizedBox(
              width: 18.w,
            ),
            // Text Field
            TextFieldWidget(
              textController: textController,
            ),
            SizedBox(
              width: 17.w,
            ),
            // Button Next
            GestureDetector(onTap: onTap, child: ButtonWidget()),
          ],
        ),
      ),
    );
  }
}
