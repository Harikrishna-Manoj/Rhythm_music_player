import 'package:flutter/material.dart';
import '../../../../../database/database_functions/favourit_function/favourit_functions.dart';

// ignore: must_be_immutable
class SwitchCase extends StatefulWidget {
  SwitchCase(
      {super.key,
      required this.id,
      required this.colr,
      required this.textcolor});
  int id;
  Color colr;
  Color textcolor;
  @override
  State<SwitchCase> createState() => _SwitchCaseState();
}

class _SwitchCaseState extends State<SwitchCase> {
  // bool favorite= false;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: (checkFavourite(widget.id, BuildContext))
          ? const Icon(
              Icons.favorite_border,
              color: Color(0xFF879AFB),
            )
          : const Icon(
              Icons.favorite,
              color: Color(0xFF879AFB),
            ),
      onPressed: () {
        addFavourites(widget.id, context, widget.colr, widget.textcolor);
        setState(() {});
      },
    );
  }
}
