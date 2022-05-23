import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/Category-Meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  State<CategoryMealsScreen> createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {

  String categoryTitle;
  List<Meal> displayedMeal;

  @override
  void didChangeDependencies() {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
    displayedMeal = widget.availableMeals.where(((meal) {
      return meal.categories.contains(categoryId);
    })).toList();
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  void _removeItem(String MealId) {
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == MealId);
    });
  }

  // final String categoryId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: ((context, index) {
          return MealItem(
            id: displayedMeal[index].id,
            title: displayedMeal[index].title,
            imgUrl: displayedMeal[index].imageUrl,
            affordability: displayedMeal[index].affordability,
            duration: displayedMeal[index].duration,
            complexity: displayedMeal[index].complexity,
            removeItem: _removeItem,
          );
        }),
        itemCount: displayedMeal.length,
      ),
    );
  }
}
