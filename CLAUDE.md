# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

NiteFan is a native iOS app built with Swift and UIKit that provides ambient sleep sounds. The app features multiple fan sounds and additional white noise options (rain, wobble, click) with animated fan graphics.

## Architecture and Key Components

### Core Structure
The app follows a simple MVC pattern with storyboard-based UI:
- **ViewController.swift**: Main controller handling all sound playback and UI animations
- **AppDelegate.swift** & **SceneDelegate.swift**: Standard iOS app lifecycle management
- **Storyboards**: Main.storyboard and LaunchScreen.storyboard for UI layout

### Sound System Architecture
- Uses AVFoundation framework for audio playback
- Global AVAudioPlayer instances for each sound (fan1-4, clickSound, rainSound, wobbleSound)
- Audio session configured for background playback (`AVAudioSession.Category.playback`)
- All sounds loop infinitely until stopped (`numberOfLoops = -1`)

### Animation System
- Each fan has an associated UIImageView (imageView1-4)
- Animation frames cycle through fan-graphic-2.png to fan-graphic-7.png
- Animations synchronized with sound playback (start/stop together)

## Development Commands

### Building and Running
```bash
# Open the project in Xcode
open NiteFan/NiteFan.xcodeproj

# Build from command line (requires Xcode Command Line Tools)
xcodebuild -project NiteFan/NiteFan.xcodeproj -scheme NiteFan -configuration Debug build

# Clean build
xcodebuild -project NiteFan/NiteFan.xcodeproj -scheme NiteFan clean

# Build for release
xcodebuild -project NiteFan/NiteFan.xcodeproj -scheme NiteFan -configuration Release build
```

### Running on Simulator
```bash
# List available simulators
xcrun simctl list devices

# Build and run on specific simulator
xcodebuild -project NiteFan/NiteFan.xcodeproj -scheme NiteFan -destination 'platform=iOS Simulator,name=iPhone 15' build
```

### Testing
The project currently has no test targets configured. To add tests:
1. Add a new test target in Xcode
2. Create XCTest cases in the test target

## Project Configuration

### Key Settings
- **Bundle ID**: Configured via `$(PRODUCT_BUNDLE_IDENTIFIER)`
- **Deployment Target**: iOS 13.0
- **Swift Version**: Inferred from Xcode version
- **Supported Orientations**: Portrait only on iPhone, all orientations on iPad
- **Background Modes**: Audio playback enabled

### Asset Organization
All media assets are in `NiteFan/NiteFan/supporting files/`:
- Fan animation frames: `fan-graphic-[1-7].png`
- Sound files: `fan[1-4].mp3`, `click.m4r`, `rain.m4r`, `wobble.m4r`
- UI elements: `green-*.png` button graphics
- Background: `stars.jpg`

## Common Development Tasks

### Adding New Sound Effects
1. Add the sound file to `supporting files/` directory
2. Include it in the Xcode project via File Navigator
3. Create a global AVAudioPlayer variable in ViewController.swift
4. Implement play/stop methods following the existing pattern
5. Connect to UI buttons via IBAction methods

### Modifying Fan Animations
1. Replace or add animation frames in `supporting files/`
2. Update the `animationImages` array in `viewDidLoad()` for the relevant imageView
3. Adjust animation timing if needed via `animationDuration` property

### UI Modifications
1. Open Main.storyboard in Interface Builder
2. Maintain IBOutlet connections when modifying UI elements
3. Update Auto Layout constraints to support different screen sizes

## Important Notes

- The app relies on storyboard connections - verify all IBOutlet and IBAction connections when making UI changes
- Sound files must be included in the app bundle's Copy Bundle Resources build phase
- Background audio capability requires the audio background mode in Info.plist
- The project uses manual memory management for audio players - ensure proper cleanup if modifying