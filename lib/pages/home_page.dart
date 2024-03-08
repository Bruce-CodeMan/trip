import 'package:flutter/material.dart';

// Custom imports:
// Imports the login data access object to handle the logout functionality.
import 'package:trip/dao/login_dao.dart';

// HomePage is a StatefulWidget which allows for mutable state within the widget
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

// This mixin ensures that the state is preserved after the widget is built, which
// is useful for keeping the scroll position, text field content, etc.
// When the widget is off-screen but still part of the widget tree.
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin{

  // _logoutBtn is a getter that creates an ElevatedButton for logging out.
  get _logoutBtn => ElevatedButton(onPressed: (){
    LoginDao.logout();
  }, child: const Text("退出"));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text("首页"), actions: [
        _logoutBtn
      ],),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


