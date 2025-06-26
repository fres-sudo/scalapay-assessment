import 'package:flutter/material.dart';
import 'package:scalapay_assessment/cubits/product_filters/product_filters_cubit.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';
import 'package:scalapay_assessment/ui/widgets/custom_bottom_sheet.dart';

class SortOrderBottomSheet extends StatelessWidget {
  const SortOrderBottomSheet({super.key});

  static const sortOptions = {
    "Prezzo crescente": SearchProductRequest(
      sortDirection: "asc",
      sortType: "selling_price",
    ),
    "Prezzo decrescente": SearchProductRequest(
      sortDirection: "desc",
      sortType: "selling_price",
    ),
    "Nome A-Z": SearchProductRequest(
      sortDirection: "asc",
      sortType: "text_match",
    ),
    "Nome Z-A": SearchProductRequest(
      sortDirection: "desc",
      sortType: "text_match",
    ),
  };

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: "Ordina",
      height: 450,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          itemCount: sortOptions.length,
          itemBuilder: (context, index) {
            return RadioListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                sortOptions.keys.toList()[index],
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              radioScaleFactor: 1.2,
              onChanged: (value) {
                context.productFiltersCubit.filter(
                  request: sortOptions[value] ?? SearchProductRequest.empty(),
                );
                Navigator.pop(context);
              },
              value: sortOptions.keys.toList()[index],
              groupValue: sortOptions.keys.toList().first, // TODO: replace
              activeColor: Theme.of(context).colorScheme.primary,
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
    );
  }
}
