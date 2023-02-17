import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          "Privacy Policy",
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
              "Privacy Policy",
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
            child: RichText(
              text: TextSpan(
                text:
                    'estraightway platform care about your privacy and we are dedicated to safeguard your private information. This privacy declaration will tell you how we manage your private information, your privacy rights, and how the law protects you. Before using our Services, please read this privacy declaration thoroughly. estraightway platform may update this Privacy Policy at times. Please check this Privacy Policy periodically for changes. If we make any changes, the updated policy will be posted to this platform (app or website) with a revised "last updated" date. We encourage you to review this page periodically for the recent data about our privacy procedures.\n\n',
                style: GoogleFonts.inter(
                  height: 1.5,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text:
                        'What personal information do we collect from the people that visit our platform?\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'When you use estraightway Application, we collect and store personal information Provided by you from time to time. We do so to ensure that you are provided a safe, efficient, smooth and seamless experience. When you download & install our mobile application on your mobile phone and run, first time we will send OTP to your mobile phone and we will read the OTP number automatically for the purpose for verification with your registered details. We primarily use this information to detect fraud & unauthorized usage of Call For Prayer information services. We read SMS message & routing information only for mobile number verification purposes during first time installation. We do not read messages sent by any service other than OTP sent by us itself for verification purpose. \n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'When do we collect information?\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'We collect information from you when you register on our application or request for a service on our application.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'How do we use your information?\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'We may use the information we collect from you when you register, make a request, sign up for our newsletter, respond to a survey or marketing communication, or use certain other site features in the Following ways:\n- To personalize user\'s experience and to allow us to deliver the type of content and product offerings in which you are most interested.\n- To allow us to better service you in responding to your customer service requests.\n- To administer a contest, promotion, survey or other site feature.\n- To quickly process your transactions.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'How do we protect visitor information?\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'We do not use vulnerability scanning and/or scanning to PCI standards. We use regular Malware Scanning. Your personal information is contained behind secured networks and is only accessible by a limited number of persons who have special access rights to such systems, and are required to keep the information confidential. In addition, all sensitive/credit information you supply is encrypted via Secure Socket Layer (SSL) technology. We implement a variety of security measures when a user places an order enters, submits, or accesses their information to maintain the safety of your personal information. All transactions are processed through a gateway provider and are not stored or processed on our servers.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Do we use \'cookies\'?\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Yes. Cookies are small files that a site or its service provider transfers to your computer\'s hard drive through your Web browser (if you allow) that enables the site\'s or service provider’s systems to recognize your browser and capture and remember certain information. This Service do not use these “cookies” explicitly. However, the app may use third party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'We use cookies to:\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        '- Understand and save user\'s preferences for future visits.\n- Compile aggregate data about application traffic and interactions in order to offer better app experiences and tools in the future. We may also use trusted third party services that track this information on our behalf. You can choose to have your device warn you each time a cookie is being sent, or you can choose to turn off all cookies. If you disable cookies off, some features will be disabled. It won\'t affect the users’ experience that makes your site experience more efficient and some of our services will not function properly. However, you can still use the services.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Third Party Disclosure\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'We do not sell, trade, or otherwise transfer to outside parties your personally identifiable information.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'Third party links\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'All of the App\'s outsider advertisements, hyperlinks or other redirecting devices that bring You to the material operated by strangers are not restricted by us and do not frame a part of the App. We are not subject to any misfortune or harm caused by such locations that hits you.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: 'How does our site handle do not track signals?\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'With morality we do not track signals and do not track, plant cookies, or use advertising when a Do Not Track (DNT) browser mechanism is in place.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Does our app allow third party behavioural tracking?\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'It\'s also important to note that we do not allow third party behavioural tracking.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text:
                        'In order to be in line with Fair Information Practices we will take the following responsive action, should a data breach occur:\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'We will notify the users via phone\n- Within 1 business day We may need to disclose personal information when required by law. We will reveal such data where we believe that it is essential to obey with a court order, continuing judicial proceedings, or other legal process served on our business, or to exercise our legal freedoms or protect against legal allegations.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text:
                        'If you have any questions about this Privacy Policy, the practices of this App, or your dealings with this App, please contact us.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'estraightway\n#2-19\nChennavara Patte,\nPalthadi District, Puttur-574210\n\nContact no. +91-94801 73045 ',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
