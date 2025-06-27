import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/service/service.dart';
import 'package:flutter/material.dart';

const servicesData = [
  {
    "imageSrc": "assets/images/service-1.png",
    "title": "Worldwide Shipping",
    "description":
        "It elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.",
  },
  {
    "imageSrc": "assets/images/service-2.png",
    "title": "Best Quality",
    "description":
        "It elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.",
  },
  {
    "imageSrc": "assets/images/service-3.png",
    "title": "Best Offers",
    "description":
        "It elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.",
  },
  {
    "imageSrc": "assets/images/service-4.png",
    "title": "Secure Payments",
    "description":
        "It elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.",
  },
];

class Services extends StatelessWidget {
  const Services({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.symmetric(vertical: 50),
      child: Wrap(
        alignment: WrapAlignment.spaceAround,
        runSpacing: 30,
        children: [
          for (var serviceData in servicesData)
            Service(
              imageSrc: serviceData['imageSrc']!,
              title: serviceData['title']!,
              description: serviceData['description']!,
            ),
        ],
      ),
    );
  }
}
