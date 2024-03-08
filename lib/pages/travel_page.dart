import 'package:flutter/material.dart';

// TravelPage is a statefulWidget which allows for mutable state within the widget.
class TravelPage extends StatefulWidget {
  const TravelPage({super.key});

  @override
  State<TravelPage> createState() => _TravelPageState();
}

class _TravelPageState extends State<TravelPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("旅拍"),),
      body: const Text("旅拍"),
    );
  }
}
