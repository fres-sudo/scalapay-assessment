import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:scalapay_assessment/blocs/product/product_bloc.dart';
import 'package:scalapay_assessment/cubits/product_filters/product_filters_cubit.dart';
import 'package:scalapay_assessment/pages/widgets/filter_bottom_sheet.dart';
import 'package:scalapay_assessment/pages/widgets/product_search_field.dart';
import 'package:scalapay_assessment/pages/widgets/products_grid.dart';
import 'package:scalapay_assessment/pages/widgets/sort_order_bottom_sheet.dart';
import 'package:scalapay_assessment/services/network/requests/search_product/search_product_request.dart';
import 'package:scalapay_assessment/ui/assets.dart';
import 'package:scalapay_assessment/ui/extensions.dart';
import 'package:scalapay_assessment/ui/sizes.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductFiltersCubit, SearchProductRequest>(
      listener: (context, state) => context.productBloc.search(request: state),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.lg),
            child: RefreshIndicator.adaptive(
              onRefresh: () async {
                context.productBloc.search(
                  request: context.productFiltersCubit.state,
                );
              },
              edgeOffset: 50,
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                        10,
                        57,
                        Sizes.lg,
                        Sizes.lg,
                      ),
                      child: Text(
                        'Esplora i prodotti',
                        style: Theme.of(context).textTheme.headlineMedium?.bold,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      spacing: Sizes.md,
                      children: [
                        ProductSearchField(),
                        Row(
                          spacing: Sizes.sm,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton.icon(
                              onPressed:
                                  () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder: (context) => FilterBottomSheet(),
                                  ),
                              label: Text('Filtri'),
                              icon: SvgPicture.asset(
                                AppAssets.filterIcon,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            ElevatedButton.icon(
                              onPressed:
                                  () => showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    builder:
                                        (context) => SortOrderBottomSheet(),
                                  ),
                              icon: SvgPicture.asset(
                                AppAssets.arrowsIcon,
                                colorFilter: ColorFilter.mode(
                                  Theme.of(context).colorScheme.onSurface,
                                  BlendMode.srcIn,
                                ),
                              ),
                              label: Text('Ordina'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ProductsGrid(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
