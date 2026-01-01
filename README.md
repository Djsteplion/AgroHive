### AgroHive 🌾
An Offline-First Mobile Solution for Agricultural Management in Connectivity-Challenged Regions.

### 📌 Project Overview
AgroHive was developed to bridge the digital gap for farmers in remote areas where internet connectivity is either unstable or non-existent ("Data Deserts"). It serves as a comprehensive tool for equipment management, peer-to-peer knowledge sharing, and agricultural tracking.

This project was built from the ground up—transitioning from a Figma design to a functional Flutter prototype—with a primary focus on Data Persistence and User Experience (UX).

### 🚀 Key Features
Offline-First Architecture: Full functionality without an internet connection, utilizing local storage for all user data and interactions.

Tool Marketplace: A platform for farmers to buy, list, and post advanced modern-day agricultural tools.

Knowledge Hub: A community-driven section for sharing farming tips and best practices;learn about and share effective farming pratices, incidents and best management pratices for agricultural devices.

Custom UI/UX: Pixel-perfect implementation based on a professional Figma design, optimized for high readability in outdoor/field environments.

### 🛠 Technical Implementation & Tradeoffs
As an engineer, I made several deliberate choices to prioritize the needs of the end-user over traditional development shortcuts:

Local Persistence vs. Cloud Sync: *Decision: Chose to implement a robust local database strategy over cloud-native solutions.

Tradeoff: While this limits real-time global syncing, it ensures 100% uptime in deep rural areas where "Real-time" is impossible.

State Management (Provider): *Utilized Provider  to ensure a predictable state container, which is critical when handling complex local data streams and media uploads (photos of tools).

Custom Widget Engineering: *Rather than using standard Material UI, I built custom Flutter widgets to match the specific Figma design requirements, ensuring the app felt premium and intuitive for non-technical users.

### 💻 Tech Stack
Framework: Flutter

Language: Dart

State Management: Provider

Design Tool: Figma (Collaboration with [Bolu: https://www.figma.com/design/QAIoEa0lvXoO19JNNDSALp/Bolu?t=aJoSkoiKNFNAPPBp-0])

Local Storage: Sqflite 

### 📈 Learning Journey
Building AgroHive was my primary vehicle for mastering mobile development. It taught me:

How to architect an app for low-connectivity environments.

The complexities of the Flutter widget lifecycle.

The importance of translating high-fidelity designs into performance-optimized code.
