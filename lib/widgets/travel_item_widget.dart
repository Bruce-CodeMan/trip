import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/travel_tab_model.dart';

class TravelItemWidget extends StatelessWidget {

  final TravelItem item;
  final int? index;

  const TravelItemWidget({super.key, required this.item, this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // 设置一个最小的高度，防止图片上滑的时候，出现一个闪动
      constraints: BoxConstraints(minHeight: size.width / 2 - 10),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: item.article?.images?[0].dynamicUrl ?? "",
        fit: BoxFit.cover,
      ),
    );
  }
}
