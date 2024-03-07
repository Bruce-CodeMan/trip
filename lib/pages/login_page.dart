import 'package:flutter/material.dart';

// 登录界面
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String? username;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ..._background(),
          _content()
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

  _content() {
    return Positioned.fill(
      left: 20,
      right: 20,
      // 适配小屏幕手机可以支持滚动
      child: ListView(
        children: const [
          SizedBox(height: 100, width: 1,),
          Text("账号密码登录", style: TextStyle(fontSize: 26, color: Colors.white),),
          SizedBox(height: 40,)
        ],
      ),
    );
  }
}
