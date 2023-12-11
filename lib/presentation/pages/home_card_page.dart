// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:mydigital_id/app/constants/shared_const.dart';
import 'package:mydigital_id/data/model/company_model.dart';
import 'package:mydigital_id/data/model/user_model.dart';
import 'package:mydigital_id/data/sources/api/api_post.dart';
import 'package:mydigital_id/presentation/widgets/detail_widget.dart';
import 'package:mydigital_id/presentation/widgets/drawer_widget.dart';
import 'package:mydigital_id/presentation/widgets/no_card_widget.dart';
import 'package:mydigital_id/presentation/widgets/no_qr_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../app/utils/extensions.dart';
import '../providers/providers.dart';
import '../widgets/card_widget.dart';
import '../widgets/qr_widget.dart';

class HomeCardScreen extends ConsumerStatefulWidget {
  const HomeCardScreen({super.key});

  @override
  ConsumerState<HomeCardScreen> createState() => _CreditCardScreenState();
}

class _CreditCardScreenState extends ConsumerState<HomeCardScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  var isempty = false;
  @override
  Widget build(BuildContext context) {
    // final user = ref.watch(userStateNotifierProvider);
    final companies = ref.watch(companyProvider.notifier).state;
    final selectedCompany = ref.watch(selectedCompanyProvider);
    final color = context.colorScheme;
    return Scaffold(
      backgroundColor: color.secondaryContainer,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Digital Cards'),
      ),
      drawer: BuildDrawer(color: color, context: context),
      body: isempty
          ? ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Swiper(
                  index: 0,
                  itemCount: 1,
                  allowImplicitScrolling: true,
                  loop: true,
                  layout: SwiperLayout.TINDER,
                  itemWidth: 400,
                  itemHeight: 250,
                  itemBuilder: (BuildContext context, int index) {
                    return const NoCardWidget();
                  },
                ),
                const NoQRWidget(),
              ],
            )
          : ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              children: [
                Swiper(
                  index: selectedCompany,
                  itemCount: companies.length,
                  allowImplicitScrolling: true,
                  loop: true,
                  onIndexChanged: (index) {
                    ref.read(selectedCompanyProvider.notifier).state = index;
                  },
                  onTap: (index) {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        final company = companies[index];
                        return DetailWidget(color: color, company: company);
                      },
                    );
                  },
                  layout: SwiperLayout.TINDER,
                  itemWidth: 400,
                  itemHeight: 250,
                  itemBuilder: (BuildContext context, int index) {
                    return const CardWidget();
                  },
                ),
                const QRWidget(),
              ],
            ),
    );
  }

  void getUser() async {
    //todo no working
    SharedPreferences pref = await SharedPreferences.getInstance();
    final token = pref.getString(SharedConst.token);
    final user = pref.getString(SharedConst.user);
    if (token != null && user != null) {
      final json = jsonDecode(user);
      final userModel = UserModel.fromJson(json);
      final userEntity = userModel.toEntity();
      ref.read(userStateProvider.notifier).state = userEntity;
      final id = userEntity.id;
      final route = 'user/$id/company';
      //todo! handle when null
      final response = await APIPost()
          .getRequest(route: route, token: token, context: context);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        if (responseData.isEmpty) {
          setState(() {
            isempty = true;
          });
        } else {
          try {
            final companies = responseData
                .map((e) =>
                    CompanyModel.fromJson(e as Map<String, dynamic>).toEntity())
                .toList();
            ref.read(companyProvider.notifier).state = companies;
          } catch (e) {
            print(e);
          }
        }
      }
    }
  }
}
