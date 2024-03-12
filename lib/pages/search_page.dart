import 'package:flutter/material.dart';
import 'package:trip/widgets/search_bar_widget.dart';

// SearchPage is a statefulWidget which allows for mutable state within the widget.
class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("搜索", style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: const [
          SearchBarWidget(searchBarType: SearchBarType.home,),
          SearchBarWidget(),
          SearchBarWidget(searchBarType: SearchBarType.homeLight,)
        ],
      ),
    );
  }
}
