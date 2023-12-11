import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:mydigital_id/domain/entities/user.dart';
import '../providers/providers.dart';

class NoCardWidget extends ConsumerWidget {
  const NoCardWidget({Key? key}) : super(key: key);

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
            _buildHeaderRow("My Digital Id", textStyle),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                      child: _buildLeftColumn(style, user.profile_pic_url)),
                  const SizedBox(width: 25),
                  Expanded(
                      flex: 3, child: _buildRightColumn(style, user, color)),
                ],
              ),
            ),
            _buildFooterRow(DateTime.now().toString(), style)
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
        SizedBox(
            width: 50,
            height: 50,
            child: Image.asset('assets/images/Asset2.png'))
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

  Column _buildRightColumn(TextStyle style, User user, ColorScheme color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Text('Name : ${user.first_name} ${user.last_name}',
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
