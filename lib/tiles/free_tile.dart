import 'package:flutter/material.dart';

class FreeTile extends StatelessWidget {
  const FreeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Jesteś wolny,\n ciesz się póki możesz...',
      style: TextStyle(
          color: Colors.grey,
          fontFamily: 'Oxygen',
          fontSize: 30,
          fontStyle: FontStyle.italic),
    );
  }
}
