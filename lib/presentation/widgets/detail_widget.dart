import 'package:flutter/material.dart';
import 'package:mydigital_id/app/utils/launch_helper.dart';
import 'package:mydigital_id/domain/entities/company.dart';
import 'package:mydigital_id/presentation/widgets/card_widget.dart';
import 'package:mydigital_id/presentation/widgets/qr_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailWidget extends StatelessWidget {
  const DetailWidget({
    super.key,
    required this.color,
    required this.company,
  });

  final ColorScheme color;
  final Company company;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
          color: color.secondaryContainer,
          borderRadius: BorderRadius.circular(20.0)),
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          CardWidget(company: company),
          QRWidget(qrCode: company.qr),
        ],
      ),
    );
  }
}
 /*
CircleAvatar(
            radius: 30,
            backgroundColor: Colors.grey,
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/Asset2.png',
              image: company.logo,
              fit: BoxFit.cover,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset('assets/images/Asset2.png');
              },
            ),
          ),
          ListTile(title: Text('Name : ${company.name}')),
          ListTile(
            onTap: () {
              UrlHelper().launchEmail(company.email);
            },
            title: Text('Email : ${company.email}'),
          ),
          ListTile(
            onTap: () {
              UrlHelper().launchTel(company.phoneNumber);
            },
            title: Text('Phone Number : ${company.phoneNumber}'),
          ),
          ListTile(
            title: Text('Address : ${company.address}'),
          ),
 */