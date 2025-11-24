import 'package:flutter/material.dart';
import 'package:alt_expense_tracker_app/models/expense.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseCard extends StatelessWidget {
  const ExpenseCard({
    super.key,
    required this.expensesList,
    required this.index,
  });

  final List<Expense> expensesList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expensesList[index].formattedDate,
                        style: GoogleFonts.openSans(fontSize: 15),
                      ),
                      Text(
                        expensesList[index].formattedAmount,
                        style: GoogleFonts.lato(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        expensesList[index].title,
                        style: GoogleFonts.openSans(fontSize: 15),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage(
                          imagesDict[expensesList[index].category],
                        ),
                      ),
                    ),
                    height: 100,
                    width: 100,

                    // : imagesDict[expensesList[index].category],
                  ),
                ],
              ),
              Container(
                // width: 100,
                // height: 30,
                padding: const EdgeInsets.symmetric(
                  vertical: 4,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(113, 130, 154, 174),
                  borderRadius: BorderRadius.circular(50),
                ),

                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    iconsDict[expensesList[index].category],
                    const SizedBox(width: 5),
                    Text(expensesList[index].category.name.toUpperCase()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
