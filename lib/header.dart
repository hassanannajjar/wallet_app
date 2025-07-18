import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 16, bottom: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Wallet',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.add, size: 24),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.more_horiz, size: 24),
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
