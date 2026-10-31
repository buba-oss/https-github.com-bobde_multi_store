import 'package:bobde6_multi_store/models/product_model.dart';
import 'package:bobde6_multi_store/views/buyers/inner_screens/product_detail_screen.dart';
import 'package:bobde6_multi_store/views/buyers/nav_screen/widgets/product_card_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreDetailScreen extends StatelessWidget {
  final Map<String, dynamic> vendorData;

  const StoreDetailScreen({
    super.key,
    required this.vendorData,
  });

  @override
  Widget build(BuildContext context) {
    final String storeName = vendorData['bussinessName'] ??
        vendorData['storeName'] ??
        'Store Details';
    final String storeImage =
        vendorData['storeImage'] ?? vendorData['profileImage'] ?? '';
    final String email = vendorData['email'] ?? '';
    final String phoneNumber = vendorData['phoneNumber'] ?? '';
    final String vendorId =
        vendorData['vendorId'] ?? vendorData['buyerId'] ?? '';

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.yellow.shade900,
        title: Text(
          storeName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Store Banner / Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              color: Colors.yellow.shade100,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.yellow.shade900,
                    backgroundImage:
                        storeImage.isNotEmpty ? NetworkImage(storeImage) : null,
                    child: storeImage.isEmpty
                        ? const Icon(Icons.store, size: 50, color: Colors.white)
                        : null,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    storeName,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (email.isNotEmpty)
                    Text(
                      email,
                      style: const TextStyle(color: Colors.grey),
                    ),
                  if (phoneNumber.isNotEmpty)
                    Text(
                      phoneNumber,
                      style: const TextStyle(color: Colors.grey),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 15),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Store Products',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Products Stream
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('products')
                  .where('vendorId', isEqualTo: vendorId)
                  .snapshots(),
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
                    padding: EdgeInsets.all(30.0),
                    child: Center(
                      child: Text(
                        'This store has no products listed yet.',
                        style: TextStyle(color: Colors.grey),
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
            ),
          ],
        ),
      ),
    );
  }
}
