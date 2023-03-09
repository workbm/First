import 'package:flutter/material.dart';

void showErrorDialogWith2Pop(BuildContext context, String route) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('An error occurred!'),
      content: const Text(
        'Unfortunately, this operation cannot progress, check on the internet or the information you have entered.',
      ),
      actions: [
        ElevatedButton(
          child: const Text('Okay'),
          onPressed: () {
            Navigator.popUntil(context, ModalRoute.withName(route));
          },
        )
      ],
    ),
  );
}
