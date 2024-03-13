import 'package:flutter/material.dart';

/// Defines three states for the SearchBar
/// home - the style used by default on the homePage
/// normal - the style used on the searchPage
/// homeLight - the style used on the homePage after scrolling up
enum SearchBarType {
  home,
  normal,
  homeLight
}

/// A custom widget which displays three states for the SearchBar
class SearchBarWidget extends StatefulWidget {
  /// Indicates whether to hide the left back arrow button
  final bool? hideLeft;
  /// The type of search bar to be displayed
  final SearchBarType searchBarType;
  /// Placeholder text for the search field
  final String? hint;
  /// Default text to display in the search field
  final String? defaultText;
  /// Callback for left button tap
  final void Function()? leftButtonCallback;
  /// Callback for right button tap
  final void Function()? rightButtonCallback;
  /// Callback for when the input field is tapped
  final void Function()? inputCallback;
  /// Callback for when the input text changes
  final ValueChanged<String>? onChanged;

  const SearchBarWidget({
    super.key,
    this.hideLeft,
    this.searchBarType = SearchBarType.normal,
    this.hint,
    this.defaultText,
    this.leftButtonCallback,
    this.rightButtonCallback,
    this.inputCallback,
    this.onChanged
  });

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  /// Flag to show clear button when there is text to clear
  bool showClear = false;
  /// Controller for the text field
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set the default text in the controller if provided.
    if(widget.defaultText != null) {
      _controller.text = widget.defaultText!;
    }
  }

  /// Builds a normal searchBar UI with a back button, input field and search button.
  get _normalSearchBar => Row(
    children: [
      // Left: Wrap the back button with a touch detector
      _wrapTap(
          Padding(
            padding: const EdgeInsets.fromLTRB(6, 5, 10, 5),
            child: _backBtn,
          ),
          widget.leftButtonCallback
      ),
      // Center: Input field for search text.
      Expanded(child: _inputBox),
      // Right: Search button
      _wrapTap(
          const Padding(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Text("搜索", style: TextStyle(fontSize: 17, color: Colors.blue),)
          ),
          widget.rightButtonCallback
      )
    ],
  );

  /// Builds the home searchBar UI with a city selection, input field and logout button
  get _homeSearchBar => Row(
    children: [
      // Left: Wrap the city selection with a touch detector
      _wrapTap(
        Container(
          padding: const EdgeInsets.fromLTRB(6, 5, 5, 5),
          child: Row(
            children: [
              Text("上海", style: TextStyle(color: _homeFontColor, fontSize: 17),),
              Icon(Icons.expand_more, color: _homeFontColor, size: 22,)
            ],
          ),
        ),
        widget.leftButtonCallback
      ),
      // Center: Input field for search text.
      Expanded(child: _inputBox),
      // Right: Logout button
      _wrapTap(
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
          child: Text(
            "登出",
            style: TextStyle(color: _homeFontColor, fontSize: 16),
          ),
        ),
        widget.rightButtonCallback
      )
    ],
  );

  /// Determines the font color for the home searchBar based on the current type
  get _homeFontColor => widget.searchBarType == SearchBarType.homeLight
      ? Colors.black45
      : Colors.white;

  /// The back button widget which is hidden based on the hideLeft flag.
  get _backBtn => widget.hideLeft ?? false
      ? null
      : const Icon(
          Icons.arrow_back_ios,
          color: Colors.grey,
          size: 26,
        );

  /// Builds the input box with a search icon, text field and clear button
  get _inputBox {
    Color inputBoxColor;
    // Determines the color of the searchBar based on its type.
    if(widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    }else {
       inputBoxColor = const Color(0xffededed);
    }
    return Container(
      height: 36,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
          widget.searchBarType == SearchBarType.normal ? 5: 15
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal
                ? const Color(0xffa9a9a9)
                : Colors.blue
          ),
          Expanded(child: _textField),
          if(showClear)
            _wrapTap(
              const Icon(
                Icons.clear,
                size: 22,
                color: Colors.grey,
              ), () {
                setState(() {
                  _controller.clear();
                });
                _onChanged("");
            })
        ],
      ),
    );
  }

  /// Helper method to wrap a child widget with a GestureDetector for taps
  _wrapTap(Widget? child, void Function()? callback) {
    return GestureDetector(onTap: callback, child: child);
  }

  /// The text field widget for input, shown for the normal search bar type
  get _textField => widget.searchBarType == SearchBarType.normal
      ? TextField(
        controller: _controller,
        onChanged: _onChanged,
        autofocus: true,
        cursorColor: Colors.blue,
        cursorHeight: 20,
        style: const TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.w300
        ),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: 5, bottom: 12, right: 5),
          border: InputBorder.none,
          hintText: widget.hint,
          hintStyle: const TextStyle(fontSize: 15)
        ),
      )
      : _wrapTap(
          Text(
            widget.defaultText ?? "",
            style: const TextStyle(fontSize: 13, color: Colors.grey),
          ),
          widget.inputCallback
      );

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal ?
        _normalSearchBar : _homeSearchBar;
  }

  /// Handles the text change event, updating the clear button and performing the callback
  void _onChanged(String value) {
    setState(() {
      showClear = value.isNotEmpty;
    });
    if(widget.onChanged != null) {
      widget.onChanged!(value);
    }
  }
}


