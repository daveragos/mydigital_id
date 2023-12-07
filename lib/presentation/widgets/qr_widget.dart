import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/app/utils/extensions.dart';

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
          child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: const Placeholder()),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Scan Me',
            style: context.textTheme.headlineMedium,
          ),
          Text(
            selectedcompany.name,
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
