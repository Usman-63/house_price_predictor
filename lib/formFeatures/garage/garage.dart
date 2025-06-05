import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/form_functions.dart';
import 'package:house_price_predictor/formFeatures/textfieldwidget.dart';
import 'package:house_price_predictor/formFeatures/dropdownwidget.dart';
import 'package:house_price_predictor/formFeatures/garage/garage_info.dart';
import 'package:house_price_predictor/template.dart';

class Garage extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool)
  onValidationChanged; // Pass house year built for fallback
  const Garage({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<Garage> createState() => _GarageState();
}

class _GarageState extends State<Garage> {
  final garageCarsController = TextEditingController();
  final garageAreaController = TextEditingController();
  final garageYrBltController = TextEditingController();
  final fireplacesController = TextEditingController();

  String? fireplaceQuValue;
  String? garageTypeValue;
  String? garageFinishValue;
  String? garageQualValue;
  String? garageCondValue;
  String? pavedDriveValue;

  int get garageCars => int.tryParse(garageCarsController.text) ?? 0;
  int get fireplaces => int.tryParse(fireplacesController.text) ?? 0;

  int get garageArea => int.tryParse(garageAreaController.text) ?? 0;
  bool get noGarage => garageArea == 0;

  bool get noFireplace => fireplaces == 0;

  @override
  void initState() {
    super.initState();
    garageCarsController.text = modelInputTemplate["Garage Cars"] ?? "";
    garageAreaController.text = modelInputTemplate["Garage Area"] ?? "";
    fireplacesController.text = modelInputTemplate["Fireplaces"] ?? "";
    garageYrBltController.text = modelInputTemplate["Garage Yr Blt"] ?? "";

    fireplaceQuValue = getDisplayKey(
      "Fireplace Qu",
      modelInputTemplate["Fireplace Qu"],
      {"Fireplace Qu": fireplaceQuOptions},
    );
    garageTypeValue = getDisplayKey(
      "Garage Type",
      modelInputTemplate["Garage Type"],
      {"Garage Type": garageTypeOptions},
    );
    garageFinishValue = getDisplayKey(
      "Garage Finish",
      modelInputTemplate["Garage Finish"],
      {"Garage Finish": garageFinishOptions},
    );
    garageQualValue = getDisplayKey(
      "Garage Qual",
      modelInputTemplate["Garage Qual"],
      {"Garage Qual": garageQualOptions},
    );
    garageCondValue = getDisplayKey(
      "Garage Cond",
      modelInputTemplate["Garage Cond"],
      {"Garage Cond": garageCondOptions},
    );
    pavedDriveValue = getDisplayKey(
      "Paved Drive",
      modelInputTemplate["Paved Drive"],
      {"Paved Drive": pavedDriveOptions},
    );
  }

  @override
  void dispose() {
    garageCarsController.dispose();
    garageAreaController.dispose();
    garageYrBltController.dispose();
    fireplacesController.dispose();
    super.dispose();
  }

  void _validate() {
    final isValid = widget.formKey.currentState?.validate() ?? false;
    widget.onValidationChanged(isValid);
  }

  void _handleFireplacesChange(String val) {
    modelInputTemplate['Fireplaces'] = val;
    if (val == "0") {
      setState(() {
        fireplaceQuValue = "No Fireplace";
        modelInputTemplate["Fireplace Qu"] = fireplaceQuOptions["No Fireplace"];
      });
    }
    _validate();
  }

  void _handleGarageAreaChange(String val) {
    modelInputTemplate['Garage Area'] = val;
    if (val == "0") {
      setState(() {
        garageCarsController.text = "0";
        garageTypeValue = "No Garage";
        garageFinishValue = "No Garage";
        garageQualValue = "No Garage";
        garageCondValue = "No Garage";
        pavedDriveValue = "Gravel/None";
        garageYrBltController.text =
            modelInputTemplate["Year Built"].toString();

        modelInputTemplate["Garage Cars"] = "0";
        modelInputTemplate["Garage Type"] = garageTypeOptions["No Garage"];
        modelInputTemplate["Garage Finish"] = garageFinishOptions["No Garage"];
        modelInputTemplate["Garage Qual"] = garageQualOptions["No Garage"];
        modelInputTemplate["Garage Cond"] = garageCondOptions["No Garage"];
        modelInputTemplate["Garage Yr Blt"] =
            modelInputTemplate["Year Built"].toString();
        ;
        modelInputTemplate["Paved Drive"] = "Gravel/None";
      });
    }
    _validate();
  }

  @override
  Widget build(BuildContext context) {
    return FormCard(
      child: Form(
        key: widget.formKey,
        onChanged: _validate,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Garage & Fireplaces",
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

              // Fireplaces
              Row(
                children: [
                  Expanded(
                    child: Textfieldwidget(
                      label: "Fireplaces",
                      hint: "Number of Fireplaces (0+)",
                      icon: Icons.fireplace,
                      keyboardType: TextInputType.number,
                      controller: fireplacesController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 0 || num > 5)
                          return "Enter a value between 0 and 5";
                        return null;
                      },
                      onChanged: _handleFireplacesChange,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Fireplace Qu",
                      hint: "Fireplace Quality",
                      icon: Icons.whatshot,
                      value:
                          fireplaceQuValue ??
                          getDisplayKey(
                            "Fireplace Qu",
                            modelInputTemplate["Fireplace Qu"],
                            {"Fireplace Qu": fireplaceQuOptions},
                          ),
                      featuremap: {"Fireplace Qu": fireplaceQuOptions},
                      enabled: !noFireplace,
                      validator: (val) {
                        if (noFireplace) {
                          return null;
                        }
                        if (val == null || val.isEmpty) return "Required";
                        if (val == "No Fireplace" && !noFireplace) {
                          return "Select a valid value";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          fireplaceQuValue = val;
                          modelInputTemplate["Fireplace Qu"] =
                              fireplaceQuOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: Textfieldwidget(
                      label: "Garage Area",
                      hint: "Garage Area (200 - 1500 sq ft)",
                      icon: Icons.square_foot,
                      keyboardType: TextInputType.number,
                      controller: garageAreaController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if ((num < 200 || num > 1500) && num != 0)
                          return "Enter a value between 200 and 1500";
                        return null;
                      },
                      onChanged: _handleGarageAreaChange,
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Textfieldwidget(
                      label: "Garage Cars",
                      hint: "Number of Cars (0 - 6)",
                      icon: Icons.directions_car,
                      keyboardType: TextInputType.number,
                      controller: garageCarsController,
                      enabled: !noGarage,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 0 || num > 6)
                          return "Enter a value between 0 and 6";
                        return null;
                      },
                      onChanged: (val) {
                        modelInputTemplate['Garage Cars'] = val;
                        _validate();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: garageYrBltController,
                readOnly: true,
                enabled: !noGarage,
                decoration: InputDecoration(
                  labelText: "Garage Yr Blt",
                  hintText: "Year Garage Built (or Year Built if no garage)",
                  prefixIcon: Icon(
                    Icons.calendar_today,
                    color: Theme.of(context).primaryColor,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor.withOpacity(0.5),
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Theme.of(context).primaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.red, width: 1.5),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.redAccent, width: 2),
                  ),
                  fillColor: Colors.grey[50],
                  filled: true,
                ),
                validator: (val) {
                  if (noGarage) return null;
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid year";
                  if (num < 1800 || num > DateTime.now().year)
                    return "Enter a valid year";
                  return null;
                },
                onTap:
                    !noGarage
                        ? () async {
                          await _pickYear(
                            context: context,
                            controller: garageYrBltController,
                            firstYear: int.parse(
                              modelInputTemplate["Year Built"].toString(),
                            ),
                            lastYear: DateTime.now().year,
                            onChanged: () {
                              modelInputTemplate["Garage Yr Blt"] =
                                  garageYrBltController.text;
                              _validate();
                            },
                          );
                        }
                        : null,
              ),
              const SizedBox(height: 20),

              // Garage Type & Finish
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "Garage Type",
                      hint: "Garage Type",
                      icon: Icons.garage,
                      value:
                          garageTypeValue ??
                          getDisplayKey(
                            "Garage Type",
                            modelInputTemplate["Garage Type"],
                            {"Garage Type": garageTypeOptions},
                          ),
                      featuremap: {"Garage Type": garageTypeOptions},
                      enabled: !noGarage,
                      validator: (val) {
                        if (noGarage) return null;
                        if (val == null || val.isEmpty) return "Required";
                        if (val == "No Garage" && !noGarage) {
                          return "Select a valid value";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          garageTypeValue = val;
                          modelInputTemplate["Garage Type"] =
                              garageTypeOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Garage Finish",
                      hint: "Garage Finish",
                      icon: Icons.build,
                      value:
                          garageFinishValue ??
                          getDisplayKey(
                            "Garage Finish",
                            modelInputTemplate["Garage Finish"],
                            {"Garage Finish": garageFinishOptions},
                          ),
                      featuremap: {"Garage Finish": garageFinishOptions},
                      enabled: !noGarage,
                      validator: (val) {
                        if (noGarage) return null;
                        if (val == null || val.isEmpty) return "Required";
                        if (val == "No Garage" && !noGarage) {
                          return "Select a valid value";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          garageFinishValue = val;
                          modelInputTemplate["Garage Finish"] =
                              garageFinishOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Garage Qual & Cond
              Row(
                children: [
                  Expanded(
                    child: Dropdownwidget(
                      label: "Garage Qual",
                      hint: "Garage Quality",
                      icon: Icons.grade,
                      value:
                          garageQualValue ??
                          getDisplayKey(
                            "Garage Qual",
                            modelInputTemplate["Garage Qual"],
                            {"Garage Qual": garageQualOptions},
                          ),
                      featuremap: {"Garage Qual": garageQualOptions},
                      enabled: !noGarage,
                      validator: (val) {
                        if (noGarage) return null;
                        if (val == null || val.isEmpty) return "Required";
                        if (val == "No Garage" && !noGarage) {
                          return "Select a valid value";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          garageQualValue = val;
                          modelInputTemplate["Garage Qual"] =
                              garageQualOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Garage Cond",
                      hint: "Garage Condition",
                      icon: Icons.check_circle,
                      value:
                          garageCondValue ??
                          getDisplayKey(
                            "Garage Cond",
                            modelInputTemplate["Garage Cond"],
                            {"Garage Cond": garageCondOptions},
                          ),
                      featuremap: {"Garage Cond": garageCondOptions},
                      enabled: !noGarage,
                      validator: (val) {
                        if (noGarage) return null;
                        if (val == null || val.isEmpty) return "Required";
                        if (val == "No Garage" && !noGarage) {
                          return "Select a valid value";
                        }
                        return null;
                      },
                      onChanged: (val) {
                        setState(() {
                          garageCondValue = val;
                          modelInputTemplate["Garage Cond"] =
                              garageCondOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Paved Drive
              Dropdownwidget(
                label: "Paved Drive",
                hint: "Paved Driveway",
                icon: Icons.streetview,
                value:
                    pavedDriveValue ??
                    getDisplayKey(
                      "Paved Drive",
                      modelInputTemplate["Paved Drive"],
                      {"Paved Drive": pavedDriveOptions},
                    ),
                featuremap: {"Paved Drive": pavedDriveOptions},
                enabled: !noGarage,
                validator: (val) {
                  if (noGarage) return null;
                  if (val == null || val.isEmpty) return "Required";
                  return null;
                },
                onChanged: (val) {
                  setState(() {
                    pavedDriveValue = val;
                    modelInputTemplate["Paved Drive"] = pavedDriveOptions[val];
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

  Future<void> _pickYear({
    required BuildContext context,
    required TextEditingController controller,
    int? firstYear,
    int? lastYear,
    VoidCallback? onChanged,
  }) async {
    final now = DateTime.now();
    final initialYear =
        int.tryParse(controller.text) ?? (firstYear ?? now.year);
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(initialYear),
      firstDate: DateTime(firstYear ?? 1900),
      lastDate: DateTime(lastYear ?? now.year),
      helpText: 'Select Year',
      fieldLabelText: 'Year',
      fieldHintText: 'Year',
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context, child) => child!,
    );
    if (picked != null) {
      controller.text = picked.year.toString();
      if (onChanged != null) onChanged();
      setState(() {});
    }
  }
}
