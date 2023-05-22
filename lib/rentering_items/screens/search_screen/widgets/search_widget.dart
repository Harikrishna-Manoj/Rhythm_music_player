import 'package:flutter/material.dart';
import '../../../styles_images/utils.dart';

Container searchWidget(context) {
  var size = MediaQuery.of(context).size;
  var height = size.height;
  var width = size.width;
  return Container(
    height: height * 0.05,
    width: width * .83,
    decoration: const BoxDecoration(
      color: Color.fromARGB(255, 219, 222, 235),
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/search.png',
            scale: 4,
          ),
        ),
        Text(
          'Search',
          style: safeGoogleFont(
            'Poppins',
            fontSize: 15,
            height: 1.5,
            color: Colors.black,
          ),
        ),
      ],
    ),
  );
}

Center noSearchWidget() {
  return Center(
      child: Text(
    'Sorry,Song not founded :(',
    style: safeGoogleFont('Poppins', fontWeight: FontWeight.w500),
  ));
}
