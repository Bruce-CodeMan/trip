import 'package:flutter/material.dart';

import '../models/home_model.dart';

/// A custom widget which displays a navigation sub-menu based on a provided list
/// of [CommonModel]
///
/// It assumes that [CommonModel] contains at least an icon & a title which can be
/// used to render individual items in the sub-navigation.
/// The widget is designed to display the items in two rows, with the number of items
/// in the first row being calculated dynamically.
class SubNavWidget extends StatelessWidget {

  /// If the list is null, the widget will not display any items.
  final List<CommonModel>? subNav;
  const SubNavWidget({super.key, required this.subNav});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(7, 0, 7, 4),
      decoration: BoxDecoration(
        color: Colors.white, borderRadius: BorderRadius.circular(6)
      ),
      child: Padding(
        padding: const EdgeInsets.all(7),
        child: _items(context),
      ),
    );
  }

  /// This method creates sub-navigation items from [subNav]
  ///
  /// If [subNav] is null, it returns null, otherwise it creates a list of
  /// items and arranges them in a column containing two rows.
  Widget? _items(BuildContext context) {
    if(subNav == null) {
      return null;
    }
    List<Widget> items = [];
    for (var model in subNav!) {
      items.add(_item(context, model));
    }
    
    /// Calculates the number of the items to display in the first row.
    /// This calculates assumes that the first row should have one more item
    /// than the second row if the total number of items is odd
    int separate = (subNav!.length / 2 + 0.5).toInt();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: items.sublist(0, separate),
        ),
        Padding(
            padding: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.sublist(separate, subNav!.length),
          ),
        )
      ],
    );
  }

  /// This method creates an individual sub-navigation item.
  ///
  /// Each item is a gesture detector which wraps an image on the top & a text on
  /// the bottom ,it uses the [CommonModel.icon] as the image and [CommonModel.title]
  /// as the text label.
  _item(BuildContext context, CommonModel model) {
    return Expanded(
      child: GestureDetector(
        onTap: (){},
        child: Column(
          children: [
            Image.network(
              model.icon!,
              width: 18,
              height: 18,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 3),
              child: Text(
                model.title!,
                style: const TextStyle(fontSize: 12),
              ),
            )
          ],
        ),
      ),
    );
  }
}
