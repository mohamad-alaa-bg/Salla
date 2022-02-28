import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final bool obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onSubmitted;


  // ignore: use_key_in_widget_constructors
  const CustomTextFormField({
    required this.textEditingController,
    required this.label,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.validator,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        label: Text(label,style: Theme.of(context).textTheme.bodyText2,),
        border: const OutlineInputBorder(),
        counterStyle: Theme.of(context).textTheme.bodyText2,
      ),
    );
  }
}
