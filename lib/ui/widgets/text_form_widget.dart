import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.label,
    required this.onChanged,
    required this.validator,
    required this.initialValue,
  });

  final String label;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: onChanged,
        initialValue: initialValue,
        validator: validator,
        expands: true,
        maxLines: null,
        minLines: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          errorStyle: const TextStyle(fontSize: 11, height: 0.3),
          labelText: label,
          labelStyle: const TextStyle(
            color: Colors.grey, //<-- SEE HERE
          ),
          hintStyle: const TextStyle(color: Colors.grey),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.grey, width: 1.0, strokeAlign: 10),
            borderRadius: BorderRadius.circular(2.0),
            gapPadding: 50,
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
            borderRadius: BorderRadius.circular(2.0),
            gapPadding: 0,
          ),
        ),
      ),
    );
  }
}
