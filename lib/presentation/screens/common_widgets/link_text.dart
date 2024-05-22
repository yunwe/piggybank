import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:piggybank/app/route/route_utils.dart';

class LinkText extends StatelessWidget {
  final String text;
  final PAGES page;

  const LinkText({super.key, required this.page, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.go(page.screenPath);
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}
