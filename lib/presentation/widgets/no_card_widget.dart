import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:mydigital_id/domain/entities/company.dart';
import 'package:mydigital_id/domain/entities/user.dart';
import '../providers/providers.dart';

class NoCardWidget extends ConsumerWidget {
  NoCardWidget({Key? key, required this.company}) : super(key: key);
  Company company;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userStateProvider);
    const style = TextStyle(fontWeight: FontWeight.bold, fontSize: 20);
    final color = context.colorScheme;
    final textStyle = context.textTheme;

    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            _buildHeaderRow(company.name, textStyle),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: _buildLeftColumn(style, company.logo)),
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

  Row _buildHeaderRow(String name, TextTheme style) {
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
      ],
    );
  }

  Row _buildFooterRow(String exp, TextStyle style) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Expiration Date : $exp',
            style: style.copyWith(color: Colors.red),
          ),
        ),
        const SizedBox(width: 10.0),
        const Icon(
          Icons.wifi_protected_setup,
          color: Colors.red,
        ),
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
            child: Text('Position: ${company.role}',
                style: style.copyWith(color: color.primary))),
        Expanded(
            child: Text('Rating : ${company.rating}',
                style: style.copyWith(color: color.primary))),
      ],
    );
  }
}
