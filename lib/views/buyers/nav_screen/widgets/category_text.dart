import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryText extends StatelessWidget {
  const CategoryText({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 45,
            child: StreamBuilder<QuerySnapshot>(
              stream: categoryStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data?.docs ?? [];
                if (docs.isEmpty) {
                  return const Text('No categories available');
                }

                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final categoryData =
                        docs[index].data() as Map<String, dynamic>;
                    final String categoryName = categoryData['categoryName'] ??
                        categoryData['name'] ??
                        '';

                    return Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: ActionChip(
                        backgroundColor: Colors.yellow.shade900,
                        onPressed: () {},
                        label: Text(
                          categoryName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
