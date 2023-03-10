import 'package:flutter/material.dart';

void showErrorDialogHelper(BuildContext context) {
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
            Navigator.of(context).pop();
          },
        )
      ],
    ),
  );
}
