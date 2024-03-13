import 'package:flutter/material.dart';
import 'package:trip/dao/travel_dao.dart';
import 'package:trip/models/travel_tab_model.dart';
import 'package:trip/pages/travel_tab_page.dart';

import '../models/travel_category_model.dart';

// TravelPage is a statefulWidget which allows for mutable state within the widget.
class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> with TickerProviderStateMixin{

  List<TravelTab> tabs = [];
  TravelCategoryModel? travelCategoryModel;
  late TabController _controller;

  get _tabBar => TabBar(
    controller: _controller,
    isScrollable: true,
    labelColor: Colors.black,
    tabs: tabs.map<Tab>((TravelTab tab){
      return Tab(text: tab.labelName);
    }).toList()
  );

  get _tabBarView => TabBarView(
    controller: _controller,
    children: tabs.map((TravelTab tab) {
      return TravelTabPage(groupChannelCode: tab.groupChannelCode);
    }).toList()
  );
  
  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 0, vsync: this);
    TravelDao.getCategory().then((TravelCategoryModel? model) {
      _controller = TabController(length: model?.tabs.length ?? 0, vsync: this);
      setState(() {
        tabs = model?.tabs ?? [];
        travelCategoryModel = model;
      });
    }).catchError((e){
      debugPrint("e: $e");
    });
  }

  @override
  void dispose() {
    super.dispose();
    // 销毁controller
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 获取刘海屏Top安全边距
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: top),
            child: _tabBar,
          ),
          Flexible(child: _tabBarView)
        ],
      ),
    );
  }
}
