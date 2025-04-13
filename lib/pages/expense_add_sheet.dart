import 'package:flutter/material.dart';

class ExpenseBottomSheet extends StatelessWidget {
  const ExpenseBottomSheet({super.key});

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
          // Number pad will be added here
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
        const SizedBox(width: 40),
      ],
    );
  }

  Widget _buildAmountDisplay() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.attach_money, color: Colors.white, size: 30),
          Text(
            '\$0',
            style: TextStyle(
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
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
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
    );
  }

  Widget _buildNoteInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: const TextField(
        autofocus: true,
        keyboardType: TextInputType.numberWithOptions(),
        style:  TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Tap to Edit a Note',
          hintStyle: TextStyle(color: Colors.grey),
          border: InputBorder.none,
        ),
      ),
    );
  }

  
}