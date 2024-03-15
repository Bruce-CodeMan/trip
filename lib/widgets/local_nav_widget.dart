import 'package:flutter/material.dart';
import 'package:trip/utils/navigator_util.dart';

import '../models/home_model.dart';

/// A custom widget which displays a row of local navigation items.
///
/// Each item contains of an icon on the top & a text on the bottom.
class LocalNavWidget extends StatelessWidget {

  final List<CommonModel> localNavList;
  const LocalNavWidget({super.key, required this.localNavList});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 4, 7, 4),
      height: 64,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6))
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  /// This method is responsible for creating a row of navigation items.
  /// It iterates over the [localNavList] and builds an item for each model.
  Widget _items(BuildContext context) {
    List<Widget> items = [];
    for (var model in localNavList) {
      items.add(_item(context, model));
    }
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: items);
  }

  /// The method creates a single navigation item widget.
  /// This widget will be used to each [CommonModel] in the row.
  ///
  /// The item contains of a [Image] widget for the icon & a [Text] widget for the text.
  /// The [GestureDetector] wraps the item allowing it to be tapped with an empty callback.
  Widget _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        NavigatorUtil.jumpToH5(
          url: model.url,
          title: model.title,
          statusBarColor: model.statusBarColor,
          hideAppBar: model.hideAppBar
        );
      },
      child: Column(
        children: [
          Image.network(model.icon!, width: 32, height: 32,),
          Text(model.title!, style: const TextStyle(fontSize: 12),)
        ],
      ),
    );
  }
}
