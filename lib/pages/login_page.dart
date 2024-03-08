import 'package:flutter/material.dart';
import 'package:trip/dao/login_dao.dart';
import 'package:trip/utils/navigator_util.dart';

// Custom Imports
import 'package:trip/widgets/input_widget.dart';
import 'package:trip/widgets/login_button.dart';

import '../utils/string_util.dart';

// LoginPage is a statefulWidget which allows for mutable state within the widget.
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Variables to store the username & password
  bool isPressed = false;
  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Stack widget allows the overlapping of widgets
      body: Stack(
        children: [
          ..._background(),       // Background widget
          _content()              // Content widget
        ],
      )
    );
  }

  // Background method
  _background() {
    return [
      // Position.fill will expand the child to fill the available space
      Positioned.fill(
          child: Image.asset("images/login_bg.jpg", fit: BoxFit.cover)
      ),
      // Position.fill with a container to apply a dark overlay on the background image
      Positioned.fill(
          child: Container(decoration: const BoxDecoration(color: Colors.black45),)
      ),
    ];
  }

  // Content method
  _content() {
    return Positioned.fill(
      left: 20,
      right: 20,
      // ListView provides a scrolling view which is good for small screen devices.
      child: ListView(
        children: [
          const SizedBox(height: 100, width: 1,),
          const Text(
            "账号密码登录",
            style: TextStyle(fontSize: 26, color: Colors.white),
          ),
          const SizedBox(height: 40,),
          InputWidget(
            "请输入账号",
            onChanged: (text){
              username = text;
              _checkInput();
            },
          ),
          const SizedBox(height: 10,),
          InputWidget(
            "请输入密码",
            onChanged: (text) {
              password = text;
              _checkInput();
            },
            obscureText: true,
          ),
          const SizedBox(height: 45,),
          LoginButton(
            title: "登录",
            isPressed: isPressed,
            onPressed: () => _login(context),
          )
        ],
      ),
    );
  }


  void _login(context) async {
    try {
      LoginDao.login(username: username!, password: password!);
      NavigatorUtil.goToHome(context);
    } catch(e) {
      print("e: $e");
    }

  }

  // Defines the function to evaluate the input fields.
  void _checkInput() {
    bool enable;
    if(isNotEmpty(username) && isNotEmpty(password)) {
      enable = true;
    }else {
      enable = false;
    }
    // Call the setState function to update the UI with the new state.
    setState(() {
      isPressed = enable;
    });
  }
}
