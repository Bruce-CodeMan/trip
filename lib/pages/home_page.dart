import 'package:flutter/material.dart';
import 'package:trip/dao/login_dao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  get _logoutBtn => ElevatedButton(onPressed: (){
    LoginDao.logout();
  }, child: const Text("退出"));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("首页"), actions: [
        _logoutBtn
      ],),
    );
  }
}
