import 'package:bobde6_multi_store/models/product_model.dart';
import 'package:bobde6_multi_store/views/buyers/inner_screens/product_detail_screen.dart';
import 'package:bobde6_multi_store/views/buyers/nav_screen/widgets/product_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeProductWidget extends StatelessWidget {
  const HomeProductWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> productsStream =
        FirebaseFirestore.instance.collection('products').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: productsStream,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Error loading products'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data?.docs ?? [];
        if (docs.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(
              child: Text(
                'No Products Available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ),
          );
        }

        return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.all(10),
          itemCount: docs.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.8,
          ),
          itemBuilder: (context, index) {
            final productData = ProductModel.fromMap(
              docs[index].data() as Map<String, dynamic>,
              docs[index].id,
            );
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      productData: productData,
                    ),
                  ),
                );
              },
              child: ProductCardWidget(productData: productData),
            );
          },
        );
      },
    );
  }
}
