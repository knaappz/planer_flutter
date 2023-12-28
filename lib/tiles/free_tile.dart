import 'package:flutter/material.dart';

class FreeTile extends StatelessWidget {
  const FreeTile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 380,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 380,
            color: Colors.black,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Jesteś wolny, ciesz się póki możesz...',
                  style: TextStyle(
                      color: Colors.white, fontFamily: 'Oxygen', fontSize: 20),
                ),
              ),
            ),
          ),
          Image.asset(
            'assets/img/free.jpg',
            color: Colors.white.withOpacity(0.8),
            colorBlendMode: BlendMode.modulate,
          )
        ],
      ),
    );
  }
}
