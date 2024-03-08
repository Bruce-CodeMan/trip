import 'package:flutter/material.dart';

// Custom import pages
import 'package:trip/pages/home_page.dart';
import 'package:trip/pages/my_page.dart';
import 'package:trip/pages/search_page.dart';
import 'package:trip/pages/travel_page.dart';
// Custom import utils
import 'package:trip/utils/navigator_util.dart';

// TabNavigator is a statefulWidget which manages a bottom navigation bar with multiple tabs.
class TabNavigator extends StatefulWidget {
  const TabNavigator({super.key});

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator> {

  final PageController _controller = PageController(initialPage: 0);

  // The current index of the selected tab
  int _currentIndex = 0;

  // The default color for the icons in the bottom navigation bar.
  final _defaultColor = Colors.grey;

  // The color for the icons when a tab is active in the bottom navigation bar.
  final _activeColor = Colors.lightBlue;

  @override
  Widget build(BuildContext context) {
    // Updates the current context in the NavigatorUtil with the build context.
    NavigatorUtil.updateContext(context);
    return Scaffold(

      // The PageView which displays the page for the selected tab.
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: const [HomePage(), SearchPage(), TravelPage(), MyPage()],
      ),

      // The BottomNavigationBar which allows the users to select a tab to view.
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          // Changes the current page in the PageView when a tab item is tapped.
          _controller.jumpToPage(index);
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          _bottomItem("首页", Icons.home),
          _bottomItem("搜索", Icons.search),
          _bottomItem("旅拍", Icons.travel_explore),
          _bottomItem("我的", Icons.account_circle)
        ],
      ),
    );
  }

  /// Creates a [BottomNavigationBarItem] with the provided [title] & [icon]
  ///
  /// It uses [_defaultColor] for the icon when it is inactive and
  /// [_activeColor] when the tab is active.
  _bottomItem(String title, IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor,),
      activeIcon: Icon(icon, color: _activeColor,),
      label: title
    );
  }
}
