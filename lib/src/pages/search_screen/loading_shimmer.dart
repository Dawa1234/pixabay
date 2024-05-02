import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        padding: const EdgeInsets.all(8),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: 3, mainAxisSpacing: 3, crossAxisCount: 2),
        itemCount: 20,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Shimmer.fromColors(
            direction: ShimmerDirection.ttb,
            baseColor: Colors.grey[200]!,
            highlightColor: Colors.grey[100]!,
            child: Container(height: 20, color: Colors.grey[200]!)));
  }
}
