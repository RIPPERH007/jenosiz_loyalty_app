# Jenosize Loyalty App 📱

A Flutter mobile application prototype for an AI-powered loyalty platform designed for SMEs, built for Jenosize assignment.

## 🎬 Demo

📹 Watch Full Demo Video

> **[🎥 Complete App Demo - Version 1](https://www.dropbox.com/scl/fi/sm119rfnc8hpofbl8izud/Screen-Recording-2568-08-07-at-13.02.51.mov?rlkey=s523vfa9gsq0sxm5j5dvwd693&st=dw3hz4fw&dl=0)**
>
> **[🎥 Complete App Demo - Version 2](https://www.dropbox.com/scl/fi/5i11u2bd1d6zciw24rpn3/Screen-Recording-2568-08-07-at-12.50.49.mov?rlkey=ah5kromtn7a9udng7pvj0fvnr&st=sgd7frr9&dl=0)**


## 🎯 Features

### Core Functionality
- **Campaign List** - Browse and join 6 loyalty campaigns
- **Membership System** - Join membership with 100 points welcome bonus
- **Referral Program** - Generate and share referral codes
- **Points Tracker** - View points balance and transaction history

### Enhanced UX
- Smooth animations and haptic feedback
- Real-time state updates
- Pull-to-refresh functionality
- Persistent data storage

## 🏗️ Technical Stack

- **Framework**: Flutter 3.10+
- **Language**: Dart 3.0+
- **Architecture**: Clean Architecture with BLoC pattern
- **State Management**: flutter_bloc
- **Local Storage**: SharedPreferences
- **UI**: Material Design 3

## 🚀 Getting Started

### Prerequisites
```bash
flutter --version  # Flutter 3.10.0 or higher
```

### Installation
```bash
# Clone and setup
git clone [your-repo-url]
cd jenosize_loyalty_app

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 📱 App Structure

```
lib/
├── core/           # Constants, themes, utilities
├── data/           # Models, repositories, mock data
├── presentation/   # UI screens, widgets, BLoC
└── main.dart      # App entry point
```

## 🎮 Demo Flow

1. **Home** → View campaigns → Join campaigns (+points)
2. **Membership** → Join membership → Get welcome bonus
3. **Referral** → Share referral code → Earn referral bonus
4. **Points** → Track points and transaction history

## 🧪 Testing

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage
```

## 📋 Assignment Requirements ✅

| Requirement | Status | Implementation |
|-------------|---------|----------------|
| Campaign List (4-6 items) | ✅ | 6 diverse campaigns with join functionality |
| Membership System | ✅ | Join membership + welcome message |
| Referral System | ✅ | Generate & share referral codes |
| Points Tracker | ✅ | Real-time points + transaction history |
| Clean Architecture | ✅ | Modular structure with BLoC pattern |
| State Management | ✅ | BLoC for reactive state handling |
| Local Storage | ✅ | SharedPreferences for persistence |
| Modern UI | ✅ | Material Design 3 with animations |

## 🎨 Key Highlights

- **Smooth UX**: No loading screens during campaign joins
- **Persistent State**: Data survives app restarts
- **Visual Feedback**: Button states, haptic feedback, animations
- **Clean Code**: SOLID principles, comprehensive error handling
- **Production Ready**: Testing, documentation, scalable architecture

## 👨‍💻 Developer

Built with ❤️ for Jenosize Digital Opportunity Creator

---

**Tech Stack**: Flutter • Dart • BLoC • Material Design 3

