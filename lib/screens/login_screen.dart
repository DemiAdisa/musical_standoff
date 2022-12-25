import 'package:flutter/material.dart';
import 'package:musical_standoff/dependencies/capsule_button.dart';

import '../dependencies/color_list.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late double? _deviceWidth;

  late double? _deviceHeight;

  String? _email;
  String? _password;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth! * 0.09),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              mainAxisSize: MainAxisSize.max,
              children: [
                SizedBox(
                  width: _deviceWidth! * 0.6,
                  height: _deviceHeight! * 0.6,
                  child: Image.asset(
                      "assets/Logo_Files/png/logo-color-circle.png"),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      _emailField(),
                      const SizedBox(
                        height: 6,
                      ),
                      _passwordField(),
                    ],
                  ),
                ),
                CapsuleButton(
                  buttonText: "Login",
                  buttonCallback: () {
                    if(_formKey.currentState!.validate()) {

                    }
                  },
                ),
                _registerPageNav (),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Email Address",
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: ColorList().yellow(),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      onSaved: (value) {
        _email = value;
      },
      validator: (value) {
        bool result = value!.contains(RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"));

        return result ? null : "Please Input a Valid Email";
      },
    );
  }

  Widget _passwordField() {
    return TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        hintText: "Password",
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: ColorList().yellow(),
          ),
          borderRadius: const BorderRadius.all(Radius.circular(20.0)),
        ),
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      onSaved: (value) {
        _password = value;
      },
      validator: (value) =>
          value!.length > 8 ? null : "Please Input a Password greater than 8",
    );
  }

  Widget _registerPageNav () {
    return GestureDetector(
      onTap: (){Navigator.pushNamed(context, "register_page");},
      child: const Text("Don't have an account? Register with Us!", style: TextStyle(color: Colors.blue),),
    );
  }
}
