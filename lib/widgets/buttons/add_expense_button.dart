import "package:flutter/material.dart";


class AddExpenseButton extends StatelessWidget{
  
  const AddExpenseButton({super.key,required this.onPress});

  final void Function() onPress;

@override
  Widget build(BuildContext context) {
    
    return IconButton(onPressed: onPress, icon: const Icon(Icons.add));
  }

}