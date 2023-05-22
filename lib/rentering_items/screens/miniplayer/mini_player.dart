import 'package:flutter/material.dart';
import 'package:rythm1/rentering_items/screens/miniplayer/widget/miniplayer_widget.dart';
import 'package:page_transition/page_transition.dart';
import '../music_operation_screen/music_operation_page.dart';

InkWell bottomSheet(BuildContext context) {
  return InkWell(
    onTap: () => Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.bottomToTop,
        child: const MusicPlay(),
      ),
    ),
    child: Container(
      decoration: const BoxDecoration(
          color: Color.fromARGB(255, 135, 154, 251),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0), topRight: Radius.circular(25.0))),
      height: 115,
      width: double.infinity,
      child: bottomDetails(context),
    ),
  );
}
