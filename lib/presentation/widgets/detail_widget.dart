import 'package:flutter/material.dart';
import 'package:mydigital_id/domain/entities/company.dart';

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
      decoration: BoxDecoration(
          color: color.secondaryContainer,
          borderRadius: BorderRadius.circular(20.0)),
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.join_right,
                size: 50,
              )),
          ListTile(title: Text('Name : ${company.name}')),
          ListTile(
            title: Text('Email : ${company.email}'),
          ),
          ListTile(
            title: Text('Phone Number : ${company.phoneNumber}'),
          ),
          ListTile(
            title: Text('Address : ${company.address}'),
          ),
        ],
      ),
    );
  }
}
