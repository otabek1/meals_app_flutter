import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/dummy_data.dart';
import '/screens/filters_screen.dart';
import '/screens/tabs_screen.dart';
import '/screens/category_meals_screen.dart';
import '/screens/meal_detail_screen.dart';

import 'models/meal.dart';
import 'screens/categories_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    "gluten": false,
    "lactose": false,
    "vegetarian": false,
    "vegan": false
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      _availableMeals = DUMMY_MEALS.where((meal) {
        if (_filters["gluten"] == true && !meal.isGlutenFree) {
          return false;
        }
        if (_filters["lacose"] == true && !meal.isLactoseFree) {
          return false;
        }
        if (_filters["vegan"] != null) {
          if (_filters["vegan"] == true && !meal.isVegan) {
            return false;
          }
        }
        if (_filters["vegetarian"] == true && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _setFavourites(String mealId) {
    bool isFavourited = _favouriteMeals.any((meal) => meal.id == mealId);
    print(isFavourited);
    if (!isFavourited) {
      _favouriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId));
      isFavourited = true;
    } else {
      isFavourited = false;
      _favouriteMeals.removeWhere((meal) => meal.id == mealId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(229, 229, 229, 1.0),
        fontFamily: "Raleway",
        textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
            headline6: TextStyle(
              fontSize: 20,
              fontFamily: "RobotoCondensed",
              fontWeight: FontWeight.bold,
            )),
      ),
      home: TabsScreen(_favouriteMeals),
      routes: {
        CategoryMealsScreen.routeName: (ctx) =>
            CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) =>
            MealDetailScreen(_setFavourites, _favouriteMeals),
        FiltersScreen.routeName: (ctx) => FiltersScreen(_filters, _setFilters),
      },
    );
  }
}
