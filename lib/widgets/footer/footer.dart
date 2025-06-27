import 'package:alofo/classes/app_colors.dart';
import 'package:alofo/classes/screen.dart';
import 'package:alofo/widgets/app_container.dart';
import 'package:alofo/widgets/button/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: EdgeInsets.only(bottom: 75),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Wrap(
            alignment: WrapAlignment.spaceAround,
            runSpacing: 20,
            children: [
              SizedBox(
                width: Screen.percentageOf(
                  constraints.maxWidth,
                  Screen.responsive(
                    width: constraints.maxWidth,
                    standard: 100,
                    md: 20,
                  ),
                ),
                child: Column(
                  spacing: 25,
                  children: [
                    SvgPicture.asset('assets/images/logo.svg'),
                    Text(
                      'The best look anytime, anywhere.',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.dark(),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Screen.percentageOf(
                  constraints.maxWidth,
                  Screen.responsive(
                    width: constraints.maxWidth,
                    standard: 100,
                    md: 20,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: Screen.responsive(
                    width: constraints.maxWidth,
                    standard: CrossAxisAlignment.center,
                    md: CrossAxisAlignment.start,
                  ),
                  children: [
                    Text(
                      'For Her',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.dark(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Women Jeans',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                    Text(
                      'Tops and Shirts',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                    Text(
                      'Women Jackets',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                    Text(
                      'Heels and Flats',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                    Text(
                      'Women Accessories',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Screen.percentageOf(
                  constraints.maxWidth,
                  Screen.responsive(
                    width: constraints.maxWidth,
                    standard: 100,
                    md: 20,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: Screen.responsive(
                    width: constraints.maxWidth,
                    standard: CrossAxisAlignment.center,
                    md: CrossAxisAlignment.start,
                  ),
                  children: [
                    Text(
                      'For Him',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.dark(),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Men Jeans',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                    Text(
                      'Men Shirts',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                    Text(
                      'Men Shoes',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                    Text(
                      'Men Accessories',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                    Text(
                      'Men Jackets',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: AppColors.dark()),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: Screen.percentageOf(
                  constraints.maxWidth,
                  Screen.responsive(
                    width: constraints.maxWidth,
                    standard: 100,
                    md: 20,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: Screen.responsive(
                    width: constraints.maxWidth,
                    standard: CrossAxisAlignment.center,
                    md: CrossAxisAlignment.start,
                  ),
                  children: [
                    Text(
                      'Subscribe',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: AppColors.dark(),
                      ),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      width: Screen.clamp(
                        150,
                        Screen.percentageOf(constraints.maxWidth, 20),
                        250,
                      ),
                      child: EmailForm(),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class EmailForm extends StatefulWidget {
  const EmailForm({super.key});

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        spacing: 10,
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: 'Your email'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a valid email";
              }
              return null;
            },
          ),
          Button(onPressed: () {}, child: Text("Submit")),
        ],
      ),
    );
  }
}
