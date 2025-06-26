import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scalapay_assessment/blocs/product/product_bloc.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/pages/widgets/product_card.dart';
import 'package:scalapay_assessment/ui/sizes.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductBloc, ProductState>(
      builder:
          (context, state) => switch (state) {
            LoadingProductState() => _GridView(
              isLoading: true,
              products: List.generate(30, (i) => Product.fake()),
            ),
            EmptyProductState() => const _EmptyState(),
            SuccessProductState(:final products) => _GridView(
              products: products,
            ),
            ErrorProductState(:final error) => _ErrorState(error.message),
            _ => const SliverToBoxAdapter(child: SizedBox.shrink()),
          },
    );
  }
}

class _GridView extends StatelessWidget {
  const _GridView({required this.products, this.isLoading = false});

  final List<Product> products;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        childAspectRatio: 0.55,
      ),
      delegate: SliverChildBuilderDelegate(
        (_, i) => Skeletonizer(
          enabled: isLoading,
          child: ProductCard(product: products[i]),
        ),
        childCount: products.length,
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState(this.errorMessage);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        spacing: Sizes.lg,
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
          Icon(
            Icons.error_outline_outlined,
            size: Sizes.xxl * 2,
            color: Theme.of(context).colorScheme.error,
          ),
          Text(errorMessage, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          spacing: Sizes.lg,
          children: [
            SizedBox(height: MediaQuery.sizeOf(context).height * 0.15),
            Icon(
              Icons.search_off,
              size: Sizes.xxl * 2,
              color: Colors.grey.shade600,
            ),
            Text(
              'Non sono stati trovati prodotti,\n affina la tua ricerca.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
