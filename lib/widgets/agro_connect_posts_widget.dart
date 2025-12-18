import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
// ignore: unused_import
import 'package:uuid/uuid.dart'; // For generating new post IDs
import 'package:flutter/services.dart'; // For Clipboard

import '../providers/social_provider.dart';
import '../models/post_model.dart';
import '../screens/socials/new_post_screen.dart';
import 'dart:io';  // For File handling
import 'package:iconsax_flutter/iconsax_flutter.dart';


class AgroConnectPostsWidget extends StatefulWidget {
  const AgroConnectPostsWidget({super.key});

  @override
  State<AgroConnectPostsWidget> createState() => _AgroConnectPostsWidgetState();
}

class _AgroConnectPostsWidgetState extends State<AgroConnectPostsWidget> {
  // Local state to manage content expansion for each post
  final Map<String, bool> _isContentExpandedMap = {};

  // Define a constant for the green color used across the app
  static const Color _agroGreenColor = Color.fromARGB(255, 28, 98, 6);

  // Character limit for post content before showing "Show More"
  final int _contentCharLimit = 150; // Reduced for easier testing with dummy data

  String _formatTimeAgo(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 365) {
      return DateFormat.yMMMd().format(timestamp);
    } else if (difference.inDays > 7) {
      return DateFormat.yMMMd().format(timestamp);
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }

  void _showCommentsBottomSheet(BuildContext context, PostModel post) {
    final TextEditingController commentController = TextEditingController();
    final socialProvider = Provider.of<SocialProvider>(context, listen: false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,

      builder: (ctx) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            final currentPosts = socialProvider.posts;
            final updatedPost = currentPosts.firstWhere((p) => p.id == post.id, orElse: () => post);
            final currentUser = socialProvider.currentUser;

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Container(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                  minHeight: MediaQuery.of(context).size.height * 0.3,
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Comments',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () => Navigator.of(ctx).pop(),
                        ),
                      ],
                    ),
                    const Divider(),
                    if (updatedPost.comments.isEmpty)
                      const Expanded(
                        child: Center(
                          child: Text('No comments yet. Be the first to comment!'),
                        ),
                      )
                    else
                      Expanded(
                        child: ListView.builder(
                          itemCount: updatedPost.comments.length,
                          itemBuilder: (commentCtx, index) {
                            final comment = updatedPost.comments[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: AssetImage(comment.userAvatar),
                                    onBackgroundImageError: (exception, stackTrace) {
                                      print('Error loading comment avatar asset: ${comment.userAvatar}');
                                    },
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        comment.userName,
                                        style: const TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _formatTimeAgo(comment.timestamp),
                                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(comment.content),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: Icon(
                                          comment.isLiked ? Icons.favorite : Icons.favorite_border,
                                          color: comment.isLiked ? Colors.red : null,
                                          size: 20,
                                        ),
                                        onPressed: () {
                                          socialProvider.toggleLikeComment(updatedPost, comment);
                                        },
                                      ),
                                      Text('${comment.likes}'),
                                    ],
                                  ),
                                ),
                                const Divider(height: 1),
                              ],
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 16),
                    if (currentUser != null)
                      TextField(
                        controller: commentController,
                        decoration: InputDecoration(
                          hintText: 'Add a comment...',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              if (commentController.text.isNotEmpty) {
                                socialProvider.addComment(updatedPost, commentController.text);
                                commentController.clear();
                              }
                            },
                          ),
                        ),
                        onSubmitted: (value) {
                           if (value.isNotEmpty) {
                              socialProvider.addComment(updatedPost, value);
                              commentController.clear();
                           }
                        },
                      )
                    else
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          'Please log in to add comments.',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  /*
  void _showAddPostBottomSheet(BuildContext context) {
    final TextEditingController contentController = TextEditingController();
    final TextEditingController imageUrlController = TextEditingController();
    final socialProvider = Provider.of<SocialProvider>(context, listen: false);
    final currentUser = socialProvider.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to create a post.')),
      );
      return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Create New Post',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(ctx).pop(),
                    ),
                  ],
                ),
                const Divider(),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    hintText: 'What\'s on your mind?',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: imageUrlController,
                  decoration: const InputDecoration(
                    hintText: 'Optional: Image Asset Path (e.g., assets/my_image.png)',
                    border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (contentController.text.isNotEmpty) {
                      final newPost = PostModel(
                        id: const Uuid().v4(),
                        userId: currentUser.id,
                        userName: currentUser.username,
                        userAvatar: currentUser.avatarUrl,
                        content: contentController.text,
                        imageUrl: imageUrlController.text,
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
                      Navigator.of(ctx).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post added successfully!')),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Post content cannot be empty.')),
                      );
                    }
                  },
                  child: const Text('Add Post'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  */

  Widget buildPostImage(String imageUrl) {
  if (imageUrl.startsWith('assets/')) {
    // From assets
    return Image.asset(
         imageUrl,
     fit: BoxFit.cover,
     width: double.infinity,
      errorBuilder: (context, error, stackTrace) {
        return Container(
          height: 200,
          color: Colors.grey[300],
          child: const Center(
            child: Icon(Icons.broken_image, color: Colors.grey),
          ),
        );
      },
    );
  } else {
    // From phone storage (File path)
    return Image.file(File(imageUrl), fit: BoxFit.cover);
  }
}


  @override
  Widget build(BuildContext context) {
    final socialProvider = Provider.of<SocialProvider>(context);
    final posts = socialProvider.posts;
    final currentUser = socialProvider.currentUser;

    print('AgroConnectPostsWidget: Number of posts to display: ${posts.length}');

    return Stack(
      children: [
        ListView.builder(
          itemCount: posts.length,
          itemBuilder: (ctx, i) {
            final post = posts[i];
            final bool isFollowing = currentUser?.followedUserIds.contains(post.userId) ?? false;
            final bool isContentExpanded = _isContentExpandedMap[post.id] ?? false;

            // Determine if content needs truncating based on character limit
            final bool isLongContent = post.content.length > _contentCharLimit;
            final String displayedContent = isLongContent && !isContentExpanded
                ? '${post.content.substring(0, _contentCharLimit)}...'
                : post.content;

            return Card(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // This is the main post header Row
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage(post.userAvatar),
                          onBackgroundImageError: (exception, stackTrace) {
                            print('Error loading post avatar asset: ${post.userAvatar}');
                          },
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Row(
                            
                            children: [
                              Text(
                                post.userName,
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              SizedBox(width: 15),
                              Transform.translate(
                                offset: Offset(0, 2.5),
                                child: Row(
                                  children: [
                                    Text(
                                      _formatTimeAgo(post.timestamp),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey[600],
                                        fontSize: 11,
                                      ),
                                    ),
                                    SizedBox(width: 2.5),
                                    Transform.translate(
                                      offset: Offset(0, -5),
                                      child: Text(
                                        '...',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (currentUser != null && currentUser.id != post.userId)
                          GestureDetector(
                            onTap: () {
                              socialProvider.toggleFollow(post.userId);
                            },
                            child: Text(
                              isFollowing ? 'Following' : 'Follow',
                              style: const TextStyle(
                                color: _agroGreenColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (post.imageUrl.isNotEmpty)
                  buildPostImage(post.imageUrl),
                    /*
                    Image.asset(
                      post.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 200,
                          color: Colors.grey[300],
                          child: const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        );
                      },
                    ),
                    */
                  // Post Content (with Show More/Show Less)
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Row(
                        children: [
                        // Like Button
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                post.isLiked ? Iconsax.heart : Iconsax.heart_copy,
                                color: post.isLiked ? Colors.red : null,
                                size: 16,
                              ),
                              onPressed: () {
                                socialProvider.toggleLike(post);
                              },
                            ),
                            Transform.translate(
                              offset: Offset(-10, 0),
                              child: Text("${post.likes}"),
                              ),
                          ],
                        ),
                        // Comment Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Iconsax.message_2_copy, size: 16,),
                              onPressed: () {
                                _showCommentsBottomSheet(context, post);
                              },
                            ),
                            Transform.translate(
                              offset: Offset(-10, 0),
                              child: Text("${post.comments.length}"),
                              ),
                          ],
                        ),
                        // Download Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(
                                post.isDownloaded ? Iconsax.receive_square: Icons.download_outlined,
                                color: post.isDownloaded ? _agroGreenColor : Colors.grey[600],
                                size: 16,
                              ),
                              onPressed: () async {
                                socialProvider.toggleDownload(post);
                                await Clipboard.setData(ClipboardData(text: post.content));
                               if(post.isDownloaded) {ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Post content copied to clipboard!')),
                                ); }
                              },
                            ),
                            Transform.translate(
                              offset: Offset(-10, 0),
                              child: Text("${post.downloads}"),
                              ),
                          ],
                        ),
                        const Spacer(),
                        // Bookmark Button
                        Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(
                                  post.isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                  color: post.isBookmarked ? Colors.black : Colors.grey[600],
                                  size: 16,
                                ),
                                onPressed: () {
                                  socialProvider.toggleBookmark(post);
                                },
                              ),
                              Transform.translate(
                              offset: Offset(-10, 0),
                              child: Text("${post.downloads}"),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Action Buttons Row (Like, Comment, Download, Bookmark)
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                displayedContent,
                                style: const TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                              if (isLongContent) // Only show "Show More/Less" if content is long
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isContentExpandedMap[post.id] = !isContentExpanded;
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4.0),
                                    child: Text(
                                      isContentExpanded ? 'Show Less' : 'Show More',
                                      style: const TextStyle(
                                        color: _agroGreenColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          height: 3,
                          color: Colors.grey[200],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              _showCommentsBottomSheet(context, post);
                            },
                            child: Text(
                              'Add a comment...',
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // Add Post Floating Action Button
        Positioned(
          bottom: 20,
          right:10,
          child: FloatingActionButton( // Using FloatingActionButton directly
              onPressed: () {
              // Navigate to the new AddPostScreen
              Navigator.of(context).push(
                MaterialPageRoute(builder: (ctx) => const AddPostScreen()),
              );
            },
            backgroundColor: Colors.white,
            shape: CircleBorder(),
            child: const Icon(Icons.add, color: _agroGreenColor),
          ),
        ),
      ],
    );
  }
}
