import 'package:flutter/material.dart';

class HeadWidget extends StatelessWidget {
  const HeadWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          color: Colors.red,
        ),
        Text('Dubai'),
        Spacer(),
        Icon(Icons.account_box),
      ],
    );
  }
}
