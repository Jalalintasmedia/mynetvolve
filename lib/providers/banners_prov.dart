import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../core/constants.dart';
import '../models/banner.dart';

class BannerProvs with ChangeNotifier {
  List<PromoBanner>? _promoBanners;
  List<CarouselBanner>? _carouselBanners;

  List<PromoBanner>? get promoBanners {
    return _promoBanners;
  }

  List<CarouselBanner>? get carouselBanners {
    return _carouselBanners;
  }

  List<String>? get promoBannerImages {
    List<String>? urls = [];
    _promoBanners!.map((promo) {
      urls.add(promo.pathBanner);
    }).toList();
    return urls;
  }

  List<String>? get carouselBannerUrls {
    List<String>? urls = [];
    _carouselBanners!.map((banner) {
      urls.add(banner.pathBanner);
    }).toList();
    print('===== BANNERS: $urls');
    return urls;
  }

  List<String>? get carouselLinkUrls {
    List<String>? urls = [];
    _carouselBanners!.map((banner) {
      urls.add(banner.url);
    }).toList();
    print('===== URLS: $urls');
    return urls;
  }

  Future<void> getPromoBanners() async {
    final url = Uri.parse(BNETFIT_API_URL + '/netvolve/promos');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "key": "98294",
        "time": '1672980687',
        "t_account_id": '66842',
      }),
    );

    final List<PromoBanner> loadedPromos = [];
    final extractedData = json.decode(response.body)['data'] as List;
    extractedData.map((promo) {
      var promoData = PromoBanner.fromJson(promo);
      loadedPromos.add(promoData);
    }).toList();

    _promoBanners = loadedPromos.toList();
  }

  Future<void> getCarouselBanners() async {
    final url = Uri.parse(BNETFIT_API_URL + '/netvolve/banners');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        "key": "98294",
        "time": '1672980687',
        "t_account_id": '66842',
      }),
    );

    final List<CarouselBanner> loadedBanners = [];
    final extractedData = json.decode(response.body)['data'] as List;
    extractedData.map((banner) {
      var bannerData = CarouselBanner.fromJson(banner);
      loadedBanners.add(bannerData);
    }).toList();

    _carouselBanners = loadedBanners;
  }
}
