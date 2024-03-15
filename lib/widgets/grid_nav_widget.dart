import 'package:flutter/material.dart';
import 'package:trip/models/home_model.dart';
import 'package:trip/utils/navigator_util.dart';

/// A custom widget which displays a grid navigation layout.
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

  /// This method creates grid navigation items from top to bottom.
  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    items.add(_gridNavItem(context, gridNav.hotel!, true));
    items.add(_gridNavItem(context, gridNav.flight!, false));
    items.add(_gridNavItem(context, gridNav.travel!, false));
    return items;
  }

  /// This method creates a single navigation bar with a gradient background.
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

  /// This method creates the main item on the left side of the navigation bar.
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

  /// This method wraps a widget with a gesture detector for handling taps.
  Widget _wrapGesture(BuildContext context, Widget widget, CommonModel model) {
    return GestureDetector(
      onTap: (){
        NavigatorUtil.jumpToH5(
          url: model.url,
          title: model.title,
          statusBarColor: model.statusBarColor,
          hideAppBar: model.hideAppBar
        );
      },
      child: widget,
    );
  }

  /// This method creates the double items on the right side of the navigation bar.
  _doubleItem(BuildContext context, CommonModel topItem, CommonModel bottomItem) {
    return Column(
      children: [
        Expanded(child: _item(context, topItem, true)),
        Expanded(child: _item(context, bottomItem, false))
      ],
    );
  }

  /// This method creates a single item with an optional border.
  ///
  /// Add border to the left and bottom if it's the first item.
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
