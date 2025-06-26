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
      sortType: "_text_match",
    ),
    "Nome Z-A": SearchProductRequest(
      sortDirection: "desc",
      sortType: "_text_match",
    ),
  };

  String? _getStringKeyForSortRequest(SearchProductRequest request) {
    for (final entry in sortOptions.entries) {
      if (entry.value.sortType == request.sortType &&
          entry.value.sortDirection == request.sortDirection) {
        return entry.key;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final currentFilterRequest = context.watchProductFiltersCubit.state;
    final String? currentSelectedString = _getStringKeyForSortRequest(
      currentFilterRequest,
    );
    return CustomBottomSheet(
      title: "Ordina",
      height: 400,
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
            final String optionStringKey = sortOptions.keys.toList()[index];
            return RadioListTile<String>(
              contentPadding: EdgeInsets.zero,
              title: Text(
                optionStringKey,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              radioScaleFactor: 1.2,
              onChanged: (value) {
                final cubit = context.productFiltersCubit;
                cubit.filter(
                  request: cubit.state.copyWith(
                    sortDirection:
                        sortOptions[optionStringKey]?.sortDirection ?? "asc",
                    sortType:
                        sortOptions[optionStringKey]?.sortType ??
                        "selling_price",
                  ),
                );
                Navigator.pop(context);
              },
              value: optionStringKey,
              groupValue: currentSelectedString,
              activeColor: Theme.of(context).colorScheme.primary,
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
      ),
    );
  }
}
