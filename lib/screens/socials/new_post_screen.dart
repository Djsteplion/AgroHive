import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart'; // For generating new post IDs
import '../../providers/social_provider.dart';
import '../../models/post_model.dart';
import 'package:image_picker/image_picker.dart'; // ✨ NEW: Import image_picker ✨
import 'dart:io'; // ✨ NEW: Import for File class ✨

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {

  File? _pickedImage; // ✨ NEW: Variable to store the picked image file ✨
  final ImagePicker _picker = ImagePicker(); // ✨ NEW: ImagePicker instance ✨


  // ✨ NEW: Function to pick an image ✨
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70); // Example: gallery, 70% quality
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
    }
  }

  // --- Controllers for text fields, declared as State variables ---
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  // --- Initialize controllers and other setup in initState ---
  @override
  void initState() {
    super.initState();
    // No explicit initialization needed beyond declaration for TextEditingController
    // as they are typically ready to use after being declared.
  }

  // --- Dispose controllers to prevent memory leaks ---
  @override
  void dispose() {
    _contentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  // --- Helper function to handle post submission ---
  void _submitPost() {
    // Access provider and currentUser inside a method that has a valid BuildContext
    final socialProvider = Provider.of<SocialProvider>(context, listen: false);
    final currentUser = socialProvider.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to create a post.')),
      );
      return;
    }

    if (_contentController.text.isNotEmpty) {
      final newPost = PostModel(
        id: const Uuid().v4(),
        userId: currentUser.id,
        userName: currentUser.username,
        userAvatar: currentUser.avatarUrl.isNotEmpty ? currentUser.avatarUrl : 'assets/default_avatar.png',
        content: _contentController.text,
        imageUrl:  _pickedImage?.path ?? '',//  Use text from image URL controller
        timestamp: DateTime.now(),
        likes: 0,
        isLiked: false,
        comments: [],
        downloads: 0,
        isDownloaded: false,
        bookmarks: 0,
        isBookmarked: false,
      );
      socialProvider.addPost(newPost);
      Navigator.of(context).pop(); // Go back to the previous screen (AgroConnect feed)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post added successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post content cannot be empty.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Note: socialProvider and currentUser are now accessed directly in _submitPost()
    // or if needed for UI decisions, they can be accessed here in build:
    // final socialProvider = Provider.of<SocialProvider>(context);
    // final currentUser = socialProvider.currentUser;

    return Scaffold(
      appBar: AppBar( // Added an AppBar for better navigation and title
        title:  Center(
          child: Text('Start a post',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        leading: IconButton( // Custom back button
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(), // Pop to go back
        ),
      ),
      body: SingleChildScrollView( // Use SingleChildScrollView to prevent overflow when keyboard appears
        child: Padding(
          padding: const EdgeInsets.all(16.0), // General padding for the screen content
          // Removed the extra Container and MediaQuery.of(context).viewInsets.bottom
          // as SingleChildScrollView handles keyboard avoidance and AppBar handles top spacing
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Align content to start
            children: [
              // No need for the Row with 'Create New Post' and 'Close' button
              // as AppBar now handles title and navigation.
              
              TextField(
                controller: _contentController, // Use _contentController
                maxLines: 25,
                decoration: const InputDecoration(
                  hintText: 'What\'s on your mind?',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(1)),
                    ),
                    enabledBorder:  OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1,
                          ),
                ),
              ),
              ),
              
              Row(
                children: [
                  IconButton(
                onPressed: (){
                  _pickImage();
                },
                icon: Icon(Icons.add_a_photo)
                ),
                SizedBox(width: 3),
                IconButton(
                onPressed: (){
                  _pickImage();
                },
                icon: Icon(Icons.add)
                ),
              
                 Spacer(),
                  ElevatedButton(
                    onPressed: _submitPost, // Call the helper function
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 28, 98, 6), // Green background
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: const Text(
                      'Add Post',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
