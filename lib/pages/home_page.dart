import 'package:flutter/material.dart';
import 'package:trip/dao/home_dao.dart';

// Custom imports:
// Imports the login data access object to handle the logout functionality.
import 'package:trip/dao/login_dao.dart';
import 'package:trip/models/home_model.dart';
import 'package:trip/pages/search_page.dart';
import 'package:trip/utils/navigator_util.dart';
import 'package:trip/widgets/banner_widget.dart';
import 'package:trip/widgets/grid_nav_widget.dart';
import 'package:trip/widgets/loading_container.dart';
import 'package:trip/widgets/local_nav_widget.dart';
import 'package:trip/widgets/sales_box_widget.dart';
import 'package:trip/widgets/search_bar_widget.dart';
import 'package:trip/widgets/sub_nav_widget.dart';

import '../utils/shadow_wrap.dart';

const searchBarDefaultText = "Bruce";

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
  bool _isLoading = true;
  
  // _logoutBtn is a getter that creates an ElevatedButton for logging out.
  get _logoutBtn => ElevatedButton(onPressed: (){
    LoginDao.logout();
  }, child: const Text("退出"));

  get _appBar {
    // 获取刘海屏的实际的Top安全边距
    double top = MediaQuery.of(context).padding.top;
    return Column(
      children: [
        shadowWrap(child: Container(
          padding: EdgeInsets.only(top: top),
          height: 60 + top,
          decoration: BoxDecoration(
            color: Color.fromARGB((appBarAlpha * 255).toInt(), 255, 255, 255),
          ),
          child: SearchBarWidget(
            searchBarType: appBarAlpha > 0.2
                ? SearchBarType.homeLight
                : SearchBarType.home,
            inputCallback: _jumpToSearch,
            defaultText: searchBarDefaultText,
            rightButtonCallback: (){
              LoginDao.logout();
            },
          ),
        )),
        Container(
          height: appBarAlpha > 0.2 ? 0.5 : 0,
          decoration: const BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 0.5)]
          ),
        )
      ],
    );
  }
  
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
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Stack(
          children: [_contentView, _appBar],
        ),
      ),
    );
  }

  get _contentView => MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: RefreshIndicator(
        color: Colors.blue,
        onRefresh: _handleRefresh,
        child: NotificationListener(
          onNotification: (scrollNotification){
            if(scrollNotification is ScrollUpdateNotification &&
                scrollNotification.depth == 0) {
              _onScroll(scrollNotification.metrics.pixels);
            }
            return false;
          },
          child: _listView,
        ),
      )
  );

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
      if(mounted){
        setState(() {
          HomePage.config = result.config;
          localNavList = result.localNavList ?? [];
          bannerList = result.bannerList ?? [];
          subNavList = result.subNavList ?? [];
          gridNav = result.gridNav;
          salesBox = result.salesBox;
          _isLoading = false;
        });
      }
    }catch(e) {
      debugPrint("error: ${e.toString()}");
      if(mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }

  }

  void _jumpToSearch() {
    NavigatorUtil.push(context, const SearchPage());
  }
}


