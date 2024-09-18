import 'package:flutter/material.dart';

import '../../../../../data/models/category.dart';
import 'app_category.dart';


class CategoriesTab extends StatelessWidget {
  final Function(Category) onCategoryClick;

  const CategoriesTab(this.onCategoryClick, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(" Pick your category \n of interest",style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10,),
          Expanded(
            child: GridView.builder(
              itemCount: Category.categories.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 24,
                mainAxisSpacing: 20,
              ),
              itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    onCategoryClick(Category.categories[index]);
                  },
                  child: AppCategory(category: Category.categories[index])),
            ),
          )
        ],
      ),
    );
  }
}
