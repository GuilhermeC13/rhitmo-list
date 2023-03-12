import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget({
    super.key,
    required this.label,
    required this.onChanged,
    required this.validator,
  });

  final String label;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: TextFormField(
        onChanged: onChanged,
        validator: validator,
        expands: true,
        maxLines: null,
        minLines: null,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(8),
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
        ),
      ),
    );
  }
}
