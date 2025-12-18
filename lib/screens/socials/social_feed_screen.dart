import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:provider/provider.dart';
// ignore: unused_import
import '../../providers/social_provider.dart';

import '../../widgets/agro_connect_posts_widget.dart';
import '../../widgets/farming_guide_posts_widget.dart';

enum SocialFeedTab { agroConnect, farmingGuide }

class SocialFeedScreen extends StatefulWidget {
  const SocialFeedScreen({super.key});

  @override
  State<SocialFeedScreen> createState() => _SocialFeedScreenState();
}

class _SocialFeedScreenState extends State<SocialFeedScreen> {
  SocialFeedTab _selectedTab = SocialFeedTab.agroConnect; // Default to Agro Connect

  // Define the active tab color as a constant
  static const Color _activeTabColor = Color.fromARGB(255, 28, 98, 6);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 30),
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          children: [
            // --- Tab Header ---
            Container(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                /*
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: const Offset(0, 2), // changes position of shadow
                  ),
                ],*/
              ),
              
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = SocialFeedTab.agroConnect;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Agro Connect',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _selectedTab == SocialFeedTab.agroConnect
                                  ? _activeTabColor // Use custom active color
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (_selectedTab == SocialFeedTab.agroConnect)
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 3,
                              width: 200, // Indicator width
                              color: _activeTabColor, // Use custom active color
                            ),
                          if (_selectedTab == SocialFeedTab.farmingGuide)
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              height: 3,
                              width: 200, // Indicator width
                              color: Colors.grey[100], // Use custom active color
                            ),
                          
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTab = SocialFeedTab.farmingGuide;
                        });
                      },
                      child: Column(
                        children: [
                          Text(
                            'Farming Guide',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _selectedTab == SocialFeedTab.farmingGuide
                                  ? _activeTabColor // Use custom active color
                                  : Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (_selectedTab == SocialFeedTab.farmingGuide)
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 3,
                              width: 215, // Indicator width
                              color: _activeTabColor, // Use custom active color
                            ),
                          if (_selectedTab == SocialFeedTab.agroConnect)
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 3,
                              width: 215, // Indicator width
                              color: Colors.grey[100], // Use custom active color
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // --- Content Area ---
            Expanded(
              child: _selectedTab == SocialFeedTab.agroConnect
                  ? const AgroConnectPostsWidget()
                  : const FarmingGuidePostsWidget(),
            ),
          ],
        ),
      ),
    );
  }
}
