import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/dropdownwidget.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/form_functions.dart';
import 'package:house_price_predictor/formFeatures/generalinfo/general_info.dart';
import 'package:house_price_predictor/formFeatures/textfieldwidget.dart';
import 'package:house_price_predictor/template.dart';

class Generalinfo extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool) onValidationChanged;

  const Generalinfo({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<Generalinfo> createState() => _GeneralinfoState();
}

class _GeneralinfoState extends State<Generalinfo> {
  // Example controllers/values for fields
  String? lotAreaDisplay;
  String? lotFrontageDisplay;
  String? msSubClassDisplay;
  String? msZoningDisplay;
  String? streetDisplay;
  String? landContourDisplay;
  String? lotConfigDisplay;
  String? utilitiesDisplay;
  String? lotShapeDisplay;
  String? landSlopeDisplay;
  final TextEditingController lotAreaController = TextEditingController();
  final TextEditingController lotFrontageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    lotAreaController.text = modelInputTemplate['Lot Area'] ?? '';
    lotFrontageController.text = modelInputTemplate['Lot Frontage'] ?? '';

    msSubClassDisplay = getDisplayKey(
      'MS SubClass',
      modelInputTemplate['MS SubClass'],
      generalFeatureMap,
    );

    msZoningDisplay = getDisplayKey(
      'MS Zoning',
      modelInputTemplate['MS Zoning'],
      generalFeatureMap,
    );

    streetDisplay = getDisplayKey(
      'Street',
      modelInputTemplate['Street'],
      generalFeatureMap,
    );

    lotShapeDisplay = getDisplayKey(
      'Lot Shape',
      modelInputTemplate['Lot Shape'],
      generalFeatureMap,
    );

    landContourDisplay = getDisplayKey(
      'Land Contour',
      modelInputTemplate['Land Contour'],
      generalFeatureMap,
    );

    lotConfigDisplay = getDisplayKey(
      'Lot Config',
      modelInputTemplate['Lot Config'],
      generalFeatureMap,
    );

    landSlopeDisplay = getDisplayKey(
      'Land Slope',
      modelInputTemplate['Land Slope'],
      generalFeatureMap,
    );

    utilitiesDisplay = getDisplayKey(
      'Utilities',
      modelInputTemplate['Utilities'],
      generalFeatureMap,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    lotAreaController.dispose();
    lotFrontageController.dispose();
  }

  void _validate() {
    final isValid = widget.formKey.currentState?.validate() ?? false;
    widget.onValidationChanged(isValid);
  }

  @override
  Widget build(BuildContext context) {
    return FormCard(
      child: Form(
        key: widget.formKey,
        onChanged: _validate,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "General Information",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: "comfortaa",
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Divider(thickness: 1.5),
              const SizedBox(height: 30),
              Textfieldwidget(
                label: "Lot Area (sq ft)",
                icon: Icons.square_foot,
                hint: "Enter lot area in square feet (5000 - 15000)",
                keyboardType: TextInputType.number,
                controller: lotAreaController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 5000 || num > 15000)
                    return "Enter a value between 5000 and 15000";
                  return null;
                },
                isRequired: true,
                onChanged: (val) {
                  modelInputTemplate['Lot Area'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 25),
              Textfieldwidget(
                label: "Lot Frontage (in feet)",
                hint: "Enter lot frontage in feet (40 - 200)",
                icon: Icons.square_foot,
                isRequired: true,
                controller: lotFrontageController,
                keyboardType: TextInputType.number,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 40 || num > 200)
                    return "Enter a value between 40 and 200";
                  return null;
                },
                onChanged: (val) {
                  lotFrontageDisplay = val;
                  modelInputTemplate['Lot Frontage'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "MS SubClass",
                      hint: "Select building class",
                      icon: Icons.home,
                      value: msSubClassDisplay,
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      featuremap: generalFeatureMap,
                      onChanged: (val) {
                        msSubClassDisplay = val;
                        modelInputTemplate['MS SubClass'] =
                            generalFeatureMap['MS SubClass']![val];
                        _validate();
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "MS Zoning",
                      hint: "Select zoning classification",
                      icon: Icons.location_city,
                      value: msZoningDisplay,
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      featuremap: generalFeatureMap,
                      onChanged: (val) {
                        msZoningDisplay = val;
                        modelInputTemplate['MS Zoning'] =
                            generalFeatureMap['MS Zoning']![val];

                        _validate();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "Street",
                      hint: "Select street type",
                      icon: Icons.streetview,
                      value: streetDisplay,
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      featuremap: generalFeatureMap,
                      onChanged: (val) {
                        streetDisplay = val;
                        modelInputTemplate['Street'] =
                            generalFeatureMap['Street']![val];
                        _validate();
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Lot Shape",
                      hint: "Select lot shape",
                      icon: Icons.crop_square,
                      value: lotShapeDisplay,
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      featuremap: generalFeatureMap,
                      onChanged: (val) {
                        lotShapeDisplay = val;
                        modelInputTemplate['Lot Shape'] =
                            generalFeatureMap['Lot Shape']![val];

                        _validate();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "Land Contour",
                      hint: "Select land contour",
                      icon: Icons.map,
                      value: landContourDisplay,
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      featuremap: generalFeatureMap,
                      onChanged: (val) {
                        landContourDisplay = val;
                        modelInputTemplate['Land Contour'] =
                            generalFeatureMap['Land Contour']![val];
                        _validate();
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Lot Config",
                      hint: "Select lot configuration",
                      icon: Icons.location_on,
                      value: lotConfigDisplay,
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      featuremap: generalFeatureMap,
                      onChanged: (val) {
                        lotConfigDisplay = val;
                        modelInputTemplate['Lot Config'] =
                            generalFeatureMap['Lot Config']![val];

                        _validate();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "Land Slope",
                      hint: "Select land slope",
                      icon: Icons.landscape,

                      value: landSlopeDisplay,
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      featuremap: generalFeatureMap,
                      onChanged: (val) {
                        landSlopeDisplay = val;
                        modelInputTemplate['Land Slope'] =
                            generalFeatureMap['Land Slope']![val];
                        _validate();
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Utilities",
                      hint: "Select utility type",
                      icon: Icons.build,
                      value: utilitiesDisplay,
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      featuremap: generalFeatureMap,
                      onChanged: (val) {
                        utilitiesDisplay = val;
                        modelInputTemplate['Utilities'] =
                            generalFeatureMap['Utilities']![val];

                        _validate();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
