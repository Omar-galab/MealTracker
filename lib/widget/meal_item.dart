import 'dart:io';

import 'package:flutter/material.dart';
import '../models/meal.dart';


class MealItem extends StatelessWidget {
  final Meal meal;
  final VoidCallback onDelete;

  const MealItem({
    super.key,
    required this.meal,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: meal.imageUrl != null
            ? Image.file(
          File(meal.imageUrl!),
          width: 50,
          height: 50,
          fit: BoxFit.cover,
        )
            : const Icon(Icons.fastfood, size: 40),
        title: Text(meal.name),
        subtitle: Text('${meal.calories} kcal • ${meal.formattedTime}'),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}