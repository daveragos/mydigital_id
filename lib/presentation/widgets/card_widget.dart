import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:mydigital_id/domain/entities/company.dart';
import 'package:mydigital_id/domain/entities/user.dart';
import 'package:mydigital_id/presentation/widgets/detail_widget.dart';
import '../providers/providers.dart';

class CardWidget extends ConsumerWidget {
  CardWidget({
    Key? key,
    required this.company,
    this.failed = false,
  }) : super(key: key);
  Company company;
  bool failed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    const style = TextStyle(fontWeight: FontWeight.bold);
    final color = context.colorScheme;
    final textStyle = context.textTheme;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return DetailWidget(color: color, company: company);
          },
        );
      },
      child: Container(
        height: 200,
        width: 300,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          // border: Border.all(color: color.primary),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildHeaderRow(company.name, company.qr, textStyle),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: _buildLeftColumn(style, user.profile_pic_url)),
                  const SizedBox(width: 25),
                  Expanded(
                      flex: 3,
                      child: _buildRightColumn(style, user, company, color)),
                ],
              ),
            ),
            _buildFooterRow(company.exp, style)
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
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
        SizedBox(
          width: 50,
          height: 50,
          child: failed
              ? Image.asset(logo)
              : SvgPicture.network(
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
        Expanded(
          child: FadeInImage.assetNetwork(
            placeholder: 'assets/images/Asset3.png',
            image: url,
            fit: BoxFit.cover,
            imageErrorBuilder: (context, error, stackTrace) {
              return Image.asset('assets/images/Asset3.png');
            },
          ),
        ),
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
