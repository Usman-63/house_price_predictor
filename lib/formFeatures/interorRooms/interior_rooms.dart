import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/form_functions.dart';
import 'package:house_price_predictor/formFeatures/textfieldwidget.dart';
import 'package:house_price_predictor/formFeatures/dropdownwidget.dart';
import 'package:house_price_predictor/formFeatures/interorRooms/interior_info.dart';
import 'package:house_price_predictor/template.dart';

class InteriorRooms extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool) onValidationChanged;
  const InteriorRooms({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<InteriorRooms> createState() => _InteriorRoomsState();
}

class _InteriorRoomsState extends State<InteriorRooms> {
  final firstFlrController = TextEditingController();
  final secondFlrController = TextEditingController();
  final lowQualFinController = TextEditingController();
  final grLivAreaController = TextEditingController();
  final fullBathController = TextEditingController();
  final halfBathController = TextEditingController();
  final bedroomController = TextEditingController();
  final kitchenController = TextEditingController();
  final totRmsController = TextEditingController();

  String? functionalValue;
  String? kitchenQualValue;
  void _validate() {
    final isValid = widget.formKey.currentState?.validate() ?? false;
    widget.onValidationChanged(isValid);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firstFlrController.text = modelInputTemplate["1st Flr SF"] ?? "";
    secondFlrController.text = modelInputTemplate["2nd Flr SF"] ?? "";
    lowQualFinController.text = modelInputTemplate["Low Qual Fin SF"] ?? "";
    grLivAreaController.text = modelInputTemplate["Gr Liv Area"] ?? "";
    fullBathController.text = modelInputTemplate["Full Bath"] ?? "";
    halfBathController.text = modelInputTemplate["Half Bath"] ?? "";
    bedroomController.text = modelInputTemplate["Bedroom AbvGr"] ?? "";
    kitchenController.text = modelInputTemplate["Kitchen AbvGr"] ?? "";
    totRmsController.text = modelInputTemplate["TotRms AbvGrd"] ?? "";
  }

  @override
  void dispose() {
    firstFlrController.dispose();
    secondFlrController.dispose();
    lowQualFinController.dispose();
    grLivAreaController.dispose();
    fullBathController.dispose();
    halfBathController.dispose();
    bedroomController.dispose();
    kitchenController.dispose();
    totRmsController.dispose();
    super.dispose();
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
                  "Interior Rooms",
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
              Row(
                children: [
                  Expanded(
                    child: Textfieldwidget(
                      label: "1st Flr SF",
                      hint: "First Floor Square Footage (300 - 3000+)",
                      icon: Icons.home,
                      keyboardType: TextInputType.number,
                      controller: firstFlrController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 300 || num > 3000)
                          return "Enter a value between 300 and 3000";
                        return null;
                      },
                      onChanged: (val) {
                        modelInputTemplate['1st Flr SF'] = val;
                        _validate();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Textfieldwidget(
                      label: "2nd Flr SF",
                      hint: "Second Floor Square Footage (0 - 2000+)",
                      icon: Icons.home_work,
                      keyboardType: TextInputType.number,
                      controller: secondFlrController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 0 || num > 2000)
                          return "Enter a value between 0 and 2000";
                        return null;
                      },
                      onChanged: (val) {
                        modelInputTemplate['2nd Flr SF'] = val;
                        _validate();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Textfieldwidget(
                label: "Low Qual Fin SF",
                hint: "Low Quality Finished SF (0 - 100)",
                icon: Icons.low_priority,
                keyboardType: TextInputType.number,
                controller: lowQualFinController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 0 || num > 100)
                    return "Enter a value between 0 and 100";
                  return null;
                },
                onChanged: (val) {
                  modelInputTemplate['Low Qual Fin SF'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 20),
              Textfieldwidget(
                label: "Gr Liv Area",
                hint: "Above Ground Living Area (400 - 4000+)",
                icon: Icons.area_chart,
                keyboardType: TextInputType.number,
                controller: grLivAreaController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 400 || num > 4000)
                    return "Enter a value between 400 and 4000";
                  return null;
                },
                onChanged: (val) {
                  modelInputTemplate['Gr Liv Area'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Textfieldwidget(
                      label: "Full Bath",
                      hint: "Full Bathrooms Above Ground (0 - 4)",
                      icon: Icons.bathtub,
                      keyboardType: TextInputType.number,
                      controller: fullBathController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 0 || num > 4)
                          return "Enter a value between 0 and 4";
                        return null;
                      },
                      onChanged: (val) {
                        modelInputTemplate['Full Bath'] = val;
                        _validate();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Textfieldwidget(
                      label: "Half Bath",
                      hint: "Half Bathrooms Above Ground (0 - 2)",
                      icon: Icons.bathtub_outlined,
                      keyboardType: TextInputType.number,
                      controller: halfBathController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 0 || num > 2)
                          return "Enter a value between 0 and 2";
                        return null;
                      },
                      onChanged: (val) {
                        modelInputTemplate['Half Bath'] = val;
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
                    child: Textfieldwidget(
                      label: "Bedroom AbvGr",
                      hint: "Bedrooms Above Ground (0 - 8)",
                      icon: Icons.bed,
                      keyboardType: TextInputType.number,
                      controller: bedroomController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 0 || num > 8)
                          return "Enter a value between 0 and 8";
                        return null;
                      },
                      onChanged: (val) {
                        modelInputTemplate['Bedroom AbvGr'] = val;
                        _validate();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Textfieldwidget(
                      label: "TotRms AbvGrd",
                      hint: "Total Rooms Above Ground (2 - 15)",
                      icon: Icons.meeting_room,
                      keyboardType: TextInputType.number,
                      controller: totRmsController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 2 || num > 15)
                          return "Enter a value between 2 and 15";
                        return null;
                      },
                      onChanged: (val) {
                        modelInputTemplate['TotRms AbvGrd'] = val;
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
                    child: Textfieldwidget(
                      label: "Kitchen AbvGr",
                      hint: "Kitchens Above Ground (0 - 3)",
                      icon: Icons.kitchen,
                      keyboardType: TextInputType.number,
                      controller: kitchenController,
                      validator: (val) {
                        if (val == null || val.isEmpty) return "Required";
                        final num = int.tryParse(val);
                        if (num == null) return "Enter a valid number";
                        if (num < 0 || num > 3)
                          return "Enter a value between 0 and 3";
                        return null;
                      },
                      onChanged: (val) {
                        modelInputTemplate['Kitchen AbvGr'] = val;
                        _validate();
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Dropdownwidget(
                      label: "Kitchen Qual",
                      hint: "Kitchen Quality",
                      icon: Icons.restaurant,
                      value:
                          kitchenQualValue ??
                          getDisplayKey(
                            "Kitchen Qual",
                            modelInputTemplate['Kitchen Qual'],
                            {'Kitchen Qual': kitchenQualOptions},
                          ),
                      featuremap: {"Kitchen Qual": kitchenQualOptions},
                      validator:
                          (val) =>
                              val == null || val.isEmpty ? "Required" : null,
                      onChanged: (val) {
                        setState(() {
                          kitchenQualValue = val;
                          modelInputTemplate['Kitchen Qual'] =
                              kitchenQualOptions[val];
                          _validate();
                        });
                      },
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
              Dropdownwidget(
                label: "Functional",
                hint: "Home Functionality",
                icon: Icons.settings,
                value:
                    functionalValue ??
                    getDisplayKey(
                      "Functional",
                      modelInputTemplate['Functional'],
                      {'Functional': functionalOptions},
                    ),
                featuremap: {"Functional": functionalOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    functionalValue = val;
                    modelInputTemplate['Functional'] = functionalOptions[val];
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
