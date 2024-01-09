import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  dynamic launchEmail(String email) async {
    try {
      Uri emailUri = Uri(
        scheme: 'mailto',
        path: email,
        queryParameters: {'subject': "Edit this subject"},
      );

      await launchUrl(emailUri);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic launchTel(String phoneNumber) async {
    try {
      Uri telUri = Uri(
        scheme: 'tel',
        path: phoneNumber,
      );

      await launchUrl(telUri);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic launchSms(String phoneNumber) async {
    try {
      Uri smsUri = Uri(
        scheme: 'sms',
        path: phoneNumber,
      );

      await launchUrl(smsUri);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic launchBrowser(String url) async {
    try {
      Uri linkUri = Uri(scheme: 'https', path: url);

      await launchUrl(linkUri);
    } catch (e) {
      print(e.toString());
    }
  }

  //launch map
}

// void launchURL(String url) async {
//   if (await canLaunchUrl(url)) {
//     await launchUrl(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }

// // For a phone number:
// _launchURL('tel:+123456789');

// // For a location on Google Maps:
// _launchURL('https://www.google.com/maps/search/?api=1&query=52.32,4.917');