import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; 
import 'dart:io'; 
import '../providers/social_provider.dart';
import 'package:provider/provider.dart';


class ProfilePageScreen extends StatefulWidget {
  const ProfilePageScreen({super.key});

  @override
  State<ProfilePageScreen> createState() => _ProfilePageScreenState();
}

class _ProfilePageScreenState extends State<ProfilePageScreen> {
  File? _pickedImage; 
  final ImagePicker _picker = ImagePicker(); 

  bool isNotified = true;
  bool isDarkMode = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      setState(() {
        _pickedImage = File(pickedFile.path);
      });
      // ✨ NEW: Update the provider so the whole app updates
      Provider.of<SocialProvider>(context, listen: false).updateAvatar(pickedFile.path);
    }
  } 

  @override
  Widget build(BuildContext context) {
    final socialProvider = Provider.of<SocialProvider>(context);
    final currentUser = socialProvider.currentUser;

    return Scaffold(
        body: Container(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 20),
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _pickImage, 
                  child: Stack(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          // ✨ MODIFIED: Logic to show current avatar from Provider (Asset or File)
                          image: currentUser != null && currentUser.avatarUrl.isNotEmpty
                              ? (currentUser.avatarUrl.startsWith('assets/')
                                  ? DecorationImage(image: AssetImage(currentUser.avatarUrl), fit: BoxFit.cover)
                                  : DecorationImage(image: FileImage(File(currentUser.avatarUrl)), fit: BoxFit.cover))
                              : const DecorationImage(image: AssetImage('assets/Frame 1194.png'), fit: BoxFit.cover),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            color: Color.fromARGB(255, 17, 86, 143),
                            size: 20,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 5),
                currentUser != null ?
                Text(
                  currentUser.fullName,
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.w600
                  ),
                ) : const Text (
                    "No Name",
                    style: TextStyle(
                      fontSize: 19,
                      color: Colors.black,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                const SizedBox(height: 10),
                GestureDetector(
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(30),
                        right: Radius.circular(30),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center, 
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.edit, size: 23, color: Colors.black),
                        SizedBox(width: 10),
                        Text(
                          'Edit Profile',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      width: 1,
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.inbox_rounded, size: 27, color: Colors.black),
                            const SizedBox(width: 10),
                            const Text('All Posts', style: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Container(
                              height: 40, width: 40,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[100]),
                              child: Center(child: Text('5', style: TextStyle(color: Colors.grey[600]))),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 25, color: Colors.grey[300]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.bookmark, size: 27, color: Colors.black),
                            const SizedBox(width: 10),
                            const Text('Bookmarks', style: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Container(
                              height: 40, width: 40,
                              decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[100]),
                              child: Center(child: Text('5', style: TextStyle(color: Colors.grey[600]))),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 25, color: Colors.grey[300]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.notifications, size: 27, color: Colors.black),
                            const SizedBox(width: 10),
                            const Text('Notifications', style: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => setState(() => isNotified = !isNotified),
                              child: Container(
                                height: 40, width: 40,
                                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey[100]),
                                child: Center(child: Text(isNotified ? 'On' : 'Off', style: TextStyle(color: Colors.grey[600]))),
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios, size: 25, color: Colors.grey[300]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                        ),
                        child: Row(
                          children: [
                            Icon(isDarkMode ? Icons.wb_sunny_rounded : Icons.dark_mode, size: 27, color: Colors.black),
                            const SizedBox(width: 10),
                            Text(isDarkMode ? 'Light Mode' : 'Dark Mode', style: const TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            GestureDetector(
                              onTap: () => setState(() => isDarkMode = !isDarkMode),
                              child: Icon(isDarkMode ? Icons.radio_button_off : Icons.radio_button_on , size: 50, color: Colors.grey[300]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(width: 1, color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.lock, size: 27, color: Colors.black),
                            const SizedBox(width: 10),
                            const Text('Change Password', style: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios, size: 25, color: Colors.grey[300]),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            const Icon(Icons.help, size: 27, color: Colors.black),
                            const SizedBox(width: 10),
                            const Text('Help', style: TextStyle(fontSize: 21, color: Colors.black, fontWeight: FontWeight.w500)),
                            const Spacer(),
                            Icon(Icons.arrow_forward_ios, size: 25, color: Colors.grey[300]),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ]
            ),
          ),
        ),
    );
  }
}