import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:flutter/material.dart';

class Banniere2 extends StatelessWidget {
  const Banniere2({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/banner-02.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Screen.percentageOf(MediaQuery.of(context).size.width, 5),
          vertical: 100,
        ),
        decoration: BoxDecoration(color: AppColors.primary(alpha: 150)),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Limited Time Offer',
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppColors.light()),
            ),
            SizedBox(height: 5),
            Text(
              'Special Edition',
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(color: AppColors.light()),
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elit tellus, luctus nec ullamcorper mattis, pulvinar dapibus leo.",
              style: TextStyle(color: AppColors.light()),
            ),
            Text(
              "Buy This T-shirt At 20% Discount, Use Code OFF20",
              style: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(color: AppColors.light()),
            ),
            SizedBox(height: 5),
            Button(onPressed: () {}, variant: 'light', child: Text('SHOP NOW')),
          ],
        ),
      ),
    );
  }
}
