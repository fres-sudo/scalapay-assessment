import 'package:flutter/material.dart';
import 'package:scalapay_assessment/ui/sizes.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    super.key,
    required this.child,
    required this.title,
    this.height = 400,
  });

  final double height;
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        Sizes.lg,
        0,
        Sizes.lg,
        MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SizedBox(
        height: height,
        child: Column(
          children: [
            const SizedBox(height: Sizes.sm),
            Container(
              height: 5,
              width: 45,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(Sizes.borderRadius / 2),
              ),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                child: Icon(Icons.close, color: Colors.black),
                onTap: () => Navigator.of(context).pop(),
              ),
            ),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: Sizes.lg),
            child,
          ],
        ),
      ),
    );
  }
}
