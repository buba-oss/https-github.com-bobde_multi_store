import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.yellow.shade900,
        title: const Text(
          'Categories',
          style: TextStyle(
            letterSpacing: 4,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: categoryStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading categories'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(child: Text('No categories available'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(15),
            itemCount: docs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              childAspectRatio: 1,
            ),
            itemBuilder: (context, index) {
              final categoryData = docs[index].data() as Map<String, dynamic>;
              final String categoryName =
                  categoryData['categoryName'] ?? categoryData['name'] ?? '';
              final String categoryImage =
                  categoryData['image'] ?? categoryData['categoryImage'] ?? '';

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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 80,
                      width: 80,
                      child: categoryImage.isNotEmpty
                          ? Image.network(
                              categoryImage,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.category, size: 50),
                            )
                          : const Icon(Icons.category, size: 50),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      categoryName,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
