import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:mynetvolve/widgets/clickable_image.dart';
import 'package:mynetvolve/widgets/loading/shimmer_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../circle_indicator.dart';

class ImagesCarousel extends StatefulWidget {
  final double height;
  final List<String>? banners;
  final List<String>? urls;

  const ImagesCarousel({
    Key? key,
    required this.height,
    this.banners,
    this.urls,
  }) : super(key: key);

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  var _activeIndex = 0;
  final _images = [
    'assets/images/iklan_dummy.png',
    'assets/images/iklan_dummy2.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    List<String> carouselImages =
        widget.banners != null ? widget.banners! : _images;
    List<String> carouselUrls = widget.urls != null ? widget.urls! : ['', ''];
    return SizedBox(
      height: widget.height,
      child: Stack(
        children: [
          CarouselSlider.builder(
            options: CarouselOptions(
              height: widget.height,
              viewportFraction: 1,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 10),
              onPageChanged: (i, reason) {
                setState(() {
                  _activeIndex = i;
                });
              },
            ),
            itemCount: carouselImages.length,
            itemBuilder: (context, index, realIndex) {
              final image = carouselImages[index];
              final url = carouselUrls[index];
              return buildImage(
                image,
                index,
                carouselImages != _images ? true : false,
                url,
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Align(
              alignment: AlignmentDirectional.bottomCenter,
              child: CircleIndicator(
                activeIndex: _activeIndex,
                imagesLength: carouselImages.length,
                activeDotColor: Colors.white,
                dotColor: Colors.white60,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildImage(
    String image,
    int index,
    bool isUrl,
    String url,
  ) {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: isUrl
          ? ClickableImage(
              image: image,
              height: widget.height,
              url: url,
            )
          // : Container(
          //     color: Colors.grey.shade400,
          //   ),
          : const ShimmerWidget.rectangular(height: 0),
    );
  }
}
