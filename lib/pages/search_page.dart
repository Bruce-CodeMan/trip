import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:trip/dao/search_dao.dart';
import 'package:trip/models/search_model.dart';
import 'package:trip/utils/navigator_util.dart';
import 'package:trip/utils/shadow_wrap.dart';
import 'package:trip/widgets/search_bar_widget.dart';

// SearchPage is a statefulWidget which allows for mutable state within the widget.
class SearchPage extends StatefulWidget {
  final bool? hideLeft;
  final String? keyword;
  final String? hint;
  const SearchPage({super.key, this.keyword, this.hint, this.hideLeft=false});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  SearchModel? searchModel;
  String? keyword;

  get _appBar {
    // 获取刘海屏top的安全边距
    double top = MediaQuery.of(context).padding.top;
    return shadowWrap(
      child: Container(
        height: 55 + top,
        decoration: const BoxDecoration(color: Colors.white),
        padding: EdgeInsets.only(top: top),
        child: SearchBarWidget(
          hideLeft: widget.hideLeft,
          defaultText: widget.keyword,
          hint: widget.hint,
          leftButtonCallback: () => NavigatorUtil.pop(context),
          rightButtonCallback: (){},
          onChanged: _onTextChange,
        ),
      ),
      padding: const EdgeInsets.only(bottom: 5)
    );
  }

  get _listView => MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: Expanded(
        child: ListView.builder(
            itemCount: searchModel?.data?.length ?? 0,
            itemBuilder: (BuildContext context, int index) {
              return _item(index);
            }
        )
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [_appBar, _listView],
      )
    );
  }

  void _onTextChange(String value) async {
    try {
      SearchModel? model = await SearchDao.fetch(value);
      if(model == null) return;
      // 只有当，当前输入的内容和服务端返回的内容一致的时候才渲染
      if(model.keyword==value) {
        setState(() {
          searchModel = model;
        });
      }
    } catch(e) {
      debugPrint(e.toString());
    }

  }

  Widget _item(int index) {
    var item = searchModel?.data?[index];
    return Text(jsonEncode(item?.serialization()));
  }
}
