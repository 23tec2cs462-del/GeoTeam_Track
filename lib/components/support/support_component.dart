import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';
import '../../utils/app_constants.dart';

class SupportComponent extends StatefulWidget {
  const SupportComponent({super.key});

  @override
  State<SupportComponent> createState() => _SupportComponentState();
}

//TODO: Link not opening issue need to fix
class _SupportComponentState extends State<SupportComponent> {
  String supportEmail = 'support@webentix.com';
  String website = 'https://www.webentix.com';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildSupportButton(
              icon: Icons.email,
              label: 'Mail Support',
              onTap: () => _sendEmail(),
            ),
            _buildSupportButton(
              icon: Icons.web,
              label: 'Visit Website',
              onTap: () => _openWebsite(),
            ),
          ],
        ),
      ],
    );
  }

  // Reusable Support Button
  Widget _buildSupportButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: appStore.appPrimaryColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: white, size: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(label, style: primaryTextStyle(size: 14)),
      ],
    );
  }

  // Open Phone Call

  // Send Email
  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: supportEmail,
      query: Uri.encodeComponent(
        'subject=I need help from $mainAppName Employee App',
      ),
    );
    try {
      await launchUrl(emailUri);
    } catch (e) {
      toast('Unable to send email');
    }
  }


  // Open Website
  Future<void> _openWebsite() async {
    final Uri url = Uri.parse(website);
    try {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } catch (e) {
      toast('Unable to open the website');
    }
  }
}
