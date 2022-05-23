import 'package:flutter/material.dart';

import './data/dummy_data.dart';
import './models/meal.dart';
import './screens/categories_meals_screen.dart';
import './screens/filters_screen.dart';
import './screens/recipie_screen.dart';
import './screens/tabs_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'vegetarian': false,
    'vegan': false,
    'lactose': false,
  };

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters['gluten'] && !meal.isGlutenFree) {
          return false;
        }
        if (_filters['vegetarian'] && !meal.isVegetarian) {
          return false;
        }
        if (_filters['vegan'] && !meal.isVegan) {
          return false;
        }
        if (_filters['lactose'] && !meal.isLactoseFree) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favorites = [];

  void _toggleFavorites(String mealId) {
    final _existingIndex = _favorites.indexWhere((meal) => meal.id == mealId);
    if (_existingIndex >= 0) {
      setState(() {
        _favorites.removeAt(_existingIndex);
      });
    } else {
      setState(() {
        _favorites.add(DUMMY_MEALS.firstWhere((meal) => mealId == meal.id));
      });
    }
  }

  bool _isFavorriteMeal(String id) {
    return _favorites.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline6: TextStyle(
                fontSize: 20,
                fontFamily: 'RobodoCondensed',
                fontWeight: FontWeight.bold)),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (context) => TabsScreen(_favorites),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(_availableMeals),
        RecipieScreen.routeName: (context) => RecipieScreen(_toggleFavorites,_isFavorriteMeal),
        FilterScreen.routeName: (context) => FilterScreen(_filters, _setFilters)
      },
    );
  }
}
