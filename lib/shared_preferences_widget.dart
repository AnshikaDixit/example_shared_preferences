import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var nameController = TextEditingController();

  static const String keyname = "name";
  var nameValue = "";

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shared Pref'),
        ),
        body: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  label: const Text('Name'),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(21))),
            ),
            const SizedBox(
              height: 11,
            ),
            ElevatedButton(
                onPressed: () async {
                  

                  var prefs = await SharedPreferences.getInstance();

                  prefs.setString(keyname, nameController.text.toString());
                },
                child: const Text('Save')),
            const SizedBox(
              height: 11,
            ),
            Text(nameValue),
          ],
        )));
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();

    var getName = prefs.getString(keyname);

    nameValue = getName ?? "no value saved";

    setState(
      () {},
    );
  }
}
