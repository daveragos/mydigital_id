import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mydigital_id/domain/entities/company.dart';

import 'package:mydigital_id/presentation/providers/providers.dart';

class QRWidget extends ConsumerWidget {
  QRWidget({
    super.key,
    required this.qrCode,
    this.failed = false,
  });
  String qrCode;
  bool failed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 50,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.amber, borderRadius: BorderRadius.circular(10)),
          width: 200,
          height: 200,
          padding: EdgeInsets.all(10),
          child: failed
              ? Image.asset(qrCode)
              : SvgPicture.network(
                  qrCode,
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
