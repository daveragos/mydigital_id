import 'package:url_launcher/url_launcher.dart';

class UrlHelper {
  dynamic launchEmail() async {
    try {
      Uri email = Uri(
        scheme: 'mailto',
        path: "abcd@gmail.com",
        queryParameters: {'subject': "Testing subject"},
      );

      await launchUrl(email);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic launchTel() async {
    try {
      Uri tel = Uri(
        scheme: 'tel',
        path: "+1234567890",
      );

      await launchUrl(tel);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic launchSms() async {
    try {
      Uri sms = Uri(
        scheme: 'sms',
        path: "+1234567890",
      );

      await launchUrl(sms);
    } catch (e) {
      print(e.toString());
    }
  }

  dynamic launchBrowser() async {
    try {
      Uri link =
          Uri(scheme: 'https', path: "www.github.com/mustafatahirhussein");

      await launchUrl(link);
    } catch (e) {
      print(e.toString());
    }
  }
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