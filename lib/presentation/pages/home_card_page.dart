// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
import 'package:mydigital_id/domain/entities/company.dart';

class HomeCardScreen extends ConsumerStatefulWidget {
  const HomeCardScreen({super.key});

  @override
  ConsumerState<HomeCardScreen> createState() => _HomeCardScreenState();
}

class _HomeCardScreenState extends ConsumerState<HomeCardScreen> {
  @override
  void initState() {
    super.initState();
    getCompanies();
  }

  bool isempty = false;
  List<Company> companies = [];
  bool isLoading = false;
  bool failed = false;

  void getCompanies() async {
    setState(() => isLoading = true);

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
            companies = responseData
                .map((e) =>
                    CompanyModel.fromJson(e as Map<String, dynamic>).toEntity())
                .toList();
            ref.read(companyProvider.notifier).state = companies;
            setState(() {
              isempty = false;
            });
          } catch (e) {
            print(e);
          }
        }
      }
      if (response.statusCode == 404) {
        final responseData = response.data;
        try {
          Company company = CompanyModel.fromJson(responseData).toEntity();
          companies.add(company);
          ref.read(companyProvider.notifier).state = [company];
          setState(() {
            isempty = false;
          });
          setState(() {
            failed = true;
          });
        } catch (e) {
          print(e);
        }
      }
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    final selectedCompany = ref.watch(selectedCompanyProvider);
    final color = context.colorScheme;
    return Scaffold(
      backgroundColor: color.secondaryContainer,
      drawer: BuildDrawer(color: color, context: context),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : isempty
              ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: [Text('no data')],
                )
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Theme.of(context).primaryColor,
                              child: const Row(
                                children: [
                                  CircleAvatar(),
                                  Text(
                                    'User',
                                  )
                                ],
                              ),
                            ),
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                Badge(
                                  child: const Text('3'),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      Flexible(
                          child: SingleChildScrollView(
                        child: ListView.builder(
                          itemCount: companies.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {},
                              title: Text(companies[index].name),
                            );
                          },
                        ),
                      )),
                    ],
                  ),
                ),
    );
  }
}
/*
Swiper(
                      index: selectedCompany,
                      itemCount: companies.length,
                      allowImplicitScrolling: true,
                      loop: true,
                      onIndexChanged: (index) {
                        ref.read(selectedCompanyProvider.notifier).state =
                            index;
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
                        return CardWidget(
                          companies: companies,
                          failed: failed,
                        );
                      },
                    ),
                    QRWidget(
                      company: companies,
                      failed: failed,
                    ),
*/