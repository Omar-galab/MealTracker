import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/meal_provider.dart';
import '../widget/calorie_summary.dart';
import '../widget/meal_item.dart';
import 'add_meal_screen.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  @override
  void initState() {
    super.initState();
    // Load sample data (remove in production)
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MealProvider>(context, listen: false).loadSampleData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Tracker'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (value) {
              Provider.of<MealProvider>(context, listen: false)
                  .updateSort(value);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'name', child: Text('Sort by Name')),
              const PopupMenuItem(
                  value: 'calories', child: Text('Sort by Calories')),
              const PopupMenuItem(value: 'time', child: Text('Sort by Time')),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          const CalorieSummary(),
          Expanded(
            child: Consumer<MealProvider>(
              builder: (context, provider, child) {
                return ListView.builder(
                  itemCount: provider.meals.length,
                  itemBuilder: (ctx, index) => MealItem(
                    meal: provider.meals[index],
                    onDelete: () => provider.deleteMeal(provider.meals[index].id),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddMealScreen()),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}