import 'package:flutter/material.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      title: Text(
        'Minhas despesas',
        style: Theme.of(context).textTheme.headline5?.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.settings_outlined),
        )
      ],
    );
  }
}
