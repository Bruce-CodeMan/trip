import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// 登录界面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String name = dotenv.get("NAME", fallback: "");

  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    print("name: $name");
    return Scaffold(
      body: Stack(
        children: [
          ..._background()
        ],
      )
    );
  }

  // 背景
  _background() {
    return [
      Positioned.fill(child: Image.asset("images/login_bg.jpg", fit: BoxFit.cover)),
      Positioned.fill(child: Container(decoration: const BoxDecoration(color: Colors.black45),)),
    ];
  }


}
