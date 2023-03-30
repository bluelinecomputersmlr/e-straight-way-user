import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WaitingPage extends StatelessWidget {
  const WaitingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const SizedBox(
            height: 20.0,
          ),
          Image.asset(
            "assets/icons/waiting.png",
          ),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Hi Service Provider, Sit back and relax we'll have you verified.",
              style: GoogleFonts.inter(
                fontSize: 20.0,
                height: 1.5,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Please visit after sometime or click on the below button to check the status.",
              style: GoogleFonts.inter(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          GestureDetector(
            onTap: () {
              exit(0);
            },
            child: Center(
              child: Container(
                height: 50.0,
                width: MediaQuery.of(context).size.width * 0.50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.blueAccent,
                ),
                child: Center(
                  child: Text(
                    "Okay",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
