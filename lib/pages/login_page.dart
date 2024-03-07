import 'package:flutter/material.dart';

// Custom Imports
import 'package:trip/widgets/input_widget.dart';

// Login Page
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  // Variables to store the username & password
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
            },
          ),
          const SizedBox(height: 10,),
          InputWidget(
            "请输入密码",
            onChanged: (text) {
              password = text;
            },
          ),
        ],
      ),
    );
  }
}
