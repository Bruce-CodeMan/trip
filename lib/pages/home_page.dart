import 'package:flutter/material.dart';

// Custom imports:
// Imports the login data access object to handle the logout functionality.
import 'package:trip/dao/login_dao.dart';
import 'package:trip/widgets/banner_widget.dart';

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

  final bannerList = [
    "https://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg",
    "https://o.devio.org/images/fa/cat-4098058__340.webp",
    "https://o.devio.org/images/fa/photo-1601513041797-a79a526a521e.webp",
    "https://o.devio.org/images/other/as-cover.png"
  ];
  
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
      body: Column(
        children: [BannerWidget(bannerList: bannerList)],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}


