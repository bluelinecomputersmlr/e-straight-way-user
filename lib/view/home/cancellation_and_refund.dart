import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CancellationAndRefund extends StatelessWidget {
  const CancellationAndRefund({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          "Cancellation and Refund",
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
              "Cancellation and Refund",
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
              "We allow the customers to seamlessly book any services through our mobile application Before booking any Services, the Customers or App Users will be asked to pay a Token Advance amount to book the Service. Once the Token Advance amount is paid, his or her Service will be booked with a Booking Id. Customers once booked will have a duration or 5 mins from Booking Time to cancel the service booked. From Users perspective, once the user books a Service, he will be allow to cancel the Service Request within 5 mins after he booked the service successfully. If he does so within the mentioned time range, then the user is eligible to avail 100% of the service charge amount refunded. Lastly, every service booked from Service Provider will be reached to respective Service providers. If the Service providers cancels the appointment, then the user is liable to get 100% of the service charge amount refunded. There will not be any refunds granted in 2 cases. (a) User trying to Cancel the booking after 5 mins post confirmation (b) Once the Service Providers accepts the Service Request",
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
