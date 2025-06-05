import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/dropdownwidget.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/form_functions.dart';
import 'package:house_price_predictor/formFeatures/roofAndExterior/roof_exterior_info.dart';
import 'package:house_price_predictor/formFeatures/textfieldwidget.dart';
import 'package:house_price_predictor/template.dart';

class RoofExterior extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool) onValidationChanged;
  const RoofExterior({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<RoofExterior> createState() => _RoofExteriorState();
}

class _RoofExteriorState extends State<RoofExterior> {
  String? roofStyleDisplay;
  String? roofMatlDisplay;
  String? exterior1stDisplay;
  String? exterior2ndDisplay;
  String? masVnrTypeDisplay;
  String? exterQualDisplay;
  String? exterCondDisplay;

  TextEditingController masVnrController = TextEditingController();

  @override
  void initState() {
    super.initState();

    masVnrController.text =
        modelInputTemplate['Mas Vnr Area']?.toString() ?? '';

    roofStyleDisplay = getDisplayKey(
      "Roof Style",
      modelInputTemplate["Roof Style"],
      {"Roof Style": roofStyleOptions},
    );

    roofMatlDisplay = getDisplayKey(
      "Roof Matl",
      modelInputTemplate["Roof Matl"],
      {"Roof Matl": roofMatlOptions},
    );

    exterior1stDisplay = getDisplayKey(
      "Exterior 1st",
      modelInputTemplate["Exterior 1st"],
      {"Exterior 1st": exterior1stOptions},
    );

    exterior2ndDisplay = getDisplayKey(
      "Exterior 2nd",
      modelInputTemplate["Exterior 2nd"],
      {"Exterior 2nd": exterior2ndOptions},
    );

    masVnrTypeDisplay = getDisplayKey(
      "Mas Vnr Type",
      modelInputTemplate["Mas Vnr Type"],
      {"Mas Vnr Type": masVnrTypeOptions},
    );

    exterQualDisplay = getDisplayKey(
      "Exter Qual",
      modelInputTemplate["Exter Qual"],
      {"Exter Qual": exterQualOptions},
    );

    exterCondDisplay = getDisplayKey(
      "Exter Cond",
      modelInputTemplate["Exter Cond"],
      {"Exter Cond": exterCondOptions},
    );
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
                  "Roof & Exterior",
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
                label: "Mas Vnr Area",
                hint: "Masonry Veneer Area (100 - 300 sq ft)",
                icon: Icons.square_foot,
                keyboardType: TextInputType.number,
                controller: masVnrController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if ((num < 100 || num > 300) && num != 0) {
                    return "Enter a value between 100 and 300";
                  }
                  return null;
                },
                isRequired: true,
                onChanged: (val) {
                  setState(() {
                    modelInputTemplate['Mas Vnr Area'] = val;
                    if (val == "0") {
                      masVnrTypeDisplay = "None";
                      modelInputTemplate["Mas Vnr Type"] =
                          masVnrTypeOptions["None"];
                    }
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 25),
              Dropdownwidget(
                label: "Mas Vnr Type",
                hint: "Select masonry veneer type",
                icon: Icons.account_balance,
                value: masVnrTypeDisplay,
                featuremap: {"Mas Vnr Type": masVnrTypeOptions},
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  if (masVnrController.text != "0" && val == "None") {
                    return "Select a valid value (Type cannot be None if Mas Vnr Area is greater than 0)";
                  }
                  return null;
                },
                onChanged:
                    masVnrController.text == "0"
                        ? null
                        : (val) {
                          setState(() {
                            masVnrTypeDisplay = val;
                            modelInputTemplate["Mas Vnr Type"] =
                                masVnrTypeOptions[val];
                            _validate();
                          });
                        },
              ),
              const SizedBox(height: 25),
              Dropdownwidget(
                label: "Roof Style",
                hint: "Select roof style",
                icon: Icons.roofing,
                value: roofStyleDisplay,
                featuremap: {"Roof Style": roofStyleOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    roofStyleDisplay = val;
                    modelInputTemplate["Roof Style"] = roofStyleOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 25),
              Dropdownwidget(
                label: "Roof Matl",
                hint: "Select roof material",
                icon: Icons.layers,
                value: roofMatlDisplay,
                featuremap: {"Roof Matl": roofMatlOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    roofMatlDisplay = val;
                    modelInputTemplate["Roof Matl"] = roofMatlOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "Exterior 1st",
                      hint: "Select primary exterior material",
                      icon: Icons.home,
                      value: exterior1stDisplay,
                      featuremap: {"Exterior 1st": exterior1stOptions},
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      onChanged: (val) {
                        setState(() {
                          exterior1stDisplay = val;
                          modelInputTemplate["Exterior 1st"] =
                              exterior1stOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Exterior 2nd",
                      hint: "Select secondary exterior material",
                      icon: Icons.home_outlined,
                      value: exterior2ndDisplay,
                      featuremap: {"Exterior 2nd": exterior2ndOptions},
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      onChanged: (val) {
                        setState(() {
                          exterior2ndDisplay = val;
                          modelInputTemplate["Exterior 2nd"] =
                              exterior2ndOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              Dropdownwidget(
                label: "Exter Qual",
                hint: "Select exterior quality",
                icon: Icons.grade,
                value: exterQualDisplay,
                featuremap: {"Exter Qual": exterQualOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    exterQualDisplay = val;
                    modelInputTemplate["Exter Qual"] = exterQualOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 25),
              Dropdownwidget(
                label: "Exter Cond",
                hint: "Select exterior condition",
                icon: Icons.check,
                value: exterCondDisplay,
                featuremap: {"Exter Cond": exterCondOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    exterCondDisplay = val;
                    modelInputTemplate["Exter Cond"] = exterCondOptions[val];
                    _validate();
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
