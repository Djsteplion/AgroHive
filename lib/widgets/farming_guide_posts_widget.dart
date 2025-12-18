import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/social_provider.dart';
import '../models/farming_guide_post_model.dart';

class FarmingGuidePostsWidget extends StatelessWidget {
  const FarmingGuidePostsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final socialProvider = Provider.of<SocialProvider>(context);
    final guidePosts = socialProvider.farmingGuidePosts;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Master Modern Farming Tools',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 19,
                  color: Colors.black,
                ),
              ),
             SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Explore our video guides to learn how to",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "use cutting-edge agricultural tools ",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: guidePosts.length,
            itemBuilder: (ctx, i) {
              final post = guidePosts[i];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0), // Adjust this value for the "roundness"
                  ),
                child: Padding(
                  padding: EdgeInsets.only(top:5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- Image/Video Thumbnail Section (moved to top) ---
                      if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              post.imageUrl!,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: 200, // Fixed height for guide images/videos
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
                            if (post.type == FarmingGuidePostType.video)
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.5),
                                  shape: BoxShape.circle,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.play_arrow, color: Colors.white, size: 40),
                                  onPressed: () {
                                    // TODO: Implement video playback logic here
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text('Playing video: ${post.title}')),
                                    );
                                  },
                                ),
                              ),
                          ],
                        ),
                      // --- Title Section (now below image/video) ---
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          post.title,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      // --- Content Text Section (remains below title) ---
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(post.content),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
