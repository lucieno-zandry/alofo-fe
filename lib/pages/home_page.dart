import 'package:alofo/widgets/ads/ads.dart';
import 'package:alofo/widgets/banniere/banniere.dart';
import 'package:alofo/widgets/banniere2/banniere2.dart';
import 'package:alofo/widgets/featured_products/featured_products.dart';
import 'package:alofo/widgets/footer/footer.dart';
import 'package:alofo/widgets/hr/hr.dart';
import 'package:alofo/widgets/services/services.dart';
import 'package:alofo/widgets/sponsors/sponsors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Banniere(),
        Sponsors(),
        Ads(),
        SizedBox(height: 50),
        FeaturedProducts(),
        Banniere2(),
        SizedBox(height: 50),
        Services(),
        Hr(),
        Footer(),
      ],
    );
  }
}
