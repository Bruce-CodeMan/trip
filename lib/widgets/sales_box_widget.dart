import 'package:flutter/material.dart';
import 'package:trip/utils/navigator_util.dart';

import '../models/home_model.dart';

/// A custom widget which displays a box with various sales or promotional cards.
/// It requires a [SalesBox] object which contains the data for the cards.
class SalesBoxWidget extends StatelessWidget {

  final SalesBox salesBox;
  const SalesBoxWidget({super.key, required this.salesBox});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: const BoxDecoration(color: Colors.white),
      child: _items(context),
    );
  }

  /// This method creates the items of the sales box which consists of a title
  /// and several rows of cards
  Widget _items(BuildContext context) {
    List<Widget> items = [];
    items.add(_doubleItem(
        context, salesBox.bigCard1!, salesBox.bigCard2!, true, false));
    items.add(_doubleItem(
        context, salesBox.smallCard1!, salesBox.smallCard2!, false, false));
    items.add(_doubleItem(
        context, salesBox.smallCard3!, salesBox.smallCard4!, false, false));
    return Column(
      children: [
        _titleItem(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(0, 1),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(1, 2),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: items.sublist(2, 3),
        )
      ],
    );
  }

  /// This method creates a row of two cards.
  ///
  /// [leftCard] is the data for the left card.
  /// [rightCard] is the data for the right card.
  /// [big] indicates whether the card is big or not.
  /// [last] indicates whether the card is last or not.
  _doubleItem(
      BuildContext context,
      CommonModel leftCard,
      CommonModel rightCard,
      bool big,
      bool last) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _item(context, leftCard, big, true, last),
        _item(context, rightCard, big, false, last)
      ],
    );
  }

  /// This method creates an individual card item with an image.
  ///
  /// [model] provides the data for the card.
  /// [big] indicates whether the card is big or not.
  /// [left] indicates whether the card is on the left or not.
  /// [last] indicates whether the card is the last or not.
  Widget _item(BuildContext context, CommonModel model, bool big, bool left, bool last) {
    BorderSide borderSide = const BorderSide(width: 0.8, color: Color(0xfff2f2f2));
    double width = MediaQuery.of(context).size.width / 2 - 10;
    return GestureDetector(
      onTap: (){
        NavigatorUtil.jumpToH5(
          url: model.url,
          title: model.title,
          statusBarColor: model.statusBarColor,
          hideAppBar: model.hideAppBar
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            right: left ? borderSide : BorderSide.none,
            bottom: last ? BorderSide.none : borderSide
          )
        ),
        child: Image.network(
          model.icon!,
          fit: BoxFit.fill,
          width: width,
          height: big ? 136 : 80,
        ),
      ),
    );
  }

  /// This method creates the title item for the sales item.
  _titleItem() {
    return Container(
      height: 44,
      margin: const EdgeInsets.only(left: 10),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(width: 1, color: Color(0xfff2f2f2)))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network(salesBox.icon!, height: 15, fit: BoxFit.fill),
          _moreItem()
        ],
      ),
    );
  }

  /// This method creates the `more` button which allows users to navigate
  /// to more productions.
  _moreItem() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 1, 8, 1),
      margin: const EdgeInsets.only(right: 7),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(
          colors: [Color(0xffff4e63), Color(0xffff6cc9)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight
        )
      ),
      child: GestureDetector(
        onTap: (){},
        child: const Text(
          '获取更多福利 >',
          style: TextStyle(fontSize: 12, color: Colors.white)
        ),
      ),
    );
  }
}
