import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../dao/travel_dao.dart';
import '../models/travel_tab_model.dart';

class TravelTabPage extends StatefulWidget {

  final String groupChannelCode;
  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> {

  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool _isLoading = true;
  final String pageSize = dotenv.get("TRAVEL_PAGE_SIZE", fallback: "10");

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [Text('groupChannelCode: ${jsonEncode(travelItems)}')],
      ),
    );
  }

  void _loadData({loadMore=false}) {
    TravelDao.getTravels(
        widget.groupChannelCode,
        pageIndex,
        int.parse(pageSize)
    ).then((TravelTabModel? model){
      List<TravelItem> items = _filterItems(model?.list);
      setState(() {
        _isLoading = false;
        if(loadMore) {
          travelItems.addAll(items);
        }else{
          travelItems = items;
        }
      });
    }).catchError((e){
      _isLoading = false;
      debugPrint(e.toString());
    });
  }

  /// Handles the list if the article is null
  List<TravelItem> _filterItems(List<TravelItem>? list){
    if(list == null) return [];
    List<TravelItem> filterItems = [];
    for (var item in list) {
      if(item.article != null) {
        filterItems.add(item);
      }
    }
    return filterItems;
  }
}
