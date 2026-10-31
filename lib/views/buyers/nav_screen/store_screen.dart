import 'package:bobde6_multi_store/views/buyers/inner_screens/store_detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> vendorStream =
        FirebaseFirestore.instance.collection('vendors').snapshots();

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        backgroundColor: Colors.yellow.shade900,
        title: const Text(
          'Stores / Vendors',
          style: TextStyle(
            letterSpacing: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: vendorStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading stores'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data?.docs ?? [];
          if (docs.isEmpty) {
            return const Center(
              child: Text(
                'No Stores Available',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final vendorData = docs[index].data() as Map<String, dynamic>;
              final String storeName = vendorData['bussinessName'] ??
                  vendorData['storeName'] ??
                  'Vendor';
              final String storeImage =
                  vendorData['storeImage'] ?? vendorData['profileImage'] ?? '';
              final String email = vendorData['email'] ?? '';

              return Card(
                elevation: 3,
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.yellow.shade900,
                    backgroundImage:
                        storeImage.isNotEmpty ? NetworkImage(storeImage) : null,
                    child: storeImage.isEmpty
                        ? const Icon(Icons.store, color: Colors.white, size: 30)
                        : null,
                  ),
                  title: Text(
                    storeName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    email.isNotEmpty ? email : 'Verified Vendor',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => StoreDetailScreen(
                          vendorData: vendorData,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
