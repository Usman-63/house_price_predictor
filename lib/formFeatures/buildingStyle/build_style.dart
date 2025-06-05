import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/buildingStyle/date_picker.dart';
import 'package:house_price_predictor/formFeatures/dropdownwidget.dart';
import 'package:house_price_predictor/formFeatures/buildingStyle/buildstyle_info.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/form_functions.dart';
import 'package:house_price_predictor/template.dart';

class BuildStyle extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool) onValidationChanged;
  const BuildStyle({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<BuildStyle> createState() => _BuildStyleState();
}

class _BuildStyleState extends State<BuildStyle> {
  String? bldgTypeDisplay;
  String? houseStyleDisplay;
  String? overallQualDisplay;
  String? overallCondDisplay;

  final TextEditingController yearBuiltController = TextEditingController();
  final TextEditingController yearRemodController = TextEditingController();

  @override
  void initState() {
    super.initState();

    yearBuiltController.text =
        modelInputTemplate['Year Built']?.toString() ?? '';
    yearRemodController.text =
        modelInputTemplate['Year Remod/Add']?.toString() ?? '';

    bldgTypeDisplay = getDisplayKey(
      "Bldg Type",
      modelInputTemplate["Bldg Type"],
      {"Bldg Type": bldgTypeOptions},
    );

    houseStyleDisplay = getDisplayKey(
      "House Style",
      modelInputTemplate["House Style"],
      {"House Style": houseStyleOptions},
    );

    overallQualDisplay = getDisplayKey(
      "Overall Qual",
      modelInputTemplate["Overall Qual"],
      {"Overall Qual": overallQualOptions},
    );

    overallCondDisplay = getDisplayKey(
      "Overall Cond",
      modelInputTemplate["Overall Cond"],
      {"Overall Cond": overallCondOptions},
    );
  }

  @override
  void dispose() {
    yearBuiltController.dispose();
    yearRemodController.dispose();
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
                  "Building Style",
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
              DatePickerFile(
                yearBuiltController: yearBuiltController,
                yearRemodController: yearRemodController,
                validate: _validate,
              ),
              const SizedBox(height: 30),
              Dropdownwidget(
                label: "Bldg Type",
                hint: "Building Type",
                icon: Icons.apartment,
                value: bldgTypeDisplay,
                featuremap: {"Bldg Type": bldgTypeOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (value) {
                  setState(() {
                    bldgTypeDisplay = value;
                    modelInputTemplate["Bldg Type"] = bldgTypeOptions[value];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 30),
              Dropdownwidget(
                label: "House Style",
                hint: "House Style",
                icon: Icons.home_work,
                value: houseStyleDisplay,
                featuremap: {"House Style": houseStyleOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (value) {
                  setState(() {
                    houseStyleDisplay = value;
                    modelInputTemplate["House Style"] =
                        houseStyleOptions[value];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 30),
              Dropdownwidget(
                label: "Overall Qual",
                hint: "Overall Quality",
                icon: Icons.star,
                value: overallQualDisplay,
                featuremap: {"Overall Qual": overallQualOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (value) {
                  setState(() {
                    overallQualDisplay = value;
                    modelInputTemplate["Overall Qual"] =
                        overallQualOptions[value];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 30),
              Dropdownwidget(
                label: "Overall Cond",
                hint: "Overall Condition",
                icon: Icons.check_circle,
                value: overallCondDisplay,
                featuremap: {"Overall Cond": overallCondOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (value) {
                  setState(() {
                    overallCondDisplay = value;
                    modelInputTemplate["Overall Cond"] =
                        overallCondOptions[value];
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
