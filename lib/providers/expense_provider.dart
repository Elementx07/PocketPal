import 'package:flutter/material.dart';
import 'package:pocket_pal/models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  final List<Expense> _expenses = [
    Expense(
      id: '1',
      description: 'Grocery Shopping',
      category: 'Food',
      amount: 89.99,
      icon: Icons.shopping_cart,
      color: Colors.green,
      date: DateTime.now(),
    ),
    Expense(
      description: 'Coffee',
      category: 'Drinks',
      amount: 14.99,
      id: '2',
      icon: Icons.coffee,
      color: Colors.red,
      date: DateTime.now(),
    ),
    Expense(
      description: 'Pills',
      category: 'Medicine',
      amount: 3000.00,
      id: '3',
      icon: Icons.medical_services,
      color: Colors.blue,
      date: DateTime.now(),
    ),
    Expense(
      description: 'Electric Bill',
      category: 'Utilities',
      amount: 120.50,
      id: '4',
      icon: Icons.electric_bolt,
      color: Colors.orange,
      date: DateTime.now(),
    ),
    Expense(
      description: 'Bus Fare',
      category: 'Transport',
      amount: 25.00,
      id: '5',
      icon: Icons.directions_bus,
      color: Colors.purple,
      date: DateTime.now(),
    ),
  ];

  List<Expense> get expenses => _expenses;

  double get totalExpenses {
    return _expenses.fold(0, (sum, expense) {
      if (expense.category == 'Income') {
        return sum - expense.amount;
      }
      return sum + expense.amount;
    });
  }

  void addExpense(Expense expense) {
    _expenses.insert(0, expense);
    notifyListeners();
  }

  void removeExpense(int index) {
    _expenses.removeAt(index);
    notifyListeners();
  }
}