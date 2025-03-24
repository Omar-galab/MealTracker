import 'package:flutter/material.dart';
import '../models/meal.dart';


class MealProvider with ChangeNotifier {
  final List<Meal> _meals = [];
  String _sortBy = 'time';

  List<Meal> get meals {
    List<Meal> sorted = List.from(_meals);
    switch (_sortBy) {
      case 'name':
        sorted.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'calories':
        sorted.sort((a, b) => a.calories.compareTo(b.calories));
        break;
      case 'time':
      default:
        sorted.sort((a, b) => b.time.compareTo(a.time)); // Newest first
    }
    return sorted;
  }

  int get totalCalories => _meals.fold(0, (sum, meal) => sum + meal.calories);

  void addMeal(Meal meal) {
    _meals.add(meal);
    notifyListeners();
  }

  void deleteMeal(String id) {
    _meals.removeWhere((meal) => meal.id == id);
    notifyListeners();
  }

  void updateSort(String sortBy) {
    _sortBy = sortBy;
    notifyListeners();
  }

  // For initial testing
  void loadSampleData() {
    _meals.addAll([
      Meal(
        id: '1',
        name: 'Breakfast',
        calories: 350,
        time: DateTime.now().subtract(const Duration(hours: 4)),
      ),
      Meal(
        id: '2',
        name: 'Lunch',
        calories: 600,
        time: DateTime.now(),
      ),
    ]);
    notifyListeners();
  }
}