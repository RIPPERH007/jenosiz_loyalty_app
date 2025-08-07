import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

class ShareHelper {
  static Future<void> shareReferralCode(String code) async {
    final message = 'Join Jenosize Loyalty and use my referral code: $code\n\n'
        'Download the app and start earning rewards today!\n'
        'https://play.google.com/store/apps/jenosize-loyalty';

    await Share.share(
      message,
      subject: 'Join Jenosize Loyalty with my referral code!',
    );
  }

  static Future<void> copyToClipboard(BuildContext context, String text) async {
    await Clipboard.setData(ClipboardData(text: text));

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Code copied to clipboard!'),
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}
