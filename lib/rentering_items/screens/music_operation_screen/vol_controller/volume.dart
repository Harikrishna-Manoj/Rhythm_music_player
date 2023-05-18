import 'package:flutter/material.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';

import '../../../styles_images/utils.dart';

class VolumeController extends StatefulWidget {
  const VolumeController({super.key});

  @override
  State<VolumeController> createState() => _VolumeControllerState();
}

class _VolumeControllerState extends State<VolumeController> {
  double currentValue = 0.5;
  @override
  void initState() {
    PerfectVolumeControl.hideUI = false;
    Future.delayed(Duration.zero, () async {
      currentValue = await PerfectVolumeControl.getVolume();
      setState(() {});
    });
    PerfectVolumeControl.stream.listen((volume) {
      setState(() {
        currentValue = volume;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF879AFB),
      width: 80,
      height: 100,
      child: Column(
        children: [
          Center(
            child: Text(
              'Volume',
              style: safeGoogleFont('Poppins',
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 17),
            ),
          ),
          Slider(
            value: currentValue,
            inactiveColor: const Color.fromRGBO(217, 217, 217, 1),
            thumbColor: const Color.fromARGB(255, 154, 165, 220),
            activeColor: const Color.fromARGB(255, 55, 68, 135),
            onChanged: (volume) {
              currentValue = volume;
              PerfectVolumeControl.setVolume(volume);
              setState(() {});
            },
            min: 0,
            max: 1,
            divisions: 100,
          )
        ],
      ),
    );
  }
}
