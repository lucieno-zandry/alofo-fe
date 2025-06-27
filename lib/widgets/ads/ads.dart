import 'package:alofo/widgets/ad/ad.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:flutter/material.dart';

List<Map<String, Object>> adsData = [
  {
    "button": Button(
      onPressed: () {},
      variant: 'light',
      child: Text('SHOP NOW'),
    ),
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac dictum.​",
    "imageUrl": "assets/images/women-fashion.jpg",
    "title": "20% Off On Tank Tops",
  },
  {
    "button": Button(
      onPressed: () {},
      variant: 'light',
      child: Text('SHOP NOW'),
    ),
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac dictum.​",
    "imageUrl": "assets/images/men-fashion.jpg",
    "title": "Latest Eyewear For You",
  },
  {
    "button": Button(
      onPressed: () {},
      variant: 'light',
      child: Text('CHECK OUT'),
    ),
    "description":
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ac dictum.​",
    "imageUrl": "assets/images/footwear.jpg",
    "title": "Let's Lorem Suit Up!",
  },
];

class Ads extends StatelessWidget {
  const Ads({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        runSpacing: 30,
        children: [
          for (var adData in adsData)
            Ad(
              button: adData['button'] as Widget,
              description: adData['description'] as String,
              imageUrl: adData['imageUrl'] as String,
              title: adData['title'] as String,
            ),
        ],
      ),
    );
  }
}
