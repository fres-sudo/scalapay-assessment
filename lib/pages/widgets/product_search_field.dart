import 'package:flutter/material.dart';
import 'package:scalapay_assessment/cubits/product_filters/product_filters_cubit.dart';

class ProductSearchField extends StatefulWidget {
  const ProductSearchField({super.key});

  @override
  State<ProductSearchField> createState() => _ProductSearchFieldState();
}

class _ProductSearchFieldState extends State<ProductSearchField> {
  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      decoration: InputDecoration(
        hintText: 'Cerca prodotti...',
        suffixIconConstraints: const BoxConstraints(
          minHeight: 45,
          minWidth: 45,
        ),
        suffixIcon: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(100)),
          onTap: () {
            final cubit = context.productFiltersCubit;
            cubit.filter(
              request: cubit.state.copyWith(
                query:
                    searchController.text.isEmpty
                        ? 'all'
                        : searchController.text,
              ),
            );
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Icon(Icons.search, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
