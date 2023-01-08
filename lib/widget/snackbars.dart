import 'package:flutter/material.dart';
import 'package:estraightwayapp/constants.dart';
import 'package:google_fonts/google_fonts.dart';

//ERROR SNACKBAR
showErrorSnackbar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kCategorySelectedColor,
      content: Text(
        message,
        style: GoogleFonts.inter(),
      ),
    ),
  );
}

//SUCCESS SNACKBAR
showSuccessSnackbar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: kSuccessColor,
      content: Text(
        message,
        style: GoogleFonts.inter(),
      ),
    ),
  );
}

//INFORMATION(INFO) SNACKBAR
showInfoSnackbar(BuildContext context, String message) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        message,
        style: GoogleFonts.inter(),
      ),
    ),
  );
}
