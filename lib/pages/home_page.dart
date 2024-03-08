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

  static const appBarScrollOffset = 100;
  final bannerList = [
    "https://www.devio.org/io/flutter_app/img/banner/100h10000000q7ght9352.jpg",
    "https://o.devio.org/images/fa/cat-4098058__340.webp",
    "https://o.devio.org/images/fa/photo-1601513041797-a79a526a521e.webp",
    "https://o.devio.org/images/other/as-cover.png"
  ];

  double appBarAlpha = 0;
  
  // _logoutBtn is a getter that creates an ElevatedButton for logging out.
  get _logoutBtn => ElevatedButton(onPressed: (){
    LoginDao.logout();
  }, child: const Text("退出"));

  get _appBar => Opacity(
    opacity: appBarAlpha,
    child: Container(
      height: 80,
      decoration: const BoxDecoration(color: Colors.white),
      child: const Center(
        child: Padding(
            padding: EdgeInsets.only(top: 40),
          child: Text("首页"),
        ),
      ),
    ),

  );
  
  get _listView => ListView(
    children: [
      BannerWidget(bannerList: bannerList),
      _logoutBtn,
      const SizedBox(
        height: 800,
        child: ListTile(
          title: Text("Bruce"),
        ),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: [
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: NotificationListener(
              onNotification: (scrollNotification){
                if(scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.depth == 0) {
                  _onScroll(scrollNotification.metrics.pixels);
                }
                return false;
              },
              child: _listView,
            )
          ),
          _appBar
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onScroll(double offset) {
    print("offset: $offset");
    double alpha = offset / appBarScrollOffset;
    if(alpha < 0) {
      alpha = 0;
    }else if(alpha > 1) {
      alpha = 1;
    }
    print("alpha: $alpha");
    setState(() {
      appBarAlpha = alpha;
    });
    print("appBarAlpha: $appBarAlpha");
  }
}


