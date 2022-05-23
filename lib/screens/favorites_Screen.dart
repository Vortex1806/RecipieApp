import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/meal_item.dart';

import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritedMeal;
  FavoritesScreen(this.favoritedMeal);

  @override
  Widget build(BuildContext context) {
    if (favoritedMeal.isEmpty) {
      return Center(
        child: Text('Add Favorites'),
      );
    } else {
      return ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            id: favoritedMeal[index].id,
            title: favoritedMeal[index].title,
            imgUrl: favoritedMeal[index].imageUrl,
            affordability: favoritedMeal[index].affordability,
            duration: favoritedMeal[index].duration,
            complexity: favoritedMeal[index].complexity,
          );
        }),
        itemCount: favoritedMeal.length,
      );
    }
  }
}
