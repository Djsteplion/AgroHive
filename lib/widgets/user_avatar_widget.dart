import 'package:flutter/material.dart';
import 'dart:io'; // Required for FileImage

// Define a default avatar path to use if the user hasn't uploaded one
// or if their uploaded image fails to load.
const String _defaultAvatarAsset = 'assets/Frame 1194.png';

class UserAvatarWidget extends StatefulWidget {
  final String avatarUrl;
  final double radius;

  const UserAvatarWidget({
    super.key,
    required this.avatarUrl,
    this.radius = 20.0, // Default radius
  });

  @override
  State<UserAvatarWidget> createState() => _UserAvatarWidgetState();
}

class _UserAvatarWidgetState extends State<UserAvatarWidget> {
  // Local state to track if the current image provider has failed to load.
  bool _hasImageLoadError = false;

  // This method selects the correct ImageProvider based on the avatarUrl
  // and whether a previous load attempt resulted in an error.
  ImageProvider _getImageProvider() {
    // If there was a previous error, or the avatarUrl is empty/invalid,
    // or it's a dummy network URL (that might fail), use the default asset.
    if (_hasImageLoadError || widget.avatarUrl.isEmpty || widget.avatarUrl == 'assets/Frame 1194.png') {
      return const AssetImage(_defaultAvatarAsset);
    }

    // Check if the URL points to a local asset.
    if (widget.avatarUrl.startsWith('assets/')) {
      return AssetImage(widget.avatarUrl);
    }

    // Assume it's a file path for images uploaded by the user.
    // In a real app, you might also handle network images here.
    final file = File(widget.avatarUrl);
    if (file.existsSync()) {
      return FileImage(file);
    }

    // Fallback if none of the above conditions are met (e.g., file doesn't exist anymore).
    return const AssetImage(_defaultAvatarAsset);
  }

  @override
  void didUpdateWidget(covariant UserAvatarWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset error state if the avatarUrl changes
    if (oldWidget.avatarUrl != widget.avatarUrl) {
      _hasImageLoadError = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: widget.radius,
      // The backgroundImage is determined by _getImageProvider()
      backgroundImage: _getImageProvider(),
      onBackgroundImageError: (exception, stackTrace) {
        // This callback is for logging and setting state, not returning a widget.
        print('Error loading avatar image: ${widget.avatarUrl}, Exception: $exception');
        if (!_hasImageLoadError) { // Prevent unnecessary setState calls
          setState(() {
            _hasImageLoadError = true; // Mark that an error occurred for this image
          });
        }
      },
      // You can also add a child here for a fallback icon/initials if the image still doesn't appear
      // (e.g., if _defaultAvatarAsset also fails or is not desired as a visual fallback).
      // For now, the _getImageProvider() already handles falling back to a default asset.
    );
  }
}
