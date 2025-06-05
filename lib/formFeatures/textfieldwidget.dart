import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Textfieldwidget extends StatefulWidget {
  final String label;
  final IconData? icon;
  final TextInputType keyboardType;
  final void Function(String)? onChanged;
  final bool isRequired;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextEditingController controller;
  final String? hint;

  const Textfieldwidget({
    super.key,
    required this.label,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.isRequired = false,
    this.validator,
    required TextEditingController this.controller,
    this.enabled = true,
    this.hint = "",
  });

  @override
  State<Textfieldwidget> createState() => _TextfieldwidgetState();
}

class _TextfieldwidgetState extends State<Textfieldwidget> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      enabled: widget.enabled,
      style: TextStyle(
        color: Colors.black87, // Main text color
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
      inputFormatters: [
        if (widget.keyboardType == TextInputType.number)
          FilteringTextInputFormatter.digitsOnly,
      ],
      onChanged: widget.onChanged,
      validator: widget.validator,
      decoration: InputDecoration(
        hintText: widget.hint,
        labelText: widget.label,
        labelStyle: TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 15,
        ),
        focusColor: primaryColor,
        hoverColor: primaryColor.withOpacity(0.1),
        prefixIcon:
            widget.icon != null ? Icon(widget.icon, color: primaryColor) : null,
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
    );
  }
}
