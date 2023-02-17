import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          "About Us",
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
              "About Us",
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
              "E-Straightway is a platform where you get genuine services offered by service providers in quick time. We give you options based on nearest service provider available at your location with all information you need. \n\nE-Straightway is an aggregated platform wherein all Service providers are tied up under one belt. All you need to do is search for your desired category, and our app will filter you the nearest available options in quick time. In E-Straightway, all our Service providers are KYC verified and well experienced. We offer you the best in class services in quick time.",
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
