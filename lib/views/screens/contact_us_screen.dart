import 'package:flutter/material.dart';
import 'package:omiga_ipl/constants/main_colors.dart';
import 'package:omiga_ipl/constants/main_texts.dart';
import 'package:omiga_ipl/constants/text_helpers.dart';
import 'package:omiga_ipl/views/widgets/common_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: MainAppbar(
            title: tCntctUs,
            isBack: true,
          )),
      body: ListView(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
          children: [
            _cmButton(
                onTap: () {
                  _makePhoneCall("9876543210");
                },
                title: tCallUs,
                icon: Icons.phone),
            const SizedBox(
              height: 20,
            ),
            _cmButton(
                onTap: () {
                  _sendEmail(
                      "Sree89400@gmail.com", "test mail", "this is test mail");
                },
                title: tEmlUs,
                icon: Icons.email),
          ]),
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> _sendEmail(
      String emailAddress, String subject, String body) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );
    await launchUrl(launchUri);
  }

  Widget _cmButton(
      {required String title, required IconData icon, required onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(0, 7),
                blurRadius: 15,
                spreadRadius: -2)
          ], color: Colors.white, borderRadius: BorderRadius.circular(5)),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextHelper.pop14W600B,
                ),
                Icon(
                  icon,
                  color: cBlue,
                  size: 28,
                ),
              ],
            ),
          )),
    );
  }
}
