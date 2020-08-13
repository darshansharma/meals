import 'package:flutter/material.dart';
import 'package:meals/widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoriesMealsScreen extends StatefulWidget {
  static const routeName = 'category-meals';

  final List<Meal> availableMeals;

  CategoriesMealsScreen(this.availableMeals);

  @override
  _CategoriesMealsScreenState createState() => _CategoriesMealsScreenState();
}

class _CategoriesMealsScreenState extends State<CategoriesMealsScreen> {
  String categoryId;
  String categoryTitle;
  List<Meal> displayMeals;
  bool isInitDataLoaded = false;

  void _removeItem(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => mealId == meal.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, String>;
    categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];
    displayMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
          itemBuilder: (ctx, index) {
            return MealItem(
              id: displayMeals[index].id,
              title: displayMeals[index].title,
              imageUrl: displayMeals[index].imageUrl,
              complexity: displayMeals[index].complexity,
              affordability: displayMeals[index].affordability,
              duration: displayMeals[index].duration,
            );
          },
          itemCount: displayMeals.length),
    );
  }
}
