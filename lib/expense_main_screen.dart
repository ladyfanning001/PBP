import 'package:alt_expense_tracker_app/main.dart';
import 'package:alt_expense_tracker_app/widgets/new_expense.dart';
import 'package:alt_expense_tracker_app/widgets/total_money_chart.dart';
import "package:flutter/material.dart";
import 'widgets/buttons/add_expense_button.dart';
import 'package:alt_expense_tracker_app/models/expense.dart';
import 'package:alt_expense_tracker_app/widgets/expense_card.dart';

class ExpenseMainScreen extends StatefulWidget {
  const ExpenseMainScreen({super.key});

  @override
  State<ExpenseMainScreen> createState() {
    return _ExpenseMainScreenState();
  }
}

class _ExpenseMainScreenState extends State<ExpenseMainScreen> {
  num getTotalAmount() {
    num totalAmontSum = 0;
    for (var element in _expensesList.reversed) {
      totalAmontSum += element.amount;
    }
    return totalAmontSum;
  }

  final List<Expense> _expensesList = [
    Expense(
      title: "flutter cource",
      amount: 14,
      category: Category.work,
      date: DateTime.now(),
    ),
    Expense(
      title: "chips",
      amount: 10,
      category: Category.luxry,
      date: DateTime.now(),
    ),
    Expense(
      title: "shoppign",
      amount: 5.00,
      category: Category.shopping,
      date: DateTime.now(),
    ),
  ];

  void _showNewExpenseModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) => NewExpense(onAddExpense: addExpense),
    );
  }

  void addExpense(Expense addedExpense) {
    setState(() {
      _expensesList.add(addedExpense);
    });
  }

  void removeExpense(Expense addedExpense) {
    var tempExpense = addedExpense;
    var tempExpenseIndex = _expensesList.indexOf(addedExpense);
    setState(() {
      _expensesList.remove(addedExpense);

      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Expense deleted, Want it back?"),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _expensesList.insert(tempExpenseIndex, tempExpense);
              });
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    var mainContent = "No Expenses Try Add Some";

    final width = MediaQuery.of(context).size.width;
    if (width < 600) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker"),

          // backgroundColor: Colors.blueAccent,
          actions: [AddExpenseButton(onPress: _showNewExpenseModal)],
        ),

        body: Column(
          children: [
            TotalMoneyChart(totalAmount: getTotalAmount()),
            Expanded(
              child: _expensesList.isEmpty
                  ? Center(
                      child: Text(
                        mainContent,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _expensesList.length,
                      itemBuilder: (ctx, index) => Dismissible(
                        key: ValueKey(_expensesList[index]),
                        background: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          color: kcolorScheme.error,
                          child: const Icon(Icons.delete),
                        ),
                        child: ExpenseCard(
                          expensesList: _expensesList,
                          index: index,
                        ),
                        onDismissed: (direction) {
                          removeExpense(_expensesList[index]);
                        },
                        // onDismissed: ,
                      ),
                    ),
            ),
          ],
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Expense Tracker"),

          // backgroundColor: Colors.blueAccent,
          actions: [AddExpenseButton(onPress: _showNewExpenseModal)],
        ),

        body: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: TotalMoneyChart(totalAmount: getTotalAmount())),
            Expanded(
              child: _expensesList.isEmpty
                  ? Center(
                      child: Text(
                        mainContent,
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _expensesList.length,
                      itemBuilder: (ctx, index) => Dismissible(
                        key: ValueKey(_expensesList[index]),
                        background: Container(
                          margin: const EdgeInsets.all(8),
                          padding: const EdgeInsets.all(8),
                          color: kcolorScheme.error,
                          child: const Icon(Icons.delete),
                        ),
                        child: ExpenseCard(
                          expensesList: _expensesList,
                          index: index,
                        ),
                        onDismissed: (direction) {
                          removeExpense(_expensesList[index]);
                        },
                      ),
                    ),
            ),
          ],
        ),
      );
    }
  }
}
