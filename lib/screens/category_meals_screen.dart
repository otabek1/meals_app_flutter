import 'package:flutter/material.dart';
import '/widgets/meal_item.dart';
import '../models/meal.dart';
import '../dummy_data.dart';

class CategoryMealsScreen extends StatelessWidget {
  static const routeName = "/category-meals";
  List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String? categoryTitle = routeArgs["title"];
    final String? categoryId = routeArgs["id"];
    final categoryMeals = availableMeals
        .where((element) => element.categories.contains(categoryId))
        .toList();
    availableMeals.forEach((element) {
      // print(element.isVegetarian);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          final Meal meal = categoryMeals[index];
          return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              complexity: meal.complexity,
              affordability: meal.affordability);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
