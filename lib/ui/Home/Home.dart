import 'package:eezi_connect/config/ColorConfig.dart';
import 'package:eezi_connect/config/Setting.dart';
import 'package:eezi_connect/config/SizeConfig.dart';
import 'package:eezi_connect/ui/Home/HomeViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:stacked/stacked.dart';

import 'AppBar/AppBar.dart';
import 'BottomBarMenu/BottomBarMenu.dart';
import 'Menu/Chat.dart';
import 'Menu/Home.dart';
import 'Menu/Payment.dart';
import 'Menu/Marketplace.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onModelReady: (model) => model.onInit(),
      builder: (context, model, child) => Scaffold(
        body: LoadingOverlay(
          isLoading: model.isBusy,
          child: Stack(
            children: [
              AppBarComponent(
                controller: model,
              ),
              BodyComponent(
                model: model,
              ),
              BottomBarMenu(
                model: model,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BodyComponent extends StatelessWidget {
  const BodyComponent({
    Key key,
    @required this.model,
  }) : super(key: key);

  final HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 90.h,
      left: 0,
      right: 0,
      child: model.indexMenu == 0
          ? HomeMenu(controller: model)
          : model.indexMenu == 1
              ? ChatMenu(controller: model)
              : model.indexMenu == 2
                  ? PaymentMenu(controller: model)
                  : model.indexMenu == 3
                      ? MarketPlaceMenu(controller: model)
                      : Container(),
    );
  }
}
