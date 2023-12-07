import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/constants/path_const.dart';
import '../../app/utils/extensions.dart';
import '../providers/providers.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userStateProvider);
    final companies = ref.watch(companyProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 70,
              child: Icon(Icons.person,
                  size: 50, color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(height: 10),
            Center(
              child: Text(
                '${user.first_name} ${user.last_name}',
                style: context.textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.colorScheme.secondaryContainer),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Personal Information'),
                  ListTile(
                    leading: const Icon(Icons.email_outlined),
                    title: const Text('Email'),
                    trailing: Text(user.email),
                  ),
                  ListTile(
                    leading: const Icon(Icons.location_on_outlined),
                    title: const Text('Address'),
                    trailing: Text(user.address),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone_iphone_rounded),
                    title: const Text('Phone Number'),
                    trailing: Text('${user.phone_number}'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: context.colorScheme.tertiaryContainer),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Companies',
                    style: context.textTheme.displaySmall,
                  ),
                  ...companies.map((company) => ListTile(
                      leading: const Icon(Icons.business),
                      title: Text(company.name),
                      subtitle: Text(company.role),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios_sharp),
                        onPressed: () {
                          //setting the index of the touched to selectedCompanyProvider and popping the page
                          final index = companies.indexOf(company);
                          ref.read(selectedCompanyProvider.notifier).state =
                              index;
                          context.go(PathConst.digitalIdPath);
                        },
                      ))),
                  const Divider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
