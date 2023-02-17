import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent.shade100,
        title: Text(
          "Terms & Conditions",
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
              "Terms & Conditions",
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
                text: '',
                style: GoogleFonts.inter(
                  height: 1.5,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: '1. GENERAL\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'a. Welcome to estraightway – Mobile Application (“App”). This App is owned and operated by estraightway (“the Company”), whose registered office is at #2-19 Chennavara Patte, Palthadi District, Puttur-574210. The App is an internet platform that allows users to book services ("providers") in India.\nb. For the purposes of these terms of use ("Terms of Use"), "We" implies "Us" and "Our" means the Company and "You" means any individual who accesses or utilizes the App or the Services. "Services" involves access to Our Mobile App, App Upgrades, Our Call and SMS-based Services, Databases, Interactive Voice Response Services, and all other Services and Functions.\nc. By utilizing this App or the Services, you agree to be bound by these Terms of Use, the services agreement between You and estraightway and Our other policies made available on the app, (“Policies”). If You do not agree to these Terms of Use or any of Our Policies, please do not use the Services or access the App.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '2. Changes to the Terms of Use\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'By updating this document, we may change these Terms of Use and Our Policies from time to time. You will acknowledge such modifications if you continue to use the App or Services after publishing modifications\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '3. Access to the App and Services\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Only if you are 18 years of age or older and are legally able to enter into a binding contract under applicable law, including, in particular, the Indian Contract Act, 1872, can you access the App and the Services.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '4. Your Information\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'a. Through Our App, you can use the services. Upon downloading the App, you are nee ded to provide us with your information, including your name, address, contact number and email address, and then select the service you need, including the appropriate moment ("User Information") for such service.\nb. In the wake of acquiring this data, we will furnish You with a rundown of accessible Providers and an expected expense of the administrations advertised. You may affirm a booking, where upon the significant Provider will get in touch with You, land at Your living arrangement, review the extent of administrations required and quote a last charge for the equivalent ("Transaction Fee"). You may then continue to acknowledge and benefit of the administrations the Provider offers ("Transaction").\nc. Alternatively, you may provide us with Your mobile phone number on the app. We will then contact you, retrieve your user information and follow the procedure outlined in paragraph 4(b) above.\nd. By providing us with Your User Information, You confirm that:\ni) The User Information provided by You is accurate and genuine;\nii) The mobile phone number provided by You belongs to you, has been validly acquired under applicable law, and You may be contacted on the number by way of calls or SMS messages by Us or Our Providers; and\niii) You shall immediately notify Us of any un-authorized use of Your User Information or any other breach of these Terms of Use or security known to You.\niv) Further, You authorize us to:\n- Collect, process and store User Information and access information including the IP address, IMEI number and MAC address of the computer/device from where the App were accessed;\n- Either directly, or through third parties, verify and confirm Your User Information;\n- Contact You using Your User Information, including for marketing and promotional calls; and\n- Share Your User Information with Providers who may use the same to contact You, including on Your mobile phone.\no Subject to the above, and Your compliance with these Terms of Use, we grant You a non-exclusive, revocable, limited privilege to access and use this App and the Services.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '5. Fees and Payment\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'a. The use of the App and Services is free of cost. However, this no charge policy can be amended at Our discretion and We reserve the right to charge for any of the Services.\nb. You can either pay the Transaction Fee directly to the Provider upon completion of his/her services or through the App, in Indian Rupees. \nc. If You choose to pay the Transaction Fee through the App, your credit/debit card or other payment instruments will be processed using a third party payment gateway (“Payment Facility”) which will also be governed by the terms and conditions agreed to between You and Your issuing bank. \nd. We will not be responsible for any loss or damage to You due to Your use of the Payment Facility on the App. \ne. We can impose limits on the number of Transactions or the Transaction Fee which we receive from You and can refuse to process any Transaction Fee, at Our sole discretion.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '6. Use of the App and Services\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'a. You agree to use the App and Services in a bona fide way for their planned purpose. You specifically agree not to: i) print, distribute, share, download, duplicate or otherwise copy, delete, vary or amend or use any data or User Information of any User other than You; ii) infringe on any intellectual property rights of any person and/or retain information in any computer system or otherwise with an intention to do so; iii) attempt to gain unauthorized access to any portion or feature of the App, or any other systems or networks connected to the App or to any server, computer, network, or to any of the Services by hacking, password “mining” or any other illegitimate means; iv) probe, scan or test the vulnerability of the App or Services or any network connected to the App or Services or breach the security or authentication measures on the App or any network connected to the App or Services; v) use any automated systems to extract data from the App; vi) make any inaccurate, false, unfair or defamatory statement(s) or comment(s) about us or the brand name or domain name used by us, any Provider or any User on the App; vii) take any action that imposes an unreasonable or disproportionately large load on the infrastructure of the App or Our systems or networks, or any systems or networks connected to Us; or viii) circumvent or manipulate the App, Services, registration process, Transaction Fees, billing system, or attempt to do so. b. You also agree not to host, display, upload, alter, publish, communicate, update, share or otherwise make any data accessible on the App, such as: i) contains content or other material protected by legislation governing intellectual property, unless you own or regulate those freedoms or have obtained all required consent; ii) defames, abuses, harasses, stalks, hurts religious or ethnic sentiments of, threatens or otherwise violates the legal rights of others; iii) is grossly harmful, harassing, blasphemous defamatory, obscene, pornographic, paedophilic, libellous, invasive of another’s privacy, hateful, or racially, ethnically objectionable, disparaging, relating or encouraging money laundering or gambling, or otherwise unlawful in any manner whatever; iv) infringes any patent, trademark, copyright or other proprietary rights; v) deceives or misleads the addressee about the origin of such messages or communicates any information which is grossly offensive or menacing in nature; vi) contains software viruses or any other computer code, files or programs designed to interrupt, destroy or limit the functionality of any computer resource; vii) threatens the unity, integrity, defence, security or sovereignty of India, friendly relations with foreign states, or public order or causes incitement to the commission of any cognisable offence or prevents investigation of any offence or is insulting any other nation; viii) uses any other internet service to send or post spam to drive visitors to any other site hosted on or through the Company’s systems, whether or not the messages were originated by You, under Your direction, or by or under the direction of a related or unrelated third party; or ix) contains any content which is non-compliant with the Information Technology Act, 2000, Rules and regulations, guidelines made thereunder, including Rule 3 of The Information Technology (Intermediaries Guidelines) Rules, 2011, Terms of Use or Privacy Policy, as amended/re-enacted from time to time.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '7. Intellectual Property\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'a. The protected innovation in the App, and in the material, substance and data made accessible on the App including illustrations, pictures, photos, logos, trademarks, the appearance, association and format of the App and the fundamental programming code have a place with us or Our licensors. b. You should not duplicate, change, adjust, distribute, communicate, disperse, sell or move (regardless of whether in entire or to some degree) any such material. The data gave on the App and through the Services is for your own utilization as it were.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '8. Feedback, Reputation and Reviews\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'You consent to be reasonable, exact and non-demonizing while at the same time leaving remarks, criticism, tributes and surveys ("Feedback") approximately the App or the Services, you recognize that You move all rights in such Feedback to Us and that We will be allowed to utilize equivalent to We may discover proper.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '9. Transactions\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'a. The App is a stage which empowers Users to associate with Providers and any exchanges among You and any Provider are carefully bi-partite. We are not and can\'t be a gathering to, or control in any way, any Transaction among You and any Provider. We will not and are not required to intervene or resolve any questions or differences between the You and any Provider. b. Likewise, we won\'t be at risk for any misfortune or harm acquired as the consequence of any such exchange. While interfacing with any Provider found through the App or through the Services, we firmly urge You to practice sensible steadiness as You would in customary disconnected channels and practice judgment and presence of mind before focusing on any Transaction or trade of data. c. You comprehend that there is no certification of a tasteful reaction or any reaction whatsoever to Your solicitation for administrations of Providers. d. All screening systems, confirmation administrations and historical verifications, regardless of whether attempted by Us or through outsider specialists are performed on an "as may be" and "as accessible" premise. By picking to benefit of them You recognize that We won\'t be in charge of the quality or precision of the consequences of these systems. e. Service provider may acquire individual data about You because of Your utilization of the App or Services, and such Providers may utilize this data to bother or harm You. We don\'t endorse of such acts, yet by utilizing the Services, you recognize that We are not in charge of the utilization of any close to personal data that you reveal or share with others using the Services\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '10. Third Party Sites\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'All outsider ads, hyperlinks or other redirection apparatuses on the App which take You to substance worked by outsiders are not constrained by us and don\'t frame some portion of the App. We are not subject for any misfortune or damage that strikes You because of such destinations.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '11. Disclaimer and Limitation of Liability\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'THE APP AND SERVICES ARE PROVIDED ON AN "AS Seems to be" AND "AS AVAILABLE" BASIS WITHOUT ANY REPRESENTATION OR WARRANTY, EXPRESS OR IMPLIED. WE DO NOT WARRANT THAT: a. The App or the Services will be continually accessible, or accessible by any means. We will have no risk to You for any intrusion or postponement in access to the App or Services benefited through it, regardless of the reason; b. The data on the App or given through Services is finished, genuine, exact or non-deluding; c. Any mistakes or deformities in the App or Services will be redressed; d. That the App is secure or free of infections, Trojans or other malware.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '12. Privacy Policy\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'Any close to personal data You supply to Us when You utilize this App or the Services will be utilized as per Our Privacy Policy.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text: '13. Miscellaneous\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text:
                        'In the event that any arrangements of these Terms of Use are observed to be invalid by any court having skillful ward, the deficiency of such arrangement will not influence the legitimacy of the rest of the arrangements of these Terms of Use, which will stay in full power and impact. No waiver of any term of these Terms of Use will be considered a further or proceeding with waiver of such term or some other term.\n\n',
                    style: GoogleFonts.inter(
                      height: 1.5,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    text:
                        'This archive is an electronic record under the Information Technology Act, 2000 and administers thereunder. This electronic record is produced by a PC framework and does not require any physical or advanced marks.\n\nThis archive is distributed as per the arrangements of Rule 3 (1) of the Information Technology (Intermediaries Guidelines) Rules, 2011 that require distributing the standards and guidelines, Privacy Policy and Terms of Use for access to or utilization of this Website/App. ',
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
