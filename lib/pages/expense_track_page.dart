// This is a sample implementation with static data

class ExpenseTrackPage {
    // Sample static data
    final List<Map<String, dynamic>> sampleExpenses = [
        {"title": "Coffee", "amount": 3.5, "date": "2023-10-01"},
        {"title": "Lunch", "amount": 12.0, "date": "2023-10-01"},
        {"title": "Transport", "amount": 2.5, "date": "2023-10-02"}
    ];

    // Method to retrieve sample expenses
    List<Map<String, dynamic>> getExpenses() {
        return sampleExpenses;
    }
}