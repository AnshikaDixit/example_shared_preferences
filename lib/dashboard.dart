import 'package:example_shared_preferences/login.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late SharedPreferences logindata;
  late bool newuser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "this is the dashboard page",
            textScaleFactor: 2,
          ),
          FloatingActionButton(
            onPressed: () async {
              final SharedPreferences logindata =
                  await SharedPreferences.getInstance();

              logindata.remove('email');
              logindata.remove('password');
              logindata.remove('login');

              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            },
            child: const Text('LogOut'),
          ),
        ],
      ),
    )));
  }
}
