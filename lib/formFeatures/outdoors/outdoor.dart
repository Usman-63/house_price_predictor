import 'package:flutter/material.dart';
import 'package:house_price_predictor/formFeatures/form_card.dart';
import 'package:house_price_predictor/formFeatures/textfieldwidget.dart';
import 'package:house_price_predictor/template.dart';

class Outdoor extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final void Function(bool) onValidationChanged;
  const Outdoor({
    super.key,
    required this.formKey,
    required this.onValidationChanged,
  });

  @override
  State<Outdoor> createState() => _OutdoorState();
}

class _OutdoorState extends State<Outdoor> {
  final woodDeckController = TextEditingController();
  final openPorchController = TextEditingController();
  final enclosedPorchController = TextEditingController();
  final threeSsnPorchController = TextEditingController();
  final screenPorchController = TextEditingController();
  final poolAreaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    woodDeckController.text = modelInputTemplate['Wood Deck SF'] ?? '';
    openPorchController.text = modelInputTemplate['Open Porch SF'] ?? '';
    enclosedPorchController.text = modelInputTemplate['Enclosed Porch'] ?? '';
    threeSsnPorchController.text = modelInputTemplate['3Ssn Porch'] ?? '';
    screenPorchController.text = modelInputTemplate['Screen Porch'] ?? '';
    poolAreaController.text = modelInputTemplate['Pool Area'] ?? '';
    
  }

  @override
  void dispose() {
    woodDeckController.dispose();
    openPorchController.dispose();
    enclosedPorchController.dispose();
    threeSsnPorchController.dispose();
    screenPorchController.dispose();
    poolAreaController.dispose();
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
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Outdoor Features",
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
                label: "Wood Deck SF",
                hint: "Wood Deck Square Footage (0 - 1000)",
                icon: Icons.deck,
                keyboardType: TextInputType.number,
                controller: woodDeckController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 0 || num > 1000)
                    return "Enter a value between 0 and 1000";
                  return null;
                },
                onChanged: (val) {
                  modelInputTemplate['Wood Deck SF'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 20),

              Textfieldwidget(
                label: "Open Porch SF",
                hint: "Open Porch Square Footage (0 - 500)",
                icon: Icons.portrait,
                keyboardType: TextInputType.number,
                controller: openPorchController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 0 || num > 500)
                    return "Enter a value between 0 and 500";
                  return null;
                },
                onChanged: (val) {
                  modelInputTemplate['Open Porch SF'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 20),

              Textfieldwidget(
                label: "Enclosed Porch",
                hint: "Enclosed Porch Square Footage (0 - 500)",
                icon: Icons.meeting_room,
                keyboardType: TextInputType.number,
                controller: enclosedPorchController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 0 || num > 500)
                    return "Enter a value between 0 and 500";
                  return null;
                },
                onChanged: (val) {
                  modelInputTemplate['Enclosed Porch'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 20),

              Textfieldwidget(
                label: "3Ssn Porch",
                hint: "3-Season Porch Square Footage (0 - 500)",
                icon: Icons.sunny,
                keyboardType: TextInputType.number,
                controller: threeSsnPorchController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 0 || num > 500)
                    return "Enter a value between 0 and 500";
                  return null;
                },
                onChanged: (val) {
                  modelInputTemplate['3Ssn Porch'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 20),

              Textfieldwidget(
                label: "Screen Porch",
                hint: "Screen Porch Square Footage (0 - 500)",
                icon: Icons.window,
                keyboardType: TextInputType.number,
                controller: screenPorchController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 0 || num > 500)
                    return "Enter a value between 0 and 500";
                  return null;
                },
                onChanged: (val) {
                  modelInputTemplate['Screen Porch'] = val;
                  _validate();
                },
              ),
              const SizedBox(height: 20),

              Textfieldwidget(
                label: "Pool Area",
                hint: "Pool Area Square Footage (0 - 1000)",
                icon: Icons.pool,
                keyboardType: TextInputType.number,
                controller: poolAreaController,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Required";
                  final num = int.tryParse(val);
                  if (num == null) return "Enter a valid number";
                  if (num < 0 || num > 1000)
                    return "Enter a value between 0 and 1000";
                  return null;
                },
                onChanged: (val) {
                  modelInputTemplate['Pool Area'] = val;
                  _validate();
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
