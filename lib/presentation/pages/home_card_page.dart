import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:mydigital_id/app/constants/shared_const.dart';
import 'package:mydigital_id/data/model/company_model.dart';
import 'package:mydigital_id/data/model/user_model.dart';
import 'package:mydigital_id/data/sources/api/api_post.dart';
import 'package:mydigital_id/domain/entities/company.dart';
import 'package:mydigital_id/presentation/widgets/drawer_widget.dart';
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
      body: ListView(
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
              //show bottom sheet all the way to the card that shows the detail of the tapped index info
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  final company = companies[index];
                  return Container(
                    decoration: BoxDecoration(
                        color: color.secondaryContainer,
                        borderRadius: BorderRadius.circular(20.0)),
                    padding: const EdgeInsets.symmetric(horizontal: 28.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const CircleAvatar(
                            radius: 30,
                            child: Icon(
                              Icons.join_right,
                              size: 50,
                            )),
                        ListTile(title: Text('Name : ${company.name}')),
                        ListTile(
                          title: Text('Email : ${company.email}'),
                        ),
                        ListTile(
                          title: Text('Phone Number : ${company.phoneNumber}'),
                        ),
                        ListTile(
                          title: Text('Address : ${company.address}'),
                        ),
                      ],
                    ),
                  );
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
      final response = await APIPost()
          .getRequest(route: route, token: token, context: context);
      if (response.statusCode == 200) {
        final List<dynamic> responseData = response.data;
        try {
          final companies = responseData
              .map((e) =>
                  CompanyModel.fromJson(e as Map<String, dynamic>).toEntity())
              .toList();
          ref.read(companyProvider.notifier).state = companies;
        } catch (e) {
          print('Error processing data: $e');
        }
      }
    }
  }
}
