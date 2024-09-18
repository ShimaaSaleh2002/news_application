import 'package:flutter/material.dart';
import '../../../my_theme_data.dart';

class TabItem extends StatelessWidget {
  final bool isSelected;
  final String sourceName;
  const TabItem(
      {super.key, required this.sourceName, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: isSelected ? MyThemeData.primaryLightColor : Colors.transparent,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.green, width: 3),
      ),
      child: Center(
        child: Text(
          sourceName,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: isSelected
                  ? MyThemeData.whiteColor
                  : MyThemeData.primaryLightColor),
        ),
      ),
    );
  }
}
