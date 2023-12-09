import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mydigital_id/app/constants/path_const.dart';
import 'package:mydigital_id/app/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BuildDrawer extends StatelessWidget {
  const BuildDrawer({
    super.key,
    required this.color,
    required this.context,
  });

  final ColorScheme color;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: color.primaryContainer,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/images/Asset1.png'),
                    CircleAvatar(
                      radius: 35,
                      child: Icon(Icons.qr_code,
                          size: 50, color: Colors.white.withOpacity(0.8)),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: const Text('Home'),
                onTap: () {
                  context.pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Profile'),
                onTap: () {
                  context.push(PathConst.profilePath);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {},
              ),
            ],
          ),
          ListTile(
            iconColor: primaryColor,
            trailing: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async {
              //clear the shared pref
              SharedPreferences pref = await SharedPreferences.getInstance();
              await pref.clear();
              context.go(PathConst.loginPath);
            },
          ),
        ],
      ),
    );
  }
}
