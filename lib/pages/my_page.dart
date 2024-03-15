import 'package:flutter/material.dart';
import 'package:trip/widgets/bruce_webview.dart';

// MyPage is a statefulWidget which allows for mutable state within the widget.
class MyPage extends StatefulWidget {
  const MyPage({super.key});

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const Scaffold(
      body: BruceWebView(
        url: "https://m.ctrip.com/webapp/myctrip/",
        hideAppBar: true,
        backForbid: true,
        statusBarColor: '4c5bca',
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
