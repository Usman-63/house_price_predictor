import 'package:flutter/material.dart';
import 'package:house_price_predictor/template.dart';

class DatePickerFile extends StatefulWidget {
  final TextEditingController yearBuiltController;
  final TextEditingController yearRemodController;
  final VoidCallback validate;

  const DatePickerFile({
    super.key,
    required this.yearBuiltController,
    required this.yearRemodController,
    required this.validate,
  });

  @override
  State<DatePickerFile> createState() => _DatePickerFileState();
}

class _DatePickerFileState extends State<DatePickerFile> {
  Future<void> _pickYear({
    required BuildContext context,
    required TextEditingController controller,
    int? firstYear,
    int? lastYear,
  }) async {
    final now = DateTime.now();
    final initialYear =
        int.tryParse(controller.text) ?? (firstYear ?? now.year);
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(initialYear),
      firstDate: DateTime(firstYear ?? 1960),
      lastDate: DateTime(lastYear ?? now.year),
      helpText: 'Select Year',
      fieldLabelText: 'Year',
      fieldHintText: 'Year',
      initialEntryMode: DatePickerEntryMode.calendar,
      builder: (context, child) => child!,
    );
    if (picked != null) {
      controller.text = picked.year.toString();
      setState(() {});
      widget.validate();
    }
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: primaryColor.withOpacity(0.5), width: 1.5),
    );
    return Column(
      children: [
        TextFormField(
          controller: widget.yearBuiltController,
          readOnly: true,
          decoration: InputDecoration(
            labelText: "Year Built",
            prefixIcon: Icon(Icons.calendar_today, color: primaryColor),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
            fillColor: Colors.grey[50],
            filled: true,
          ),
          validator: (val) => val == null || val.isEmpty ? "Required" : null,
          onTap: () async {
            await _pickYear(
              context: context,
              controller: widget.yearBuiltController,
              firstYear: 1960,
              lastYear: DateTime.now().year,
            );
            modelInputTemplate['Year Built'] = widget.yearBuiltController.text;
            if (widget.yearRemodController.text.isNotEmpty &&
                int.tryParse(widget.yearRemodController.text) != null &&
                int.tryParse(widget.yearBuiltController.text) != null &&
                int.parse(widget.yearRemodController.text) <
                    int.parse(widget.yearBuiltController.text)) {
              widget.yearRemodController.clear();
              modelInputTemplate['Year Remod/Add'] = '';
            }
            widget.validate();
          },
        ),
        SizedBox(height: 25),
        TextFormField(
          controller: widget.yearRemodController,
          readOnly: true,
          enabled: widget.yearBuiltController.text.isNotEmpty,
          decoration: InputDecoration(
            labelText: "Year Remod/Add",
            prefixIcon: Icon(Icons.edit_calendar, color: primaryColor),
            enabledBorder: border,
            focusedBorder: border.copyWith(
              borderSide: BorderSide(color: primaryColor, width: 2),
            ),
            errorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),
            focusedErrorBorder: border.copyWith(
              borderSide: BorderSide(color: Colors.redAccent, width: 2),
            ),
            fillColor: Colors.grey[50],
            filled: true,
          ),
          validator: (val) => val == null || val.isEmpty ? "Required" : null,
          onTap:
              widget.yearBuiltController.text.isEmpty
                  ? null
                  : () async {
                    await _pickYear(
                      context: context,
                      controller: widget.yearRemodController,
                      firstYear:
                          int.tryParse(widget.yearBuiltController.text) ?? 1960,
                      lastYear: DateTime.now().year,
                    );
                    modelInputTemplate['Year Remod/Add'] =
                        widget.yearRemodController.text;
                    widget.validate();
                  },
        ),
      ],
    );
  }
}
