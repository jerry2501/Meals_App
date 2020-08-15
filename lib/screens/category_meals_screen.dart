import 'package:flutter/material.dart';
import 'package:meals_app/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget{
  static const routeName='/category-meals';
   final List<Meal> availableMeals;
   CategoryMealsScreen(this.availableMeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  bool _loadedInitData=false;
  void _removeMeal(String id){
setState(() {
  displayMeals.removeWhere((element) => element.id==id);
});
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  //context we cannot use in initstate
  @override
  void didChangeDependencies() {
    if(!_loadedInitData){
      final routeArgs=ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle=routeArgs['title'];
      final categoryId=routeArgs['id'];
      displayMeals=widget.availableMeals.where((meal){
        return meal.categories.contains(categoryId);
      }).toList();
      _loadedInitData=true;
    }
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemCount: displayMeals.length,
        itemBuilder: (ctx,index){
          return MealItem(
            id: displayMeals[index].id,
            title: displayMeals[index].title,
            imageUrl: displayMeals[index].imageUrl,
            duration: displayMeals[index].duration,
            affordability: displayMeals[index].affordability,
            complexity: displayMeals[index].complexity,
            removeItem: _removeMeal,
          );
        },
      ),
    );
  }
}