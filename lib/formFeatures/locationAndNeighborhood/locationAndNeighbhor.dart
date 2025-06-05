import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/form_functions.dart';
import 'package:house_price_predictor/formFeatures/dropdownwidget.dart';
import 'package:house_price_predictor/formFeatures/locationAndNeighborhood/neighbhod_info.dart';
import 'package:house_price_predictor/template.dart';

class LocationAndNeighborCard extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool) onValidationChanged;

  const LocationAndNeighborCard({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<LocationAndNeighborCard> createState() =>
      _LocationAndNeighborCardState();
}

class _LocationAndNeighborCardState extends State<LocationAndNeighborCard> {
  String? neighborhoodDisplay;
  String? condition1Display;
  String? condition2Display;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    neighborhoodDisplay = getDisplayKey(
      "Neighborhood",
      modelInputTemplate['Neighborhood'],
      neighborhoodFeatureMap,
    );
    condition1Display = getDisplayKey(
      "Condition 1",
      modelInputTemplate['Condition 1'],
      neighborhoodFeatureMap,
    );
    condition2Display = getDisplayKey(
      "Condition 2",
      modelInputTemplate['Condition 2'],
      neighborhoodFeatureMap,
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
                  "Neighborhood Information",
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
              const SizedBox(height: 35),
              Dropdownwidget(
                label: "Neighborhood",
                hint: "Select neighborhood location",
                icon: Icons.location_city,
                value: neighborhoodDisplay,
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                featuremap: neighborhoodFeatureMap,
                onChanged: (value) {
                  setState(() {
                    neighborhoodDisplay = value;
                    modelInputTemplate["Neighborhood"] =
                        neighborhoodFeatureMap["Neighborhood"]![value];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 35),
              Dropdownwidget(
                label: "Condition 1",
                hint: "Select main property proximity",
                icon: Icons.filter_1,
                value: condition1Display,
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                featuremap: neighborhoodFeatureMap,
                onChanged: (value) {
                  setState(() {
                    condition1Display = value;
                    modelInputTemplate["Condition 1"] =
                        neighborhoodFeatureMap["Condition 1"]![value];
                    _validate();
                  });
                },
              ),
              const SizedBox(height: 35),
              Dropdownwidget(
                label: "Condition 2",
                hint: "Select secondary property proximity",
                icon: Icons.filter_2,
                value: condition2Display,
                validator:
                    (val) => val == null || val.isEmpty ? "Required" : null,
                featuremap: neighborhoodFeatureMap,
                onChanged: (value) {
                  setState(() {
                    condition2Display = value;
                    modelInputTemplate["Condition 2"] =
                        neighborhoodFeatureMap["Condition 2"]![value];
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
