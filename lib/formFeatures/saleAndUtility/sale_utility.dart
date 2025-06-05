import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/dropdownwidget.dart';
import 'package:house_price_predictor/formFeatures/form_functions.dart';
import 'package:house_price_predictor/formFeatures/saleAndUtility/sale_utility_info.dart';
import 'package:house_price_predictor/template.dart';

class SaleUtility extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool) onValidationChanged;
  const SaleUtility({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<SaleUtility> createState() => _SaleUtilityState();
}

class _SaleUtilityState extends State<SaleUtility> {
  String? saleTypeDisplay;
  String? saleConditionDisplay;
  String? electricalDisplay;
  String? centralAirDisplay;
  String? heatingDisplay;
  String? heatingQCDisplay;

  @override
  void initState() {
    super.initState();

    saleTypeDisplay = getDisplayKey(
      "Sale Type",
      modelInputTemplate["Sale Type"],
      {"Sale Type": saleTypeOptions},
    );

    saleConditionDisplay = getDisplayKey(
      "Sale Condition",
      modelInputTemplate["Sale Condition"],
      {"Sale Condition": saleConditionOptions},
    );

    electricalDisplay = getDisplayKey(
      "Electrical",
      modelInputTemplate["Electrical"],
      {"Electrical": electricalOptions},
    );

    centralAirDisplay = getDisplayKey(
      "Central Air",
      modelInputTemplate["Central Air"],
      {"Central Air": centralAirOptions},
    );

    heatingDisplay = getDisplayKey("Heating", modelInputTemplate["Heating"], {
      "Heating": heatingOptions,
    });

    heatingQCDisplay = getDisplayKey(
      "Heating QC",
      modelInputTemplate["Heating QC"],
      {"Heating QC": heatingQualOptions},
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Sale & Utility",
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
                label: "Sale Type",
                hint: "Select Sale Type",
                icon: Icons.sell,
                value: saleTypeDisplay,
                featuremap: {"Sale Type": saleTypeOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    saleTypeDisplay = val;
                    modelInputTemplate['Sale Type'] = saleTypeOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 20),

              Dropdownwidget(
                label: "Sale Condition",
                hint: "Select Sale Condition",
                icon: Icons.assignment_turned_in,
                value: saleConditionDisplay,
                featuremap: {"Sale Condition": saleConditionOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    saleConditionDisplay = val;
                    modelInputTemplate['Sale Condition'] =
                        saleConditionOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 20),

              Dropdownwidget(
                label: "Electrical",
                hint: "Select Electrical Type",
                icon: Icons.electrical_services,
                value: electricalDisplay,
                featuremap: {"Electrical": electricalOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    electricalDisplay = val;
                    modelInputTemplate['Electrical'] = electricalOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 20),

              Dropdownwidget(
                label: "Central Air",
                hint: "Central Air Conditioning",
                icon: Icons.ac_unit,
                value: centralAirDisplay,
                featuremap: {"Central Air": centralAirOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    centralAirDisplay = val;
                    modelInputTemplate['Central Air'] = centralAirOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 20),

              Dropdownwidget(
                label: "Heating",
                hint: "Select Heating Type",
                icon: Icons.local_fire_department,
                value: heatingDisplay,
                featuremap: {"Heating": heatingOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    heatingDisplay = val;
                    modelInputTemplate['Heating'] = heatingOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 20),

              Dropdownwidget(
                label: "Heating QC",
                hint: "Heating Quality",
                icon: Icons.thermostat,
                value: heatingQCDisplay,
                featuremap: {"Heating QC": heatingQualOptions},
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                onChanged: (val) {
                  setState(() {
                    heatingQCDisplay = val;
                    modelInputTemplate['Heating QC'] = heatingQualOptions[val];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
