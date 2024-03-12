import 'package:flutter/material.dart';
import 'package:trip/dao/home_dao.dart';

// Custom imports:
// Imports the login data access object to handle the logout functionality.
import 'package:trip/dao/login_dao.dart';
import 'package:trip/models/home_model.dart';
import 'package:trip/widgets/banner_widget.dart';
import 'package:trip/widgets/grid_nav_widget.dart';
import 'package:trip/widgets/local_nav_widget.dart';
import 'package:trip/widgets/sales_box_widget.dart';
import 'package:trip/widgets/sub_nav_widget.dart';

// HomePage is a StatefulWidget which allows for mutable state within the widget
class HomePage extends StatefulWidget {

  static Config? config;
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
  double appBarAlpha = 0;
  List<CommonModel> localNavList = [];
  List<CommonModel> bannerList = [];
  List<CommonModel> subNavList = [];
  GridNav? gridNav;
  SalesBox? salesBox;
  
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
      LocalNavWidget(localNavList: localNavList),
      if(gridNav != null) GridNavWidget(gridNav: gridNav!),
      SubNavWidget(subNav: subNavList),
      if(salesBox != null) SalesBoxWidget(salesBox: salesBox!),
      _logoutBtn,
      Text(gridNav?.flight?.item1?.title ?? ""),
      const SizedBox(
        height: 800,
        child: ListTile(
          title: Text("Bruce"),
        ),
      )
    ],
  );


  @override
  void initState() {
    super.initState();
    _handleRefresh();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
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
    double alpha = offset / appBarScrollOffset;
    if(alpha < 0) {
      alpha = 0;
    }else if(alpha > 1) {
      alpha = 1;
    }
    setState(() {
      appBarAlpha = alpha;
    });
  }

  Future<void> _handleRefresh() async{
    try{
      HomeModel result = await HomeDao.fetch();
      setState(() {
        HomePage.config = result.config;
        localNavList = result.localNavList ?? [];
        bannerList = result.bannerList ?? [];
        subNavList = result.subNavList ?? [];
        gridNav = result.gridNav;
        salesBox = result.salesBox;
      });
    }catch(e) {
      debugPrint("error: ${e.toString()}");
    }

  }
}


