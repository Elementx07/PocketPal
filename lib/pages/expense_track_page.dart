import 'package:flutter/material.dart';
import 'package:pocket_pal/models/expense.dart';
import 'package:pocket_pal/pages/expense_add_sheet.dart';

class ExpenseTrackPage extends StatefulWidget {
  const ExpenseTrackPage({super.key});

  @override
  State<ExpenseTrackPage> createState() => _ExpenseTrackPageState();
}

class _ExpenseTrackPageState extends State<ExpenseTrackPage> {
  // Static expense data
  static final List<Expense> _staticExpenses = [
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

  List<Expense> expenses = [];

  @override
  void initState() {
    super.initState();
    expenses = List.from(_staticExpenses);
  }

  void _addExpense(Expense expense) {
    setState(() {
      expenses.insert(0, expense);
    });
  }

  void _removeExpense(int index) {
    setState(() {
      expenses.removeAt(index);
    });
  }

  double get totalExpenses {
    return expenses.fold(0, (sum, expense) {
      if (expense.category == 'Income') {
        return sum - expense.amount;
      }
      return sum + expense.amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Expense Tracker',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: 'Arcade',
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 49, 2, 65),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          // Total expenses card
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 49, 2, 65),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total Expenses:',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '₹${totalExpenses.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.orange,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Expenses list
          Expanded(
            child: expenses.isEmpty
                ? const Center(
                    child: Text(
                      'No expenses yet',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: expenses.length,
                    itemBuilder: (context, index) {
                      final expense = expenses[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 8),
                        color: Colors.white.withOpacity(0.1),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: expense.color,
                            child: Icon(
                              expense.icon,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          title: Text(
                            expense.description,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            expense.category,
                            style: const TextStyle(color: Colors.white70),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '₹${expense.amount.toStringAsFixed(2)}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => _removeExpense(index),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => ExpenseBottomSheet(
              onAddExpense: _addExpense,
            ),
          );
        },
        backgroundColor: const Color.fromARGB(255, 49, 2, 65),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}