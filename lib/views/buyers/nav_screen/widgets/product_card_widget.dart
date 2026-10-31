import 'package:bobde6_multi_store/models/product_model.dart';
import 'package:flutter/material.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel productData;

  const ProductCardWidget({
    super.key,
    required this.productData,
  });

  @override
  Widget build(BuildContext context) {
    final String mainImage =
        productData.imageUrls.isNotEmpty ? productData.imageUrls.first : '';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              child: SizedBox(
                width: double.infinity,
                child: mainImage.isNotEmpty
                    ? Image.network(
                        mainImage,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image, size: 50),
                      )
                    : const Icon(Icons.image, size: 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  productData.productName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '\$${productData.price.toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow.shade900,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
