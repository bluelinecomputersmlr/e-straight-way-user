import 'package:estraightwayapp/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextFormField extends StatelessWidget {
  final String? hintText;
  final String? heading;
  final bool? isMandatory;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final void Function(String?)? onchanged;
  final bool? isPassword;
  final TextStyle? style;
  final bool? isEmail;
  final double? opacity;
  final String? initialvalue;
  final TextEditingController? controller;
  final GlobalKey<FormFieldState>? refkey;
  final Widget? suffixIcon;
  final Function()? ontap;
  final int? maxText;
  final int? maxLines;
  final TextInputAction? textAction;
  final Function(String)? onFieldsubmitted;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFormatters;
  final bool? isEnabled;
  final TextInputType? keyboardtype;

  MyTextFormField(
      {this.hintText,
      this.initialvalue,
      this.heading,
      this.validator,
      this.onSaved,
      this.isMandatory = true,
      this.isPassword = false,
      this.isEmail = false,
      this.isEnabled = true,
      this.controller,
      this.onchanged,
      this.opacity,
      this.refkey,
      this.suffixIcon,
      this.ontap,
      this.style,
      this.maxText,
      this.textAction,
      this.onFieldsubmitted,
      this.keyboardtype,
      this.focusNode,
      this.inputFormatters,
      this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        inputFormatters: inputFormatters,
        autocorrect: false,
        maxLength: maxText,
        maxLines: maxLines ?? 1,
        onTap: ontap,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          labelText: heading,
          labelStyle: GoogleFonts.poppins(color: const Color(0xff97AFDE)),
          floatingLabelAlignment: FloatingLabelAlignment.start,
          hintText: hintText,
          counterText: '',
          filled: true,
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(
              Radius.circular(25.0),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            // borderSide: const BorderSide(
            //   color: kBorderColor,
            //   width: 2.0,
            // ),
            borderRadius: BorderRadius.circular(25.0),
          ),
          floatingLabelStyle: GoogleFonts.poppins(
            color: kTextFiledFontColor,
          ),
          fillColor: const Color(0xffDEE8FF),
        ),
        obscureText: isPassword! ? true : false,
        onChanged: onchanged,
        initialValue: initialvalue,
        controller: controller,
        key: refkey,
        onFieldSubmitted: onFieldsubmitted,
        validator: validator,
        onSaved: onSaved,
        enabled: isEnabled,
        keyboardType: keyboardtype != null ? keyboardtype : TextInputType.text,
        textInputAction: textAction,
      ),
    );
  }
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class MaskedTextInputFormatter extends TextInputFormatter {
  final String mask;
  final String separator;

  MaskedTextInputFormatter({
    required this.mask,
    required this.separator,
  });

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.length > 0) {
      if (newValue.text.length > oldValue.text.length) {
        if (newValue.text.length > mask.length) return oldValue;
        if (newValue.text.length < mask.length &&
            mask[newValue.text.length - 1] == separator) {
          return TextEditingValue(
            text:
                '${oldValue.text}$separator${newValue.text.substring(newValue.text.length - 1)}',
            selection: TextSelection.collapsed(
              offset: newValue.selection.end + 1,
            ),
          );
        }
      }
    }
    return newValue;
  }
}
