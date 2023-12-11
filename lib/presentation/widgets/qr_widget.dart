import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mydigital_id/presentation/providers/providers.dart';

class QRWidget extends ConsumerWidget {
  const QRWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final company = ref.watch(companyProvider);
    final companyIndex = ref.watch(selectedCompanyProvider);
    final selectedcompany = company[companyIndex];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        SizedBox(
          width: 200,
          height: 200,
          child: SvgPicture.network(
            selectedcompany.qr,
            semanticsLabel: 'Scan for more info',
            placeholderBuilder: (BuildContext context) => Container(
                padding: const EdgeInsets.all(30.0),
                child: const CircularProgressIndicator()),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Scan Me',
            style: context.textTheme.headlineMedium,
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(Icons.arrow_circle_up)
        ]),
      ],
    );
  }
}
