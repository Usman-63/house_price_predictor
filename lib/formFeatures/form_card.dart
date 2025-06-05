import 'package:flutter/material.dart';

class FormCard extends StatelessWidget {
  final Widget child;
  const FormCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Padding(padding: const EdgeInsets.all(24.0), child: child),
    );
  }
}
