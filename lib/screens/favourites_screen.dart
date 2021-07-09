import 'package:flutter/material.dart';
import '/models/meal.dart';
import '/widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  List<Meal> favouriteMeals;
  FavouritesScreen(this.favouriteMeals);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          final Meal meal = favouriteMeals[index];
          return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              complexity: meal.complexity,
              affordability: meal.affordability);
        },
        itemCount: favouriteMeals.length,
      ),
    );
  }
}
