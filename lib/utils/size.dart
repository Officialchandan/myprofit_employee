import 'package:flutter/material.dart';

class DeviceSize extends StatelessWidget {
  const DeviceSize({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Container();
  }
}
