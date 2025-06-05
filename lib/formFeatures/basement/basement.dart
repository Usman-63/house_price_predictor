import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/dropdownwidget.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/form_functions.dart';
import 'package:house_price_predictor/formFeatures/textfieldwidget.dart';
import 'package:house_price_predictor/formFeatures/basement/basement_info.dart';
import 'package:house_price_predictor/template.dart';

class Basement extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool) onValidationChanged;
  const Basement({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<Basement> createState() => _BasementState();
}

class _BasementState extends State<Basement> {
  bool get isNoBasement => foundationDisplay == "Slab Foundation";
  // Dropdown display values
  String? foundationDisplay;
  String? bsmtQualDisplay;
  String? bsmtCondDisplay;
  String? bsmtExposureDisplay;
  String? bsmtFinType1Display;
  String? bsmtFinType2Display;

  // Controllers for text fields
  final bsmtFinSF1Controller = TextEditingController();
  final bsmtFinSF2Controller = TextEditingController();
  final bsmtUnfSFController = TextEditingController();
  final totalBsmtSFController = TextEditingController();
  final bsmtFullBathController = TextEditingController();
  final bsmtHalfBathController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bsmtFinSF1Controller.text = modelInputTemplate['BsmtFin SF 1'] ?? '';
    bsmtFinSF2Controller.text = modelInputTemplate['BsmtFin SF 2'] ?? '';
    bsmtUnfSFController.text = modelInputTemplate['Bsmt Unf SF'] ?? '';
    totalBsmtSFController.text = modelInputTemplate['Total Bsmt SF'] ?? '';
    bsmtFullBathController.text = modelInputTemplate['Bsmt Full Bath'] ?? '';
    bsmtHalfBathController.text = modelInputTemplate['Bsmt Half Bath'] ?? '';

    foundationDisplay = getDisplayKey(
      "Foundation",
      modelInputTemplate["Foundation"],
      {"Foundation": foundationOptions},
    );

    bsmtQualDisplay = getDisplayKey(
      "Bsmt Qual",
      modelInputTemplate["Bsmt Qual"],
      {"Bsmt Qual": bsmtQualOptions},
    );

    bsmtCondDisplay = getDisplayKey(
      "Bsmt Cond",
      modelInputTemplate["Bsmt Cond"],
      {"Bsmt Cond": bsmtCondOptions},
    );

    bsmtExposureDisplay = getDisplayKey(
      "Bsmt Exposure",
      modelInputTemplate["Bsmt Exposure"],
      {"Bsmt Exposure": bsmtExposureOptions},
    );

    bsmtFinType1Display = getDisplayKey(
      "BsmtFin Type 1",
      modelInputTemplate["BsmtFin Type 1"],
      {"BsmtFin Type 1": bsmtFinType1Options},
    );

    bsmtFinType2Display = getDisplayKey(
      "BsmtFin Type 2",
      modelInputTemplate["BsmtFin Type 2"],
      {"BsmtFin Type 2": bsmtFinType2Options},
    );

    if (modelInputTemplate['Foundation'] ==
        foundationOptions["Slab Foundation"]) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setNoBasement();
      });
    }
  }

  void _updateTotalBsmtSF() {
    final fin1 = int.tryParse(bsmtFinSF1Controller.text) ?? 0;
    final fin2 = int.tryParse(bsmtFinSF2Controller.text) ?? 0;
    final unf = int.tryParse(bsmtUnfSFController.text) ?? 0;
    final total = fin1 + fin2 + unf;
    totalBsmtSFController.text = total.toString();
    modelInputTemplate['Total Bsmt SF'] = total.toString();
  }

  @override
  void dispose() {
    bsmtFinSF1Controller.dispose();
    bsmtFinSF2Controller.dispose();
    bsmtUnfSFController.dispose();
    totalBsmtSFController.dispose();
    bsmtFullBathController.dispose();
    bsmtHalfBathController.dispose();
    super.dispose();
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
                  "Basement",
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

              Dropdownwidget(
                label: "Foundation",
                hint: "Select Foundation",
                icon: Icons.foundation,
                value:
                    foundationDisplay ??
                    getDisplayKey(
                      "Foundation",
                      modelInputTemplate['Foundation'],
                      {'Foundation': foundationOptions},
                    ),
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                featuremap: {'Foundation': foundationOptions},
                onChanged: (val) {
                  if (val == "Slab Foundation") {
                    _setNoBasement();

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _validate();
                    });
                  } else {
                    setState(() {
                      foundationDisplay = val;
                      modelInputTemplate["Foundation"] = foundationOptions[val];
                      _validate();
                    });
                  }
                },
              ),
              const SizedBox(height: 25),
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "Bsmt Qual",
                      icon: Icons.grade,
                      hint: "Basement Quality",
                      enabled: !isNoBasement,
                      value:
                          bsmtQualDisplay ??
                          getDisplayKey(
                            "Bsmt Qual",
                            modelInputTemplate['Bsmt Qual'],
                            {'Bsmt Qual': bsmtQualOptions},
                          ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        if (!isNoBasement && val == "No Basement") {
                          return "Select a valid value (No Basement only allowed for Slab Foundation)";
                        }
                        return null;
                      },
                      featuremap: {'Bsmt Qual': bsmtQualOptions},
                      onChanged: (val) {
                        setState(() {
                          bsmtQualDisplay = val;
                          modelInputTemplate["Bsmt Qual"] =
                              bsmtQualOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Bsmt Cond",
                      icon: Icons.check_circle,
                      hint: "Basement Condition",
                      enabled: !isNoBasement,
                      value:
                          bsmtCondDisplay ??
                          getDisplayKey(
                            "Bsmt Cond",
                            modelInputTemplate['Bsmt Cond'],
                            {'Bsmt Cond': bsmtCondOptions},
                          ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        if (!isNoBasement && val == "No Basement") {
                          return "Select a valid value (No Basement only allowed for Slab Foundation)";
                        }
                        return null;
                      },
                      featuremap: {'Bsmt Cond': bsmtCondOptions},
                      onChanged: (val) {
                        setState(() {
                          bsmtCondDisplay = val;
                          modelInputTemplate["Bsmt Cond"] =
                              bsmtCondOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              Dropdownwidget(
                label: "Bsmt Exposure",
                icon: Icons.wb_sunny,
                hint: "Basement Exposure",
                enabled: !isNoBasement,
                value:
                    bsmtExposureDisplay ??
                    getDisplayKey(
                      "Bsmt Exposure",
                      modelInputTemplate['Bsmt Exposure'],
                      {'Bsmt Exposure': bsmtExposureOptions},
                    ),
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  if (!isNoBasement && val == "No Basement") {
                    return "Select a valid value (No Basement only allowed for Slab Foundation)";
                  }
                  return null;
                },
                featuremap: {'Bsmt Exposure': bsmtExposureOptions},
                onChanged: (val) {
                  setState(() {
                    bsmtExposureDisplay = val;
                    modelInputTemplate["Bsmt Exposure"] =
                        bsmtExposureOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 25),

              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "BsmtFin Type 1",
                      hint: "Basement Finished type 1",
                      icon: Icons.looks_one,
                      enabled: !isNoBasement,
                      value:
                          bsmtFinType1Display ??
                          getDisplayKey(
                            "BsmtFin Type 1",
                            modelInputTemplate['BsmtFin Type 1'],
                            {'BsmtFin Type 1': bsmtFinType1Options},
                          ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        if (!isNoBasement && val == "No Basement") {
                          return "Select a valid value (No Basement only allowed for Slab Foundation)";
                        }
                        return null;
                      },
                      featuremap: {'BsmtFin Type 1': bsmtFinType1Options},
                      onChanged: (val) {
                        setState(() {
                          bsmtFinType1Display = val;
                          modelInputTemplate["BsmtFin Type 1"] =
                              bsmtFinType1Options[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: Textfieldwidget(
                      label: "BsmtFin SF 1",
                      hint: "Basement Finished Square Foot",
                      icon: Icons.square_foot,
                      enabled: !isNoBasement,
                      keyboardType: TextInputType.number,
                      controller: bsmtFinSF1Controller,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if ((num < 300 || num > 2500) && !isNoBasement) {
                          return "Enter a value between 300 and 2500";
                        }
                        return null;
                      },
                      isRequired: true,
                      onChanged: (val) {
                        modelInputTemplate['BsmtFin SF 1'] = val;
                        _updateTotalBsmtSF();
                        _validate();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "BsmtFin Type 2",
                      hint: "Basement Finished Type 2",
                      icon: Icons.looks_two,
                      enabled: !isNoBasement,
                      value:
                          bsmtFinType2Display ??
                          getDisplayKey(
                            "BsmtFin Type 2",
                            modelInputTemplate['BsmtFin Type 2'],
                            {'BsmtFin Type 2': bsmtFinType2Options},
                          ),
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        if (!isNoBasement && val == "No Basement") {
                          return "Select a valid value (No Basement only allowed for Slab Foundation)";
                        }
                        return null;
                      },
                      featuremap: {'BsmtFin Type 2': bsmtFinType2Options},
                      onChanged: (val) {
                        setState(() {
                          bsmtFinType2Display = val;
                          modelInputTemplate["BsmtFin Type 2"] =
                              bsmtFinType2Options[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Textfieldwidget(
                      label: "BsmtFin SF 2",
                      hint: "Basement Finished Square Foot",
                      icon: Icons.square_foot,
                      enabled: !isNoBasement,
                      keyboardType: TextInputType.number,
                      controller: bsmtFinSF2Controller,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if ((num < 300 || num > 2500) && !isNoBasement) {
                          return "Enter a value between 300 and 2500";
                        }
                        return null;
                      },
                      isRequired: true,
                      onChanged: (val) {
                        modelInputTemplate['BsmtFin SF 2'] = val;
                        _updateTotalBsmtSF();
                        _validate();
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),

              // Text fields
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Textfieldwidget(
                      label: "Bsmt Unf SF",
                      hint: "Basement Unfinished square foot",
                      icon: Icons.square_foot,
                      enabled: !isNoBasement,
                      keyboardType: TextInputType.number,
                      controller: bsmtUnfSFController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if ((num < 0 || num > 2500) && !isNoBasement) {
                          return "Enter a value between 0 and 2500";
                        }
                        return null;
                      },
                      isRequired: true,
                      onChanged: (val) {
                        modelInputTemplate['Bsmt Unf SF'] = val;
                        _updateTotalBsmtSF();
                        _validate();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: Textfieldwidget(
                      label: "Total Bsmt SF",
                      hint: "total Basement Square footage",
                      icon: Icons.square_foot,
                      enabled: false,
                      controller: totalBsmtSFController,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Textfieldwidget(
                      label: "Bsmt Full Bath",
                      icon: Icons.bathtub,
                      enabled: !isNoBasement,
                      keyboardType: TextInputType.number,
                      controller: bsmtFullBathController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if ((num < 0 || num > 1600) && !isNoBasement) {
                          return "Enter a value between 0 and 1600";
                        }
                        return null;
                      },
                      isRequired: true,
                      onChanged: (val) {
                        modelInputTemplate['Bsmt Full Bath'] = val;
                        _validate();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),

                  Expanded(
                    child: Textfieldwidget(
                      label: "Bsmt Half Bath",
                      icon: Icons.bathtub_outlined,
                      enabled: !isNoBasement,
                      keyboardType: TextInputType.number,
                      controller: bsmtHalfBathController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if ((num < 0 || num > 1600) && !isNoBasement) {
                          return "Enter a value between 0 and 1600";
                        }
                        return null;
                      },
                      isRequired: true,
                      onChanged: (val) {
                        modelInputTemplate['Bsmt Half Bath'] = val;
                        _validate();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _setNoBasement() {
    setState(() {
      // Dropdowns
      foundationDisplay = "Slab Foundation";
      bsmtQualDisplay = "No Basement";
      bsmtCondDisplay = "No Basement";
      bsmtExposureDisplay = "No Basement";
      bsmtFinType1Display = "No Basement";
      bsmtFinType2Display = "No Basement";
      // Text fields
      bsmtFinSF1Controller.text = "0";
      bsmtFinSF2Controller.text = "0";
      bsmtUnfSFController.text = "0";
      totalBsmtSFController.text = "0";
      bsmtFullBathController.text = "0";
      bsmtHalfBathController.text = "0";
      // Model
      modelInputTemplate['Foundation'] = foundationOptions["Slab Foundation"];
      modelInputTemplate['Bsmt Qual'] = bsmtQualOptions["No Basement"];
      modelInputTemplate['Bsmt Cond'] = bsmtCondOptions["No Basement"];
      modelInputTemplate['Bsmt Exposure'] = bsmtExposureOptions["No Basement"];
      modelInputTemplate['BsmtFin Type 1'] = bsmtFinType1Options["No Basement"];
      modelInputTemplate['BsmtFin Type 2'] = bsmtFinType2Options["No Basement"];
      modelInputTemplate['BsmtFin SF 1'] = "0";
      modelInputTemplate['BsmtFin SF 2'] = "0";
      modelInputTemplate['Bsmt Unf SF'] = "0";
      modelInputTemplate['Total Bsmt SF'] = "0";
      modelInputTemplate['Bsmt Full Bath'] = "0";
      modelInputTemplate['Bsmt Half Bath'] = "0";
      _validate();
    });
  }
}
