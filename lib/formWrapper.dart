import 'package:flutter/material.dart';
import 'package:house_price_predictor/formPage.dart';
import 'package:house_price_predictor/starterTile.dart';

class FormWrapper extends StatefulWidget {
  const FormWrapper({super.key});

  @override
  State<FormWrapper> createState() => _FormWrapperState();
}

class _FormWrapperState extends State<FormWrapper> {
  bool _starter = true;
  _changeStarter() {
    setState(() {
      _starter = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        FormHandler(),
        _starter ? StarterCard(function: _changeStarter) : Container(),
      ],
    );
  }
}
