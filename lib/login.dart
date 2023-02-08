import 'package:example_shared_preferences/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //This key will be used to identify the state of the form.
  final _formKey = GlobalKey<FormState>();

  TextEditingController Econtroller = TextEditingController();
  TextEditingController Pcontroller = TextEditingController();
  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

  late SharedPreferences logindata;
  late bool newuser;

  var emailValue = '';
  var passValue = '';

  String? finalEmail = '';
  String? finalPass = '';

  @override
  void initState() {
    
    super.initState();
    getValue();
    checkIfAlreadyLogin();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    Econtroller.dispose();
    Pcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Shared Preferences'),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(children: [
                  // const Image(
                  //   image: AssetImage('assets/login.png')
                  // ),
                  Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.height * 0.5,
                    shadows: const <Shadow>[
                      Shadow(color: Colors.black, blurRadius: 15.0)
                    ],
                  ),
                  TextFormField(
                    controller: Econtroller,
                    onChanged: (value) async {
                      _formKey.currentState?.validate();
                    },
                    decoration: const InputDecoration(
                        label: Text('Email address'),
                        hintText: 'Please enter your email here',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please Enter Email";
                      } else if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                        return "Please Enter a Valid Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  TextFormField(
                    controller: Pcontroller,
                    onChanged: (value) {
                      _formKey.currentState?.validate();
                    },
                    decoration: const InputDecoration(
                        label: Text('Password'),
                        hintText: 'Please enter your password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        )),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter password";
                      } else {
                        //call function to check password
                        bool result = validatePassword(value);
                        if (result) {
                          // create account event
                          return null;
                        } else {
                          return " Password should contain Capital, small letter & Number & Special";
                        }
                      }
                    },
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        //initialize sp
                        var prefs = await SharedPreferences.getInstance();

                       

                        setState(() {});
                        if (_formKey.currentState!.validate()) {
                        logindata.setBool('login', true);
                          
                        prefs.setString('email', Econtroller.text);
                        prefs.setString('password', Pcontroller.text);

                          Navigator.pushNamed(context, '/Dashboard');
                        }
                        //setup initstate() to show these values on the screen when we open it next time and as we cannot make it async so we make another function to get those values.
                      },
                      child: const Text('Login')),
          
                  Text(emailValue),
                  Text(passValue),
                ]),
              ),
            ),
          ),
        ));
  }

  bool validatePassword(String pass) {
    String password = pass.trim();
    if (pass_valid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }

  void getValue() async {
    var prefs = await SharedPreferences.getInstance();

    var getEmail = prefs.getString('email');
    var getPass = prefs.getString('password');

    emailValue = getEmail ?? 'no one logged in';
    passValue = getPass ?? 'no one logged in';

    setState(() {});
  }
  
  void checkIfAlreadyLogin() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? false);
    print(newuser);
    if (newuser) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Dashboard()));
    }
  }
}

// 1- after validation, set user's login status as true
// 2- after you restart the app, check if user already exists
// 3- get login status, if true=> go to dashboard, if false => loginpage()
