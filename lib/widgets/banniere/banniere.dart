import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/banniere/banniere_md.dart';
import 'package:alofo/widgets/banniere/banniere_standard.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:alofo/widgets/button/outline_button.dart';
import 'package:flutter/material.dart';

class Banniere extends StatelessWidget {
  const Banniere({super.key});

  _getBigTextStyle(BuildContext context) {
    return Screen.responsive<TextStyle>(
      width: MediaQuery.of(context).size.width,
      standard: Theme.of(context).textTheme.titleLarge!,
      md: Theme.of(context).textTheme.displayLarge!,
    );
  }

  _getTextStyle(BuildContext context) {
    return Screen.responsive<TextStyle>(
      width: MediaQuery.of(context).size.width,
      standard: Theme.of(context).textTheme.titleMedium!,
      md: Theme.of(context).textTheme.titleLarge!,
    );
  }

  _getBigTextAlignment(BuildContext context) {
    return Screen.responsive(
      width: MediaQuery.of(context).size.width,
      standard: TextAlign.center,
      md: TextAlign.start,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> actionButtons = [
      Button(variant: 'light', child: Text('SHOP NOW'), onPressed: () {}),
      OutlineButton(
        variant: 'light',
        onPressed: () {},
        child: Text('FIND MORE'),
      ),
    ];

    List<Widget> texts = [
      Text(
        'Raining Offers For Hot Summer!',
        textAlign: _getBigTextAlignment(context),
        style: _getBigTextStyle(context).copyWith(color: AppColors.light()),
      ),
      Text(
        '25% Off On All Products',
        textAlign: TextAlign.center,
        style: _getTextStyle(context).copyWith(color: AppColors.light()),
      ),
    ];

    double height = Screen.clamp(600, MediaQuery.of(context).size.height, 900);

    return Container(
      width: MediaQuery.of(context).size.width,
      height: height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/woman.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: height,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary.withAlpha(200),
        ),
        child: AppContainer(
          child: Screen.responsive<Widget>(
            width: MediaQuery.of(context).size.width,
            standard: BanniereStandard(
              actionButtons: actionButtons,
              texts: texts,
            ),
            md: BanniereMd(actionButtons: actionButtons, texts: texts),
          ),
        ),
      ),
    );
  }
}
