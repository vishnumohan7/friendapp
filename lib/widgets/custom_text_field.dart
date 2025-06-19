import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final dynamic prefixIcon;
  final dynamic suffixIcon;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final bool readOnly;
  final void Function()? onTap;
  final TextCapitalization textCapitalization;

  const CustomTextField({
    super.key,
    this.controller,
    required this.label,
    required this.hintText,
    this.keyboardType,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.onChanged,
    this.maxLines = 1,
    this.textInputAction,
    this.onFieldSubmitted,
    this.readOnly = false,
    this.onTap,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          textInputAction: textInputAction,
          onFieldSubmitted: onFieldSubmitted,
          readOnly: readOnly,
          onTap: onTap,
          textCapitalization: textCapitalization,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: prefixIcon is IconData 
                        ? Icon(prefixIcon, size: 20)
                        : prefixIcon,
                  )
                : null,
            suffixIcon: suffixIcon is IconData 
                ? Icon(suffixIcon, size: 20)
                : suffixIcon,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 14.0,
            ),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
