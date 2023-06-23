import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpDeskScreen extends StatelessWidget {
  const HelpDeskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          "Help Desk",
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Help Desk",
              style: GoogleFonts.inter(
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Address\n\nNo. 17-4-1-6/C-0-G57,KSRTC Bus Stand Building, C-Block, Court Road, Puttur Kasaba Village, Puttur, Dakshina Kannada, Karnataka-574201\n\nPhone\n+91-94801 73045\n\nEmail\ncare@estraightwayapp.com",
              style: GoogleFonts.inter(
                height: 1.5,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
