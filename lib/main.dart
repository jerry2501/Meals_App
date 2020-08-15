import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories_screen.dart';
import 'package:meals_app/screens/category_meals_screen.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meal_details_screen.dart';
import 'package:meals_app/screens/tab_screen.dart';


void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String,bool> _filters={
    'gluten':false,
    'lactose':false,
    'vegan':false,
    'vegetarian':false,
  };
  List<Meal> _availableMeals=DUMMY_MEALS;
  List<Meal> _favouriteMeals=[];

   void _setFilters(Map<String,bool> filterData){
      setState(() {
        _filters=filterData;
        _availableMeals=DUMMY_MEALS.where((meal){
          if(_filters['gluten']==true && !meal.isGlutenFree){
           return false;
          }
          if(_filters['lactose']==true && !meal.isLactoseFree){
            return false;
          }
          if(_filters['vegan']==true && !meal.isVegan){
            return false;
          }
          if(_filters['vegetarian']==true && !meal.isVegetarian){
            return false;
          }
          return true;
        }).toList();
      });
   }

   void _toggleFavourite(String id){
     final existingIndex=_favouriteMeals.indexWhere((meal) => meal.id==id);
     if(existingIndex>=0){
       setState(() {
         _favouriteMeals.removeAt(existingIndex);
       });
     }
     else{
       setState(() {
         _favouriteMeals.add(DUMMY_MEALS.firstWhere((element) => element.id==id));
       });
     }
   }

   bool _isMealFavourite(String id){
     return _favouriteMeals.any((element) => element.id==id);
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
          body1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          body2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          title: TextStyle(fontFamily: 'RobotoCondensed',fontSize: 20,fontWeight:FontWeight.bold),
        )
      ),
      routes: {
        '/':(ctx)=>TabScreen(_favouriteMeals),
        CategoryMealsScreen.routeName:(ctx)=>CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName:(ctx)=>MealDetailScreen(_toggleFavourite,_isMealFavourite),
        FiltersScreen.routeName:(ctx)=>FiltersScreen(_filters,_setFilters),
      },
      //if any route is not registered above then by default below route will be executed
      onGenerateRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx)=>CategoryMealsScreen(_availableMeals));
      },
      //at last this will be called if we do not use toutes and ongenerateroute
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx)=>CategoryMealsScreen(_availableMeals));
      },
    );
  }
}

