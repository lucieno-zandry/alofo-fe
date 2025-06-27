import 'package:alofo/widgets/app_container.dart';
import 'package:flutter/material.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  RangeValues _currentRange = const RangeValues(20, 80);

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      padding: const EdgeInsets.only(top: 125),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                'Filter by price',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              RangeSlider(
                values: _currentRange,
                min: 0,
                max: 10000,
                divisions: 20,
                labels: RangeLabels(
                  _currentRange.start.round().toString(),
                  _currentRange.end.round().toString(),
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRange = values;
                  });
                },
              ),
              Text(
                'From ${_currentRange.start.round()} to ${_currentRange.end.round()}',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
