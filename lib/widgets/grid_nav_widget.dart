import 'package:flutter/material.dart';
import 'package:trip/models/home_model.dart';

class GridNavWidget extends StatelessWidget {
  final GridNav gridNav;
  const GridNavWidget({super.key, required this.gridNav});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(7, 0, 7, 4), child: PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    ));
  }

  /// 从上到下添加三个导航条
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNav.hotel!, true));
    items.add(_gridNavItem(context, gridNav.flight!, false));
    items.add(_gridNavItem(context, gridNav.travel!, false));
    return items;
  }

  /// 添加导航条
  _gridNavItem(BuildContext context, Hotel hotel, bool first) {
    List<Widget> items = [];
    items.add(_mainItem(context, hotel.mainItem!));
    items.add(_doubleItem(context, hotel.item1!, hotel.item2!));
    items.add(_doubleItem(context, hotel.item3!, hotel.item4!));

    List<Widget> expandItems = [];
    for(var item in items) {
      expandItems.add(Expanded(flex: 1, child: item));
    }
    Color startColor = Color(int.parse('0xff${hotel.startColor!}'));
    Color endColor = Color(int.parse('0xff${hotel.endColor!}'));
    return Container(
      height: 80,
      margin: first ? null : const EdgeInsets.only(top: 3),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [startColor, endColor])
      ),
      child: Row(children: expandItems),
    );
  }

  /// 左侧大卡片
  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            Image.network(
              model.icon!,
              fit: BoxFit.contain,
              height: 88,
              width: 121,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: const EdgeInsets.only(top: 11),
              child: Text(
                model.title!,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ),
        model
    );
  }

  /// 手势包裹器
  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: (){

      },
      child: widget,
    );
  }

  /// 右侧的上下Item
  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false))
      ],
    );
  }

  /// 上下item, first是否为第一个item
  _item(BuildContext context, CommonModel item, bool first) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Colors.white);
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: borderSide, bottom: first ? borderSide : BorderSide.none
        ),
      ),
      child: _wrapGesture(context, Center(
        child: Text(
          item.title!,
          style: const TextStyle(fontSize: 14, color: Colors.white),
        ),
      ), item),
    );
  }
}
