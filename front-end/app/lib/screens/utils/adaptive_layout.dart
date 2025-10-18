import 'package:flutter/material.dart';

class AdaptiveLayout {
  final int crossAxisCount;
  final double itemWidth;
  final double itemHeight;
  final double spacing;

  AdaptiveLayout({
    required this.crossAxisCount,
    required this.itemWidth,
    required this.itemHeight,
    required this.spacing,
  });
}

AdaptiveLayout calculateAdaptiveLayout(
  double screenWidth,
  double maxItemWidth,
  int numItems,
  double maxSpace,
  double shrinkLimit,
  double maxItemHeight, // ✅ new argument
) {
  const double aspectRatio = 0.8; // height = width * 0.8
  int crossAxisCount = numItems;
  double spacing = (maxSpace * (crossAxisCount + 1));

  double totalWidth = (maxItemWidth * crossAxisCount) + spacing;

  double itemWidth = maxItemWidth;
  double itemHeight = maxItemHeight;

  // Case A: Expand
  if (totalWidth <= screenWidth) {
    double remainingWidth = screenWidth - totalWidth;
    double addedPerItem = remainingWidth / crossAxisCount;
    itemWidth = maxItemWidth + addedPerItem;
    itemHeight = itemWidth * aspectRatio;
  }
  // Case B: Shrink (within shrinkLimit)
  else if (totalWidth > screenWidth) {
    double requiredReduction = totalWidth - screenWidth;
    double reductionPerItem = requiredReduction / crossAxisCount;
    itemWidth = maxItemWidth - reductionPerItem;
    // Case B: two column
    if (itemWidth < (maxItemWidth * shrinkLimit) &&
        screenWidth > (maxItemWidth * 2)) {
      //&&
      // screenWidth > ((maxItemWidth * 2) + spacing * 3)) {
      // Fallback to wrap
      crossAxisCount = 2;
      double remainingWidth =
          screenWidth - (maxItemWidth * crossAxisCount) - spacing;
      itemWidth = maxItemWidth + (remainingWidth / crossAxisCount);
    }
    // Case B: single column
    else if (itemWidth < (maxItemWidth * shrinkLimit)) {
      crossAxisCount = 1;
      itemWidth = screenWidth - (maxSpace * 2);
    }
    itemHeight = itemWidth * aspectRatio;
  }

  return AdaptiveLayout(
    crossAxisCount: crossAxisCount,
    itemWidth: itemWidth,
    itemHeight: itemHeight,
    spacing: maxSpace,
  );
}
