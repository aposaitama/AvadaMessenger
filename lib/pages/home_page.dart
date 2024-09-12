import 'dart:typed_data';
import 'package:avada_messenger/components/auth/auth_service.dart';
import 'package:avada_messenger/components/home_page/widgets/name_position.dart';
import 'package:avada_messenger/components/image_picking.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Uint8List? _image;
  String? uid;
  String? name;
  String? position;
  String? profileImage;

  //initialize firestore and auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  //fetch data from firebase
  Future<void> _fetchUserData() async {
    User? user = _firebaseAuth.currentUser;

    if (user != null) {
      setState(() {
        uid = user.uid;
      });

      //fetch data from collection
      DocumentSnapshot userDoc =
          await _firebaseFirestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        setState(() {
          name = userDoc['name'];
          position = userDoc['position'];
          profileImage = userDoc['profile_image'];
        });
      }
    }
  }

//upload image to firebase
  Future<void> _uploadImageToFirebase(Uint8List image) async {
    if (uid == null) return;
    final storageRef =
        FirebaseStorage.instance.ref().child('user_images').child('$uid.jpg');

    UploadTask uploadTask = storageRef.putData(image);

    try {
      await uploadTask.whenComplete(() {});
      String imageUrl = await storageRef.getDownloadURL();

      await _firebaseFirestore
          .collection('users')
          .doc(uid)
          .update({'profile_image': imageUrl});
      setState(() {
        profileImage = imageUrl;
      });
    } catch (e) {}
  }

  //logout method
  void logOut() {
    final authService = Provider.of<AuthService>(context, listen: false);
    authService.logOut();
  }

//select image from gallery
  void selectImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      setState(() {
        _image = img;
      });
      await _uploadImageToFirebase(img);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: logOut, icon: const Icon(Icons.logout))
        ],
      ),
      body: uid == null || name == null || position == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Chat App',
                      style: TextStyle(fontSize: 30),
                    ),
                    Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 128,
                              height: 128,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: profileImage != null
                                      ? NetworkImage(profileImage!)
                                      : const NetworkImage(
                                          'https://cdn-icons-png.flaticon.com/512/9187/9187604.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: -10,
                              right: -5,
                              child: IconButton(
                                onPressed: selectImage,
                                icon: const Icon(Icons.add_a_photo_rounded),
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                        Text(
                          'UID: $uid',
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    GestureDetector(
                        onTap: () =>
                            Navigator.pushNamed(context, '/change_data'),
                        child: NameAndPosition()),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/chat_page'),
                      child: SizedBox(
                        width: 150,
                        height: 35,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.green,
                          ),
                          child: const Center(
                            child: Text(
                              'Open chat',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),

                          // color: Colors.green,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
