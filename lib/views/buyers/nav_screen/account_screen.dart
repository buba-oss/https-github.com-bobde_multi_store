import 'package:bobde6_multi_store/controllers/auth_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final AuthController authController = AuthController();
    final User? user = auth.currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Not logged in'),
              ElevatedButton(
                onPressed: () {
                  authController.signOut();
                },
                child: const Text('Go to Login'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.yellow.shade900,
        title: const Text(
          'Profile',
          style: TextStyle(letterSpacing: 4),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await authController.signOut();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: firestore.collection('buyers').doc(user.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Profile data not found.'),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      await authController.signOut();
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
          }

          final data = snapshot.data!.data() as Map<String, dynamic>;
          final String fullName = data['fullName'] ?? 'Customer';
          final String email = data['email'] ?? user.email ?? '';
          final String phoneNumber = data['phoneNumber'] ?? 'N/A';
          final String profileImage = data['profileImage'] ?? '';
          final String address = data['address'] ?? '';

          return SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                Center(
                  child: CircleAvatar(
                    radius: 64,
                    backgroundColor: Colors.yellow.shade900,
                    backgroundImage: profileImage.isNotEmpty
                        ? NetworkImage(profileImage)
                        : null,
                    child: profileImage.isEmpty
                        ? const Icon(Icons.person,
                            size: 64, color: Colors.white)
                        : null,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  fullName,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  email,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 25),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: const Text('Email'),
                  subtitle: Text(email),
                ),
                ListTile(
                  leading: const Icon(Icons.phone),
                  title: const Text('Phone Number'),
                  subtitle: Text(phoneNumber),
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: const Text('Address'),
                  subtitle: Text(address.isEmpty ? 'No address set' : address),
                ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.yellow.shade900,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        await authController.signOut();
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        'LOGOUT',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
