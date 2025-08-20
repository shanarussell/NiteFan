# NiteFan 🌙💨

A peaceful iOS app that helps you sleep better with soothing fan sounds and ambient noise.

## Features

- 🌀 **4 Different Fan Sounds** - Various fan types to suit your preference
- 🌧️ **Ambient Sounds** - Rain, wobble, and click sounds for variety
- 🎬 **Animated Fan Graphics** - Visual feedback with rotating fan animations
- 🔇 **Quick Mute** - Instantly silence all sounds with one tap
- 📱 **Background Playback** - Continues playing when screen is off or app is in background
- 🌃 **Night-Friendly Interface** - Dark starry background perfect for bedtime

## Requirements

- iOS 15.0+
- iPhone (optimized for iPhone, works on iPad)
- Xcode 15.0+ (for development)

## Installation

### For Users
The app will be available on the App Store (coming soon).

### For Developers
1. Clone the repository:
   ```bash
   git clone https://github.com/shanarussell/NiteFan.git
   ```
2. Open the project in Xcode:
   ```bash
   cd NiteFan
   open NiteFan/NiteFan.xcodeproj
   ```
3. Build and run on your device or simulator

## Recent Updates (v2.0)

### 🎨 Modern iOS UI Redesign
- ✨ **Completely redesigned interface** with iOS 17+ design language
- 🌓 **Full dark/light mode support** with dynamic colors
- 📱 **SF Symbols** replacing all PNG icons for crisp, scalable graphics
- 🎭 **Glass morphism effects** with blur and transparency
- 📳 **Haptic feedback** for all interactions
- 🎬 **Smooth animations** including fade in/out for audio
- ⭐ **Animated starfield background** with twinkling stars
- 🌀 **Custom fan animations** using Core Animation

### Critical Fixes (v1.53)
- ✅ Updated to iOS 15.0 minimum deployment target for modern iOS support
- ✅ Added Privacy Manifest (PrivacyInfo.xcprivacy) for App Store compliance
- ✅ Fixed memory leaks in audio player management
- ✅ Refactored code to eliminate duplication
- ✅ Added proper error handling with user feedback

### Code Improvements
- Programmatic UI with ModernViewController
- Dynamic color system for automatic dark/light mode switching
- Haptic feedback generator for tactile responses
- Smooth audio fade transitions
- Custom FanAnimationView with Core Animation
- Preload audio players once instead of recreating them
- Centralized audio management with dictionary storage
- Proper cleanup in deinit to prevent memory leaks
- Modern Swift patterns with MARK comments for organization

## Technical Details

- **Language**: Swift 5
- **UI Framework**: UIKit with Storyboards
- **Audio**: AVFoundation for audio playback
- **Architecture**: MVC (Model-View-Controller)

## Privacy

NiteFan respects your privacy:
- No data collection
- No tracking
- No network requests
- No ads
- Works completely offline

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

Copyright © 2019-2025 HiTechMom. All rights reserved.

## Author

Created by Shana Russell ([@shanarussell](https://github.com/shanarussell))

---

*Sweet dreams! 😴*