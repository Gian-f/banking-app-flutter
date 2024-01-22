import 'package:flutter/material.dart';

import '../theme/colors.dart';

class PagerIndicator extends StatelessWidget {
  final int itemCount;
  final int currentPage;
  final Function(int) onPageSelected;

  const PagerIndicator({
    super.key,
    required this.itemCount,
    required this.currentPage,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onPageSelected(index),
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: index == currentPage ? BlueStart : Colors.grey,
                shape: BoxShape.circle,
              ),
            ),
          );
        },
      ),
    );
  }
}
