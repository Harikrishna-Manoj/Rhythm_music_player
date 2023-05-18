import 'package:flutter/material.dart';
import 'package:rythm1/rentering_items/screens/settings_screen/widgets/settings_widget.dart';

Column settingsItems(BuildContext context) {
  return Column(
    children: [
      settingsHeading('Settings'),
      settingsPrivacy(context),
      const SizedBox(height: 15),
      settingsTerms(context),
      const SizedBox(height: 15),
      settingsAbout(context),
      const SizedBox(height: 15),
      settingsShare(context),
      const SizedBox(height: 15),
      settingsExit(context),
      const SizedBox(height: 300),
      bottomVersion()
    ],
  );
}
