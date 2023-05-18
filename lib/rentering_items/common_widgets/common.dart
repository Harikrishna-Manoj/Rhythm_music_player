import 'package:flutter/material.dart';
import '../styles_images/utils.dart';

Widget mainHeading(String mainHeading) {
  return Padding(
    padding: const EdgeInsets.only(right: 100),
    child: SizedBox(
      child: Row(
        children: [
          Text(
            mainHeading,
            style: safeGoogleFont(
              'Poppins',
              fontSize: 20,
              fontWeight: FontWeight.w600,
              height: 1.5,
              // color: Colors.black,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    ),
  );
}

Text tabHeading(String heading) {
  return Text(
    heading,
    style: safeGoogleFont(
      'Poppins',
      fontSize: 15,
      fontWeight: FontWeight.w500,
    ),
  );
}

Text allMusicHeading(String heading) {
  return Text(
    heading,
    style: safeGoogleFont(
      'Poppins',
      fontSize: 20,
      color: const Color(0xFF879AFB),
      fontWeight: FontWeight.w600,
    ),
  );
}

Text exploreFloatingButtonText(String text) {
  return Text(
    text,
    style: safeGoogleFont(
      'Poppins',
      fontSize: 20,
      color: Colors.white,
      fontWeight: FontWeight.w600,
    ),
  );
}

showSnackBar(
    {required BuildContext context,
    required String message,
    required Color colors,
    required Color textColor}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor),
      ),
      dismissDirection: DismissDirection.down,
      behavior: SnackBarBehavior.floating,
      elevation: 30,
      duration: const Duration(seconds: 1),
      backgroundColor: colors));
}
