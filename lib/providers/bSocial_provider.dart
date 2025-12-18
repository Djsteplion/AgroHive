/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../models/user_model.dart';
import '../models/post_model.dart';
import '../models/comment_model.dart';
import '../models/farming_guide_post_model.dart';

class SocialProvider with ChangeNotifier {
  List<UserModel> _users = [];
  UserModel? _currentUser;
  final Uuid _uuid = const Uuid();

  // Define initial posts with dummy comments and NOW with timestamps!
  final List<PostModel> _initialPosts = [
    PostModel(
      id: '1',
      userId: 'user123',
      userName: 'John Doe',
      userAvatar: 'assets/Frame 626665.png',
      content: 'Hello AgroHive community! 🌱 This is a slightly longer post to test the "show more" functionality. '
          'We are discussing the latest trends in sustainable agriculture and how small farmers can adopt them. '
          'Cover cropping, efficient irrigation, and integrated pest management are just a few examples. '
          'Implementing these practices can lead to healthier soil, reduced water usage, and higher yields. '
          'Join the conversation and share your experiences! Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
          'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation '
          'ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit '
          'esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui '
          'officia deserunt mollit anim id est laborum.',
      imageUrl: 'assets/Frame 30 (1).png',
      likes: 5,
      isLiked: false,
      comments: [
        CommentModel(
          id: const Uuid().v4(),
          userId: 'user456',
          userName: 'Jane Smith',
          userAvatar: 'assets/Ellipse 5.png',
          content: 'Great post, John!',
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        CommentModel(
          id: const Uuid().v4(),
          userId: 'user789',
          userName: 'AgriTech Fan',
          userAvatar: 'assets/Ellipse 5.png',
          content: 'AgroHive is amazing!',
          likes: 1,
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        CommentModel(
          id: const Uuid().v4(),
          userId: 'user123',
          userName: 'John Doe',
          userAvatar: 'assets/Frame 626665.png',
          content: 'Love the green vibes! 🌿',
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      downloads: 2, // Dummy downloads
      isDownloaded: false,
      bookmarks: 1, // Dummy bookmarks
      isBookmarked: false,
    ),
    PostModel(
      id: '2',
      userId: 'user456',
      userName: 'Jane Smith',
      userAvatar: 'assets/Ellipse 5.png',
      content: 'Excited about this harvest season 🍅🌽. The weather has been perfect, and the soil is incredibly fertile this year. '
          'I\'m expecting a record yield for my corn and tomatoes. What\'s everyone else harvesting these days? '
          'Any tips for preserving fresh produce? I\'m looking for new recipes and storage ideas to make the most of this bounty. '
          'Please share your favorite methods and techniques! The community is always a great source of inspiration.',
      imageUrl: 'assets/agricProduce.png',
      likes: 12,
      isLiked: true,
      comments: [
        CommentModel(
          id: const Uuid().v4(),
          userId: 'user123',
          userName: 'John Doe',
          userAvatar: 'assets/Frame 626665.png',
          content: 'Me too, Jane! What are you growing?',
          likes: 2,
          timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        CommentModel(
          id: const Uuid().v4(),
          userId: 'user789',
          userName: 'AgriTech Fan',
          userAvatar: 'assets/Ellipse 5.png',
          content: 'Looks promising!',
          timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(days: 3)),
      downloads: 5,
      isDownloaded: true,
      bookmarks: 3,
      isBookmarked: true,
    ),
    PostModel(
      id: '3',
      userId: 'user789',
      userName: 'AgriTech Fan',
      userAvatar: 'assets/Frame 626665.png',
      content: 'Just installed my new automated irrigation system!💧 It\'s a game-changer for water conservation and crop health. '
          'The system uses sensors to monitor soil moisture and weather forecasts, delivering water precisely when and where it\'s needed. '
          'This significantly reduces waste and ensures optimal growth conditions. I highly recommend looking into smart irrigation solutions for your farm. '
          'It\'s an investment that pays off quickly in terms of efficiency and environmental benefits. Feel free to ask any questions about my setup!',
      imageUrl: 'assets/Frame 30 (1).png',
      likes: 8,
      isLiked: false,
      comments: [
        CommentModel(
          id: const Uuid().v4(),
          userId: 'user123',
          userName: 'John Doe',
          userAvatar: 'assets/Frame 626665.png',
          content: 'That\'s awesome! What system are you using?',
          timestamp: DateTime.now().subtract(const Duration(days: 1)),
        ),
      ],
      timestamp: DateTime.now().subtract(const Duration(days: 7)),
      downloads: 1,
      isDownloaded: false,
      bookmarks: 0,
      isBookmarked: false,
    ),
  ];

  final List<FarmingGuidePostModel> _farmingGuidePosts = [
    FarmingGuidePostModel(
      id: 'fg1',
      title: 'How to Start a Hydroponic Garden',
      content: 'Learn the basics of setting up your own hydroponic system at home. This guide covers everything from choosing your plants to nutrient solutions.',
      imageUrl: 'assets/tractors.png',
      type: FarmingGuidePostType.video,
      videoUrl: 'https://youtube.com/hydroponics_tutorial',
    ),
    FarmingGuidePostModel(
      id: 'fg2',
      title: 'Top 5 Organic Pest Control Methods',
      content: 'Protect your crops naturally with these effective and eco-friendly pest control strategies. Say goodbye to harmful chemicals!',
      imageUrl: 'assets/Group 1000006806 (2).png',
      type: FarmingGuidePostType.image,
    ),
    FarmingGuidePostModel(
      id: 'fg3',
      title: 'Understanding Soil pH for Optimal Growth',
      imageUrl: 'assets/mower.png',
      content: 'Soil pH is critical for nutrient absorption. This article explains how to test your soil, understand the results, and adjust pH levels for different crops.',
      type: FarmingGuidePostType.text,
    ),
    FarmingGuidePostModel(
      id: 'fg4',
      title: 'Vertical Farming: The Future of Urban Agriculture',
      content: 'Explore the innovative world of vertical farming, its benefits, and how it\'s transforming food production in urban environments. A short documentary.',
      imageUrl: 'assets/image (1)(1).png',
      type: FarmingGuidePostType.video,
      videoUrl: 'https://youtube.com/vertical_farming_doc',
    ),
  ];
  
  // getter  to expose the posts
  List<PostModel> get initialPosts => _initialPosts;

  List<PostModel> _posts = [];

  List<UserModel> get users => [..._users];
  List<PostModel> get posts => [..._posts];
  List<FarmingGuidePostModel> get farmingGuidePosts => [..._farmingGuidePosts];

  // --- NEW: Toggle Follow for a user ---
  void toggleFollow(String userIdToFollow) {
    if (_currentUser == null) {
      print('Error: Cannot follow, no user logged in.');
      return;
    }

    // Find the current user in the _users list
    final currentUserIndex = _users.indexWhere((u) => u.id == _currentUser!.id);
    if (currentUserIndex != -1) {
      final user = _users[currentUserIndex];
      if (user.followedUserIds.contains(userIdToFollow)) {
        user.followedUserIds.remove(userIdToFollow);
      } else {
        user.followedUserIds.add(userIdToFollow);
      }
      _currentUser = user; // Update the _currentUser reference
      notifyListeners();
      saveData();
    }
  }

  // --- NEW: Toggle Download for a post ---
  void toggleDownload(PostModel post) {
    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index].isDownloaded = !_posts[index].isDownloaded;
      if (_posts[index].isDownloaded) {
        _posts[index].downloads++;
      } else {
        _posts[index].downloads--;
      }
      notifyListeners();
      saveData();
    }
  }

  // --- NEW: Toggle Bookmark for a post ---
  void toggleBookmark(PostModel post) {
    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index].isBookmarked = !_posts[index].isBookmarked;
      if (_posts[index].isBookmarked) {
        _posts[index].bookmarks++;
      } else {
        _posts[index].bookmarks--;
      }
      notifyListeners();
      saveData();
    }
  }

  void toggleLike(PostModel post) {
    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      _posts[index].isLiked = !_posts[index].isLiked;
      if (_posts[index].isLiked) {
        _posts[index].likes++;
      } else {
        _posts[index].likes--;
      }
      notifyListeners();
      saveData();
    }
  }

  void addComment(PostModel post, String commentContent) {
    if (_currentUser == null) {
      print('Error: Cannot add comment, no user logged in.');
      return;
    }

    final index = _posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      final newComment = CommentModel(
        id: _uuid.v4(),
        userId: _currentUser!.id,
        userName: _currentUser!.username,
        userAvatar: _currentUser!.avatarUrl.isNotEmpty ? _currentUser!.avatarUrl : 'assets/Frame 1194.png',
        content: commentContent,
        timestamp: DateTime.now(),
      );
      _posts[index].comments.add(newComment);
      notifyListeners();
      saveData();
    }
  }

  void toggleLikeComment(PostModel post, CommentModel comment) {
    final postIndex = _posts.indexWhere((p) => p.id == post.id);
    if (postIndex != -1) {
      final commentIndex = _posts[postIndex].comments.indexWhere((c) => c.id == comment.id);
      if (commentIndex != -1) {
        _posts[postIndex].comments[commentIndex].isLiked =
            !_posts[postIndex].comments[commentIndex].isLiked;
        if (_posts[postIndex].comments[commentIndex].isLiked) {
          _posts[postIndex].comments[commentIndex].likes++;
        } else {
          _posts[postIndex].comments[commentIndex].likes--;
        }
        notifyListeners();
        saveData();
      }
    }
  }

  // Modified addPost to include initial values for new fields
  void addPost(PostModel post) {
    final newPost = PostModel(
      id: post.id,
      userId: post.userId,
      userName: post.userName,
      userAvatar: post.userAvatar,
      content: post.content,
      imageUrl: post.imageUrl,
      likes: 0, // New posts start with 0 likes
      isLiked: false,
      comments: [],
      timestamp: DateTime.now(), // Set current time for new posts
      downloads: 0,
      isDownloaded: false,
      bookmarks: 0,
      isBookmarked: false,
    );
    _posts.insert(0, newPost);
    notifyListeners();
    saveData();
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setStringList(
      'users',
      _users.map((u) => json.encode(u.toMap())).toList(),
    );

    prefs.setStringList(
      'posts',
      _posts.map((p) => json.encode(p.toMap())).toList(),
    );

    if (_currentUser != null) {
      prefs.setString('currentUser', json.encode(_currentUser!.toMap()));
    } else {
      prefs.remove('currentUser');
    }
  }

  bool signup(UserModel user) {
    if (_users.any((u) => u.username == user.username)) {
      return false;
    }
    // New user starts with an empty list of followed users
    final newUser = UserModel(
      id: user.id,
      username: user.username,
      email: user.email,
      fullName: user.fullName,
      avatarUrl: user.avatarUrl,
      password: user.password,
      followedUserIds: [], // Initialize empty
    );
    _users.add(newUser);
    _currentUser = newUser;
    saveData();
    notifyListeners();
    return true;
  }

  bool checkUsernameExists(String username) {
    return _users.any((u) => u.username == username);
  }

  void logout() {
    _currentUser = null;
    saveData();
    notifyListeners();
  }

  bool signIn(String username, String password) {
    try {
      final user = _users.firstWhere(
        (u) => u.username == username && u.password == password,
      );
      _currentUser = user;
      saveData();
      notifyListeners();
      return true;
    } catch (e) {
      print('Sign In Error: $e');
      return false;
    }
  }

  List<PostModel> get postss => _posts;
  UserModel? get currentUser => _currentUser;

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      final usersData = prefs.getStringList('users') ?? [];
      _users = usersData.map((u) => UserModel.fromMap(json.decode(u))).toList();

      final postsData = prefs.getStringList('posts') ?? [];
      List<PostModel> loadedPosts = [];
      if (postsData.isNotEmpty) {
        loadedPosts = postsData.map((p) => PostModel.fromMap(json.decode(p))).toList();
      }
      
      _posts = loadedPosts;

      if (_posts.isEmpty) {
        _posts.addAll(_initialPosts);
        await saveData();
      }

      final currentUserData = prefs.getString('currentUser');
      if (currentUserData != null) {
        _currentUser = UserModel.fromMap(json.decode(currentUserData));
      }
    } catch (e) {
      print('Error loading data from SharedPreferences: $e');
      _users = [];
      _posts = _initialPosts;
      _currentUser = null;
    }
    notifyListeners();
  }
}
*/