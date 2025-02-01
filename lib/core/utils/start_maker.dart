import 'package:flutter/material.dart';

class CustomStarRating extends StatelessWidget {
  final double rating; // Current rating
  final double maxRating; // Maximum possible rating
  final int starCount; // Total stars displayed
  final Color filledStarColor; // Color for filled stars
  final Color unfilledStarColor; // Color for unfilled stars
  final double starSize; // Size of stars

  const CustomStarRating({
    super.key,
    required this.rating,
    this.maxRating = 5.0,
    this.starCount = 5,
    this.filledStarColor = Colors.yellow,
    this.unfilledStarColor = Colors.grey,
    this.starSize = 13.0,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      ...List.generate(starCount, (index) {
        // Determine star filling logic
        if (index  < rating.floor()) {
          return Icon(Icons.star,
              color: filledStarColor, size: starSize); // Fully filled star
        } else if (index  < rating) {
          return Icon(Icons.star_half,
              color: filledStarColor, size: starSize); // Half filled star
        } else {
          return Icon(Icons.star_border,
              color: unfilledStarColor, size: starSize); // Empty star
        }
      }),
      const SizedBox(height: 5,),
      Text(
        '${rating.toStringAsFixed(1)}/$maxRating',
        
      )
    ]);
  }
}