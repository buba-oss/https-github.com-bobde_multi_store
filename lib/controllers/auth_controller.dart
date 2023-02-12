import 'dart:typed_data';


import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  _uploadProfileImageToStorage(Uint8List image) async {
    Reference ref =
        _storage.ref().child('profilePics').child(_auth.currentUser.uid);

 UploadTask  uploadTask = ref.putData(image);

TaskSnapshot snapshot = await uploadTask;
 String downloadUrl = await snapshot.ref.getDownloadURL();
 return downloadUrl;
  }

  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image Selected');
    }
  }

  Future<String> singUpUsers(String email, String FullName, String password,
      String phoneNumber, Uint8List image) async {
    String res = 'Some error occurred';
    try {
      if (email.isNotEmpty &&
          FullName.isNotEmpty &&
          password.isNotEmpty &&
          phoneNumber.isNotEmpty && image !=null) {
        //Create The users
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);
     String   profileImageUrl = await  _uploadProfileImageToStorage(image);

        await _firestore.collection('buyers').doc(cred.user.uid).set({
          'email': email,
          'fullName': FullName,
          'phoneNumber': phoneNumber,
          'buyerId': cred.user.uid,
          'address': '',
          'profileImage':profileImageUrl,
        });
        res = 'success';
      } else {
        res = 'Please Fields must not be empty';
      }
    } catch (e) {}
    return res;
  }

  loginUser(String email, String password) async {
    String res = 'something thing went wrong';
    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please Fields must not be empty';
      }
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
