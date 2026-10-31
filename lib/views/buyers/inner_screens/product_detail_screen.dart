import 'package:bobde6_multi_store/models/product_model.dart';
import 'package:bobde6_multi_store/provider/cart_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel productData;

  const ProductDetailScreen({
    super.key,
    required this.productData,
  });

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _imageIndex = 0;
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final product = widget.productData;

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          product.productName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Images PageView
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: product.imageUrls.isNotEmpty
                        ? product.imageUrls.length
                        : 1,
                    onPageChanged: (index) {
                      setState(() {
                        _imageIndex = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      if (product.imageUrls.isEmpty) {
                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.image, size: 100),
                        );
                      }
                      return Image.network(
                        product.imageUrls[index],
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image, size: 100),
                      );
                    },
                  ),
                  if (product.imageUrls.length > 1)
                    Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          product.imageUrls.length,
                          (index) => Container(
                            margin: const EdgeInsets.symmetric(horizontal: 3),
                            width: _imageIndex == index ? 12 : 8,
                            height: 8,
                            decoration: BoxDecoration(
                              color: _imageIndex == index
                                  ? Colors.yellow.shade900
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.productName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow.shade900,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Chip(
                    backgroundColor: Colors.yellow.shade100,
                    label: Text(
                      'Category: ${product.category}',
                      style: TextStyle(
                        color: Colors.yellow.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Quantity Selector
                  Row(
                    children: [
                      const Text(
                        'Quantity: ',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          if (_quantity > 1) {
                            setState(() {
                              _quantity--;
                            });
                          }
                        },
                        icon: const Icon(Icons.remove_circle_outline),
                      ),
                      Text(
                        '$_quantity',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _quantity++;
                          });
                        },
                        icon: const Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),

                  // Description Header
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description.isEmpty
                        ? 'No description available for this product.'
                        : product.description,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Vendor Information Card
                  if (product.vendorId.isNotEmpty)
                    FutureBuilder<DocumentSnapshot>(
                      future: FirebaseFirestore.instance
                          .collection('vendors')
                          .doc(product.vendorId)
                          .get(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || !snapshot.data!.exists) {
                          return const SizedBox.shrink();
                        }
                        final vendor =
                            snapshot.data!.data() as Map<String, dynamic>;
                        final String storeName = vendor['bussinessName'] ??
                            vendor['storeName'] ??
                            'Vendor';
                        final String storeImage = vendor['storeImage'] ??
                            vendor['profileImage'] ??
                            '';

                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: storeImage.isNotEmpty
                                  ? NetworkImage(storeImage)
                                  : null,
                              child: storeImage.isEmpty
                                  ? const Icon(Icons.store)
                                  : null,
                            ),
                            title: Text(storeName),
                            subtitle: const Text('Verified Seller'),
                            trailing:
                                const Icon(Icons.arrow_forward_ios, size: 16),
                          ),
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 70,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.3),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow.shade900,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  final cartProvider =
                      Provider.of<CartProvider>(context, listen: false);
                  cartProvider.addProductToCart(
                    productId: product.productId,
                    productName: product.productName,
                    price: product.price,
                    imageUrls: product.imageUrls,
                    quantity: _quantity,
                    vendorId: product.vendorId,
                    productQuantity: product.quantity,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.yellow.shade900,
                      content: Text('${product.productName} added to cart!'),
                    ),
                  );
                },
                icon: const Icon(Icons.shopping_cart, color: Colors.white),
                label: const Text(
                  'ADD TO CART',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
