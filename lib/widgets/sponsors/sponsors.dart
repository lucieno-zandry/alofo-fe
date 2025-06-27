import 'package:alofo/classes/screen.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/sponsor/sponsor.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

var sponsors = [
  Sponsor(
    image: SvgPicture.asset('assets/icons/alien.svg', height: 30, width: 30),
    brand: Text(
      "Alien",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  Sponsor(
    image: SvgPicture.asset('assets/icons/anchor.svg', height: 30, width: 30),
    brand: Text(
      "Anchor",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  Sponsor(
    image: SvgPicture.asset('assets/icons/aperture.svg', height: 30, width: 30),
    brand: Text(
      "Aperture",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  Sponsor(
    image: SvgPicture.asset('assets/icons/bicycle.svg', height: 30, width: 30),
    brand: Text(
      "Bicycle",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  Sponsor(
    image: SvgPicture.asset(
      'assets/icons/basketball.svg',
      height: 30,
      width: 30,
    ),
    brand: Text(
      "Basketball",
      style: TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
];

class Sponsors extends StatelessWidget {
  const Sponsors({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: AppContainer(
        child: SizedBox(
          width: 400, // Set your desired width here
          child: CarouselSlider(
            items: sponsors,
            options: CarouselOptions(
              animateToClosest: true,
              autoPlay: true,
              enableInfiniteScroll: true,
              viewportFraction: Screen.responsive<double>(
                width: MediaQuery.of(context).size.width,
                standard: 0.5,
                xs: 0.4,
                sm: 0.3,
                md: 0.2,
                lg: 0.15,
              ),
              height: 200,
            ),
          ),
        ),
      ),
    );
  }
}
