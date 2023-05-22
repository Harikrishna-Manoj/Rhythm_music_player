import 'package:flutter/material.dart';

Center logo(context) {
  var size = MediaQuery.of(context).size;
  var height = size.height;
  var width = size.width;
  return Center(
    child: Padding(
      padding: EdgeInsets.only(bottom: height * .20, right: width * 0.03),
      child: Image.asset('assets/images/LOGO.png'),
    ),
  );
}
