import 'package:flutter/material.dart';
import 'package:trip/utils/navigator_util.dart';

import '../models/search_model.dart';

// A constant list of strings representing different types of search items.
const types = [
  'channelgroup',
  'channelgs',
  'channelplane',
  'channeltrain',
  'cruise',
  'district',
  'food',
  'hotel',
  'huodong',
  'shop',
  'sight',
  'ticket',
  'travelgroup'
];

/// A custom widget which represents a search item.
class SearchItemWidget extends StatelessWidget {

  // The search model containing search information.
  final SearchModel searchModel;
  // The search item containing individual item data.
  final SearchItem searchItem;

  const SearchItemWidget({super.key, required this.searchItem, required this.searchModel});

  // Private getter which creates the visual representation of a search item.
  get _item => Container(
    padding: const EdgeInsets.all(10),
    decoration: const BoxDecoration(
      // Bottom border for each search item.
      border: Border(bottom: BorderSide(width: 0.3, color: Colors.grey))
    ),
    child: Row(
      children: [
        _iconContainer,
        Column(
          children: [
            SizedBox(
              width: 300,
              child: _title
            ),
            Container(
              width: 300,
              margin: const EdgeInsets.only(top: 5),
              child: _subTitle,
            )
          ],
        )
      ],
    ),
  );

  // Private getter which creates the title of a search item, highlighting the keyword.
  get _title {
    List<TextSpan> spans = [];
    spans.addAll(_keywordTextSpans(searchItem.word, searchModel.keyword ?? ''));
    spans.add(TextSpan(
      text: '${searchItem.districtname ?? ''} ${searchItem.zonename ?? ''}',
      style: const TextStyle(fontSize: 16, color: Colors.grey)
    ));
    return RichText(text: TextSpan(children: spans));
  }

  // Private getter which creates the subtitle of a search item.
  get _subTitle => RichText(
    text: TextSpan(
      children: [
        TextSpan(
          text: searchItem.price ?? "",
          style: const TextStyle(fontSize: 16, color: Colors.orange)
        ),
        TextSpan(
          text: ' ${searchItem.star ?? ""} ',
          style: const TextStyle(fontSize: 12, color: Colors.grey)
        )
      ]
    )
  );

  // Private getter which creates the icon containing based on the search item type.
  get _iconContainer => Container(
    margin: const EdgeInsets.all(1),
    child: Image(
      height: 26,
      width: 26,
      image: AssetImage(_typeImage(searchItem.type)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        NavigatorUtil.jumpToH5(url: searchItem.url, title: '详情');
      },
      child: _item,
    );
  }

  // Method to determine the image path for the item type icon.
  String _typeImage(String? type) {
    if (type == null) return 'images/type_travelgroup.png';
    String path = 'travelgroup';
    for (final val in types) {
      if(type.contains(val)) {
        path = val;
        break;
      }
    }
    return 'images/type_$path.png';
  }

  // Method to create a list of TextSpans with highlighted keywords.
  List<TextSpan> _keywordTextSpans(String? word, String keyword) {
    List<TextSpan> spans = [];
    if(word == null || word.isEmpty) return spans;
    // Lowercase the word and keyword for case-insensitive matching.
    String wordL = word.toLowerCase(), keywordL = keyword.toLowerCase();
    TextStyle normalStyle = const TextStyle(fontSize: 16, color: Colors.black87);
    TextStyle keywordStyle = const TextStyle(fontSize: 16, color: Colors.orange);
    // 'wordwoc'.split('w') -> [, 'ord', 'oc']
    List<String> arr = wordL.split(keywordL);
    int preIndex = 0;
    for (int i = 0; i< arr.length; i++) {
      if(i != 0) {
        // Highlighting the keyword by ignoring case sensitivity.
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
          text: word.substring(preIndex, preIndex + keyword.length),
          style: keywordStyle
        ));
      }
      String val = arr[i];
      if(val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
