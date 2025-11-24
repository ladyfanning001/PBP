import 'package:flutter/material.dart';
import 'package:alt_expense_tracker_app/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  // final List listItem;
  final Function(Expense addedExpense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  DateTime? selectedDate;
  Category selectedCategory = Category.food;

  var textController = TextEditingController();
  var amountController = TextEditingController();

  @override
  void dispose() {
    textController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void validateInput() {
    var amountValue = double.tryParse(amountController.text);
    // print(amountValue);

    bool notValidAmount = amountValue == null || amountValue <= 0;
    final bool notValidTitle = textController.text.isEmpty;

    if (notValidTitle == true || notValidAmount || selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text(
            "please make sure every section has a valid data",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Ok"),
            ),
          ],
        ),
      );
      return;
    }

    //else
    widget.onAddExpense(
      Expense(
        title: textController.text,
        category: selectedCategory,
        date: selectedDate!,
        amount: amountValue,
      ),
    );
    Navigator.pop(context);
  }

  void _datePicker() async {
    var pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(9999),
      initialDate: DateTime.now(),
    );
    setState(() {
      selectedDate = pickedDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    // MediaQuery.v

    return LayoutBuilder(
      builder: (ctx, constrains) {
        final width = constrains.maxWidth;
        return SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              // padding: const EdgeInsetsGeometry.all(16),
              padding: EdgeInsetsGeometry.fromLTRB(
                16,
                16,
                16,
                16 + MediaQuery.of(context).viewInsets.bottom,
              ),
              //main column
              child: Column(
                children: [
                  // first line
                  if (width >= 600)
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: textController,
                            decoration: const InputDecoration(
                              label: Text("Title"),
                            ),
                            maxLength: 50,
                          ),
                        ),
                        const SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text("Amount"),
                              prefixText: "Rp ",
                            ),
                          ),
                        ),
                      ],
                    )
                  else
                    TextField(
                      controller: textController,
                      decoration: const InputDecoration(label: Text("Title")),
                      maxLength: 50,
                    ),

                  // second line
                  if (width >= 600)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                          value: selectedCategory,
                        ),
                        Row(
                          children: [
                            Text(
                              selectedDate == null
                                  ? "Pick A Date"
                                  : formtter.format(selectedDate!),
                            ),
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ],
                    )
                  else
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextField(
                            controller: amountController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              label: Text("Amount"),
                              prefixText: "Rp ",
                            ),
                          ),
                        ),
                        const SizedBox(width: 40),
                        Row(
                          children: [
                            Text(
                              selectedDate == null
                                  ? "Pick A Date"
                                  : formtter.format(selectedDate!),
                            ),
                            IconButton(
                              onPressed: _datePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ],
                    ),

                  const SizedBox(height: 15),

                  // third line
                  if (width >= 600)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel"),
                        ),
                        const SizedBox(width: 15),

                        FilledButton(
                          onPressed: validateInput,
                          child: const Text("Save Data"),
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton(
                          items: Category.values
                              .map(
                                (category) => DropdownMenuItem(
                                  value: category,
                                  child: Text(category.name.toUpperCase()),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            if (value == null) {
                              return;
                            }
                            setState(() {
                              selectedCategory = value;
                            });
                          },
                          value: selectedCategory,
                        ),

                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("Cancel"),
                            ),
                            FilledButton(
                              onPressed: validateInput,
                              child: const Text("Save Data"),
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
