import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pocket_pal/providers/expense_provider.dart';
import 'package:pocket_pal/models/expense.dart';

class ExpenseBottomSheet extends StatefulWidget {
  const ExpenseBottomSheet({super.key});

  @override
  State<ExpenseBottomSheet> createState() => _ExpenseBottomSheetState();
}

class _ExpenseBottomSheetState extends State<ExpenseBottomSheet> {
  String _amount = '0';
  String _description = '';
  String _selectedCategory = '';
  IconData _selectedIcon = Icons.category;
  Color _selectedColor = Colors.grey;

  void _saveExpense() {
    if (_amount == '0' || _selectedCategory.isEmpty) return;

    final expense = Expense(
      id: DateTime.now().toString(),
      description: _description.isEmpty ? _selectedCategory : _description,
      category: _selectedCategory,
      amount: double.parse(_amount),
      icon: _selectedIcon,
      color: _selectedColor,
      date: DateTime.now(),
    );

    Provider.of<ExpenseProvider>(context, listen: false).addExpense(expense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 20),
                _buildAmountDisplay(),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    _buildCategoryGrid(),
                    _buildNoteInput(),
                  ],
                ),
              ),
            ),
          ),
          _buildNumberPad(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        const Text(
          'Today',
          style: TextStyle(
            color: Colors.amber,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.check, color: Colors.white),
          onPressed: _saveExpense,
        ),
      ],
    );
  }

  Widget _buildAmountDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.attach_money, color: Colors.white, size: 30),
          Text(
            '\$$_amount',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 5,
      children: [
        _buildCategoryItem(Icons.restaurant, 'Food', Colors.pink[100]!),
        _buildCategoryItem(Icons.coffee, 'Drinks', Colors.green[200]!),
        _buildCategoryItem(Icons.directions_bus, 'Transport', Colors.blue[200]!),
        _buildCategoryItem(Icons.shopping_bag, 'Shopping', Colors.purple[200]!),
        _buildCategoryItem(Icons.sports_esports, 'Entertainment', Colors.orange[200]!),
        _buildCategoryItem(Icons.home, 'Housing', Colors.green),
        _buildCategoryItem(Icons.phone_android, 'Electronics', Colors.blue),
        _buildCategoryItem(Icons.medical_services, 'Medical', Colors.red[300]!),
        _buildCategoryItem(Icons.more_horiz, 'Misc', Colors.grey),
        _buildCategoryItem(Icons.account_balance_wallet, 'Income', Colors.amber),
      ],
    );
  }

  Widget _buildCategoryItem(IconData icon, String label, Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = label;
          _selectedIcon = icon;
          _selectedColor = color;
        });
      },
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: _selectedCategory == label
                      ? color.withOpacity(0.5)
                      : color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 4),
              SizedBox(
                width: constraints.maxWidth,
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildNoteInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        autofocus: false,
        keyboardType: TextInputType.text,
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: 'Tap to Edit a Note',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
        onChanged: (value) {
          setState(() {
            _description = value;
          });
        },
      ),
    );
  }

  Widget _buildNumberPad() {
    return Container(
      padding: const EdgeInsets.all(10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
        ),
        itemCount: 12,
        itemBuilder: (context, index) {
          String buttonText;
          if (index < 9) {
            buttonText = '${index + 1}';
          } else if (index == 9) {
            buttonText = '.';
          } else if (index == 10) {
            buttonText = '0';
          } else {
            buttonText = '<';
          }

          return GestureDetector(
            onTap: () {
              setState(() {
                if (buttonText == '<') {
                  if (_amount.isNotEmpty) {
                    _amount = _amount.substring(0, _amount.length - 1);
                  }
                } else {
                  _amount += buttonText;
                }
              });
            },
            child: Container(
              margin: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.grey[800],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}