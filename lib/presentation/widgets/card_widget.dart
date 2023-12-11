import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:mydigital_id/domain/entities/company.dart';
import 'package:mydigital_id/domain/entities/user.dart';
import '../providers/providers.dart';

class CardWidget extends ConsumerWidget {
  const CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    final companies = ref.watch(companyProvider);
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    final color = context.colorScheme;
    final textStyle = context.textTheme;
    final index = ref.watch(selectedCompanyProvider);

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildHeaderRow(
                companies[index].name, companies[index].qr, textStyle),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: _buildLeftColumn(style, user.profile_pic_url)),
                  const SizedBox(width: 25),
                  Expanded(
                      flex: 3,
                      child: _buildRightColumn(
                          style, user, companies[index], color)),
                ],
              ),
            ),
            _buildFooterRow(companies[index].exp, style)
          ],
        ),
      ),
    );
  }

  Row _buildHeaderRow(String name, String logo, TextTheme style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name.toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 25,
            ),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: SvgPicture.network(
            logo,
            semanticsLabel: "The Company's Logo",
            placeholderBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        )
      ],
    );
  }

  Row _buildFooterRow(String role, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Expiration Date : $role',
            style: style.copyWith(color: Colors.red),
          ),
        ),
        const SizedBox(width: 10.0),
        const Icon(Icons.check),
      ],
    );
  }

  Column _buildLeftColumn(TextStyle style, String url) {
    return Column(
      children: [
        Expanded(child: Image.network(url)),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }

  Column _buildRightColumn(
      TextStyle style, User user, Company company, ColorScheme color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text('Name : ${user.first_name} ${user.last_name}',
                style: style.copyWith(color: color.primary))),
        Expanded(
            child: Text('Role : ${company.role}',
                style: style.copyWith(color: color.primary))),
        Expanded(
            child: Text('Email: ${user.email}',
                style: style.copyWith(color: color.primary))),
        Expanded(
            child: Text('Phone Number : ${user.phone_number}',
                style: style.copyWith(color: color.primary))),
      ],
    );
  }
}
