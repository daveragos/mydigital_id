import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/app/theme/theme.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mydigital_id/presentation/providers/providers.dart';

class NoQRWidget extends ConsumerWidget {
  const NoQRWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          child: Image.asset('assets/images.Asset3.png'),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'Nothing to Scan',
            style: context.textTheme.headlineMedium,
          ),
          const Icon(Icons.arrow_circle_left_outlined)
        ]),
      ],
    );
  }
}
