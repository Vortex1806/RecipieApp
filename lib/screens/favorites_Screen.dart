import 'package:flutter/material.dart';

import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritedMeal;
  FavoritesScreen(this.favoritedMeal);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('favoritesgohere'),
    );
  }
}
