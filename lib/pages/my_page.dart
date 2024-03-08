import 'package:flutter/material.dart';

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
      body: const Text("我的"),
    );
  }
}
