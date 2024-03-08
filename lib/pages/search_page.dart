import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text("搜索"),),
      body: const Text("搜索"),
    );
  }
}
