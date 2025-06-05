import 'package:flutter/material.dart';

class Dropdownwidget extends StatelessWidget {
  final String label;
  final IconData? icon;
  final String? value;
  final void Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final Map<String, Map<String, dynamic>> featuremap;
  final bool enabled;
  final String? hint;

  const Dropdownwidget({
    super.key,
    required this.label,
    required this.icon,
    this.value,
    this.onChanged,
    this.validator,
    required this.featuremap,
    this.enabled = true,
    this.hint = "",
  });
  Map<String, String> getFilteredOptions(Map<String, String> options) {
    final filtered = Map<String, String>.from(options);
    if (enabled) filtered.remove("No Basement");
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        prefixIcon: Icon(icon, color: primaryColor),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: primaryColor.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: primaryColor, width: 2),
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
      value: value,
      onChanged: enabled ? onChanged : null,
      validator: validator,
      items:
          featuremap[label]!.keys.map((display) {
            return DropdownMenuItem(value: display, child: Text(display));
          }).toList(),
    );
  }
}
