import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:trip/widgets/loading_container.dart';
import 'package:trip/widgets/travel_item_widget.dart';

import '../dao/travel_dao.dart';
import '../models/travel_tab_model.dart';

class TravelTabPage extends StatefulWidget {

  final String groupChannelCode;
  const TravelTabPage({super.key, required this.groupChannelCode});

  @override
  State<TravelTabPage> createState() => _TravelTabPageState();
}

class _TravelTabPageState extends State<TravelTabPage> with AutomaticKeepAliveClientMixin{

  List<TravelItem> travelItems = [];
  int pageIndex = 1;
  bool _isLoading = true;
  final String pageSize = dotenv.get("TRAVEL_PAGE_SIZE", fallback: "10");
  final ScrollController _scrollController = ScrollController();

  get _gridView => MasonryGridView.count(
    controller: _scrollController,
    crossAxisCount: 2,    // 2列布局
    itemCount: travelItems.length,
    itemBuilder: ((BuildContext context, int index) =>
      TravelItemWidget(item: travelItems[index], index: index))
  );

  @override
  void initState() {
    _loadData();
    _scrollController.addListener(() {
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        _loadData(loadMore: true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: RefreshIndicator(
          onRefresh: _loadData,
          child: MediaQuery.removePadding(removeTop: true, context: context, child: _gridView),
        ),
      ),
    );
  }

  Future<void> _loadData({loadMore=false}) async{
    if(loadMore) {
      pageIndex++;
    }else {
      pageIndex = 1;
    }
    try{
      TravelTabModel? model = await TravelDao.getTravels(widget.groupChannelCode, pageIndex, int.parse(pageSize));
      List<TravelItem> items = _filterItems(model?.list);
      if(loadMore && items.isEmpty) {
        pageIndex--;
      }
      setState(() {
        _isLoading = false;
        if(loadMore) {
          travelItems.addAll(items);
        }else{
          travelItems = items;
        }
      });
    }catch(e) {
      debugPrint("e: $e");
      _isLoading = false;
      if(loadMore) {
        pageIndex--;
      }
    }

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

  @override
  bool get wantKeepAlive => true;

}
