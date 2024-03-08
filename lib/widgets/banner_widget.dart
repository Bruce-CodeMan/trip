import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:trip/utils/screen_adapter.dart';

/// A custom Banner widget which displays a carousel slider of images(banners)
///
/// The `BannerWidget` takes a list of images URLs and presents them in a
/// carousel format, with automatic sliding functionality.
class BannerWidget extends StatefulWidget {

  /// A list of String where each string is the URL of an image to be displayed
  /// in the carousel
  final List<String> bannerList;

  const BannerWidget({super.key, required this.bannerList});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {

  // The index of the current image being displayed
  int _current = 0;

  // A controller for the carousel to programmatically interact with the carousel
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {

    // Get the screen width to set the image width accordingly
    final double width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CarouselSlider(
          items: widget.bannerList.map((item) => _tabImage(item, width)).toList(),
          carouselController: _controller,
          options: CarouselOptions(
            height: 160.px,
            autoPlay: true,
            viewportFraction: 1.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }
          )
        ),
        Positioned(
          bottom: 10,
            left: 0,
            right: 0,
            child: _indicator())
      ],
    );
  }

  /// Creates a clickable image widget
  ///
  /// When the image is tapped, it should perform a navigation action or another callback
  /// [imgUrl] is the URL of the image to be displayed
  /// [width] is the width of the image which is set to the screen width
  Widget _tabImage(String imgUrl, double width){
    return GestureDetector(
      onTap: (){
        //TODO, NavigatorUtil
      },
      child: Image.network(imgUrl, width: width, fit: BoxFit.cover,),
    );
  }

  /// Builds a row of indicator dots to represent the banners
  ///
  /// It creates a row of small dots
  _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.bannerList.asMap().entries.map((entry){
        return GestureDetector(
          onTap: () => _controller.animateToPage(entry.key),
          child: Container(
            width: 6,
            height: 6,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                (Colors.white).withOpacity(_current == entry.key ? 0.9 : 0.4),
            ),
          ),
        );
      }).toList(),
    );
  }
}
