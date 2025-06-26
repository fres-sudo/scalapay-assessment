import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scalapay_assessment/cubits/product_filters/product_filters_cubit.dart';
import 'package:scalapay_assessment/ui/widgets/custom_bottom_sheet.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    minPriceController.text =
        context.productFiltersCubit.state.minPrice?.toStringAsFixed(2) ?? "";
    maxPriceController.text =
        context.productFiltersCubit.state.maxPrice?.toStringAsFixed(2) ?? "";
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: "Flitri",
      height: 250,
      child: Column(
        spacing: 20,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Text(
                  "Fascia di prezzo",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: minPriceController,
                        decoration: InputDecoration(labelText: "Minimo"),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Container(
                      width: 9,
                      height: 1,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: maxPriceController,
                        decoration: InputDecoration(labelText: "Massimo"),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Cancella tutto",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: FilledButton(
                  onPressed: () {
                    final minPrice = double.tryParse(minPriceController.text);
                    final maxPrice = double.tryParse(maxPriceController.text);
                    if (minPrice == null || maxPrice == null) {
                      Navigator.of(context).maybePop();
                      return;
                    }
                    if (minPrice > maxPrice) {
                      showAdaptiveDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog.adaptive(
                            title: Text("Errore"),
                            content: Text(
                              "Il prezzo minimo non può essere maggiore del prezzo massimo.",
                            ),
                            actions: [
                              Platform.isIOS
                                  ? CupertinoActionSheetAction(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"),
                                  )
                                  : TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("OK"),
                                  ),
                            ],
                          );
                        },
                      );
                      return;
                    }

                    final cubit = context.productFiltersCubit;

                    cubit.filter(
                      request: cubit.state.copyWith(
                        minPrice: minPrice,
                        maxPrice: maxPrice,
                      ),
                    );

                    Navigator.pop(context);
                  },
                  child: Text(
                    "Mostra risultati",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
