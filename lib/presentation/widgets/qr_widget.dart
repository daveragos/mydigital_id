import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mydigital_id/app/theme/theme.dart';
import 'package:mydigital_id/app/utils/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mydigital_id/domain/entities/company.dart';

import 'package:mydigital_id/presentation/providers/providers.dart';

class QRWidget extends ConsumerStatefulWidget {
  const QRWidget({super.key});

  @override
  ConsumerState<QRWidget> createState() => _QRWidgetState();
}

class _QRWidgetState extends ConsumerState<QRWidget> {
  @override
  void initState() {
    super.initState();
    getCompany();
  }

  late List<Company> company;
  late int companyIndex;
  late Company selectedCompany;
  late String qr;
  bool isNull = false;
  @override
  Widget build(BuildContext context) {
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
            selectedCompany.qr,
            semanticsLabel: 'Scan for more info',
            placeholderBuilder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
            // You can customize other properties as needed
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
          Text(
            selectedCompany.name,
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

  void getCompany() {
    company = ref.watch(companyProvider);
    if (company.isEmpty) {
      setState(() {
        isNull = true;
        qr = 'assets/images/Asset2.png';
      });
    } else {
      setState(() {
        isNull = false;
      });
    }

    companyIndex = ref.watch(selectedCompanyProvider);
    selectedCompany = company[companyIndex];
  }
}
