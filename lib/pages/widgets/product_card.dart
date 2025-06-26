import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/ui/extensions.dart';
import 'package:scalapay_assessment/ui/sizes.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  Future<void> _launchUrl(BuildContext context) async {
    final Uri url = Uri.parse(product.url);
    try {
      final bool hasBennLaunched = await launchUrl(
        url,
        mode: LaunchMode.inAppBrowserView,
      );

      if (!context.mounted) return;

      if (!hasBennLaunched) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Impossibile aprire il prodotto: ${product.title}"),
          ),
        );
      }
    } on PlatformException catch (_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Errore durante l'apertura del prodotto: ${product.title}",
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _launchUrl(context),
      borderRadius: BorderRadius.circular(Sizes.borderRadius),
      child: Container(
        padding: const EdgeInsets.all(Sizes.sm),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.hasImage
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(Sizes.borderRadius),
                  child: CachedNetworkImage(
                    imageUrl: product.image,
                    fadeInDuration: Duration.zero,
                  ),
                )
                : Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    size: 50,
                    color: Colors.grey.shade500,
                  ),
                ),

            const SizedBox(height: Sizes.md),
            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyMedium?.bold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              product.merchantBrand,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: Sizes.sm),
            Text(
              "${product.price}€ or",
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
            Text(
              "3 installments of ${product.installmentPrice}€",
              style: Theme.of(context).textTheme.bodyMedium?.bold.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
