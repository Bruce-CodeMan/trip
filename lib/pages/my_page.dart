import 'package:flutter/material.dart';
import 'package:trip/widgets/bruce_webview.dart';

// MyPage is a statefulWidget which allows for mutable state within the widget.
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的"),),
      body: const BruceWebView(
        url: "https://www.imooc.com/t/4951150#Shizhan",
        hideAppBar: true,
      ),
    );
  }
}
