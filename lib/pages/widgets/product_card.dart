import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scalapay_assessment/models/product/product.dart';
import 'package:scalapay_assessment/ui/extensions.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  Future<void> _launchUrl(BuildContext context) async {
    final Uri _url = Uri.parse(product.url);
    try {
      final bool hasBennLaunched = await launchUrl(
        _url,
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
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            product.hasImage
                ? ClipRRect(
                  borderRadius: BorderRadius.circular(20),
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

            const SizedBox(height: 12.0),
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
            const SizedBox(height: 8.0),
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
